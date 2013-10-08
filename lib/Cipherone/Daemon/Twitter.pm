package Cipherone::Daemon::Twitter;
use Mouse;
use utf8;

extends 'Cipherone::Daemon';
with 'Cipherone::Role::Twitter';

use AnyEvent::Twitter::Stream;
use File::Basename;

my $response_name_base = 'Cipherone::Batch::Twitter::Stream::Response';

my @files = glob 'lib/Cipherone/Batch/Twitter/Stream/Response/*';
for my $file (@files) {
    my $response_name_tail = fileparse $file, '.pm';
    my $response_name      = "${response_name_base}::${response_name_tail}";
    eval "use ${response_name}";
}

__PACKAGE__->meta->make_immutable;

no Mouse;

sub _response {
    my ($self, $name) = @_;

    my $response_name = 'Cipherone::Batch::Twitter::Stream::Response';
    if ($name) {
        my $response_name .= $name;
    }

    $response_name->instance;
}

sub response {
    my ($self, $tweet);

    my @hash_tags = map { $_->{text} } @{ $tweet->{entities}->{hashtags} };

    if (grep { $_ eq 'remind' } @hash_tags) {
        $self->_response('RemindMessage')->response($tweet);
    }
}

sub streaming {
    my $self = shift;

    my $twitter_config = $self->config('twitter');

    my $cv = AE::cv;

    my $stream = AnyEvent::Twitter::Stream->new(
        consumer_key    => $twitter_config->{consumer_key},
        consumer_secret => $twitter_config->{consumer_secret},
        token           => $twitter_config->{access_token},
        token_secret    => $twitter_config->{access_token_secret},
        method => 'filter',
        track  => '@' . $self->screen_name,
        on_tweet => sub {
            my $tweet = shift;

            $self->_response($tweet);
        },
        on_error => sub {
            my $message = shift;

            warn "ERROR: ${message}";
            $cv->send;
        },
    );

    $cv->recv;

    die;
}

1;
