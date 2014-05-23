package Cipherone::Daemon::Twitter;
use Mouse;
use utf8;
use feature 'say';

extends 'Cipherone::Daemon';
with (
    'Cipherone::Role::Twitter',
    'Cipherone::Role::Schema',
);

use AnyEvent::Twitter::Stream;
use DateTime;
use File::Basename;
use JSON;

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

sub track_mentions {
    my $self = shift;

    my $twitter_config = $self->config('twitter');
    my $json_str       = '';

    my $cv = AE::cv;

    say 'Ready to connect';

    my $stream = AnyEvent::Twitter::Stream->new(
        consumer_key    => $twitter_config->{consumer_key},
        consumer_secret => $twitter_config->{consumer_secret},
        token           => $twitter_config->{access_token},
        token_secret    => $twitter_config->{access_token_secret},
        method          => 'filter',
        track           => '@' . $self->screen_name,
        no_decode_json  => 1,
        on_connect => sub {
            say 'Connected';
        },
        on_keepalive => sub {
            say 'Keep alive';
        },
        on_tweet => sub {
            my $tweet_str = shift;
            $json_str .= $tweet_str;
            if (substr($tweet_str, -1) eq "\n") {
                my $tweet;
                try {
                    $tweet = JSON::decode_json($json_str);
                } catch {
                    say "Can't decode";
                };
                if ($tweet) {
                    $self->response($tweet);
                }
                $json_str = '';
            }
        },
        on_error => sub {
            my $message = shift;
            say $message;
            $cv->send;
        },
        on_eof => sub {
            $cv->send;
        },
    );

    $cv->recv;

    die 'Die';
}

1;
