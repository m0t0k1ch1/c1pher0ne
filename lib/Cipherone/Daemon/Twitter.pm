package Cipherone::Daemon::Twitter;
use Mouse;
use utf8;

extends 'Cipherone::Daemon';
with (
    'Cipherone::Role::Twitter',
    'Cipherone::Role::Schema',
);

use AnyEvent::Twitter::Stream;
use DateTime;
use File::Basename;

my $response_name_base = 'Cipherone::Daemon::Twitter::Response';

my @files = glob 'lib/Cipherone/Daemon/Twitter/Response/*';
for my $file (@files) {
    my $response_name_tail = fileparse $file, '.pm';
    my $response_name      = "${response_name_base}::${response_name_tail}";
    eval "use ${response_name}";
}

__PACKAGE__->meta->make_immutable;

no Mouse;

sub _response {
    my ($self, $name) = @_;

    my $response_name = 'Cipherone::Daemon::Twitter::Response';
    if ($name) {
        $response_name .= "::${name}";
    }

    $response_name->instance;
}

sub response {
    my ($self, $tweet) = @_;

    my @hash_tags = map { $_->{text} } @{ $tweet->{entities}->{hashtags} };

    if (grep { $_ eq 'remind' } @hash_tags) {
        $self->_response('RemindMessage')->response($tweet);
    }
}

sub streaming {
    my $self = shift;

    my $twitter_config = $self->config('twitter');

    my $cv = AE::cv;

    warn $self->schema->now . ': Ready to connect';

    my $stream = AnyEvent::Twitter::Stream->new(
        consumer_key    => $twitter_config->{consumer_key},
        consumer_secret => $twitter_config->{consumer_secret},
        token           => $twitter_config->{access_token},
        token_secret    => $twitter_config->{access_token_secret},
        method => 'filter',
        track  => '@' . $self->screen_name,
        on_connect => sub {
            warn $self->schema->now . ': Connected';
        },
        on_keepalive => sub {
            warn $self->schema->now . ': Keep alive'
        },
        on_tweet => sub {
            my $tweet = shift;
            $self->response($tweet);
        },
        on_error => sub {
            my $message = shift;
            warn $self->schema->now . ': ' . $message;
            $cv->send;
        },
        on_eof => sub {
            $cv->send;
        },
    );

    $cv->recv;

    die $self->schema->now . ': Die';
}

1;
