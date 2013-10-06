use strict;
use warnings;
use utf8;
use FindBin::libs;

use feature 'say';

use Cipherone;

use AnyEvent::Twitter::Stream;

my $cipherone      = Cipherone->new;
my $twitter_config = $cipherone->config('twitter');

my $cv = AE::cv;

my $stream = AnyEvent::Twitter::Stream->new(
    consumer_key    => $twitter_config->{consumer_key},
    consumer_secret => $twitter_config->{consumer_secret},
    token           => $twitter_config->{access_token},
    token_secret    => $twitter_config->{access_token_secret},
    method => 'filter',
    track  => '@c1pher0ne',
    on_tweet => sub {
        my $tweet = shift;

        say $tweet->{user}->{name} . '：' . $tweet->{text};
    },
    on_error => sub {
        my $message = shift;

        say "ERROR: ${message}";
        $cv->send;
    },
);

$cv->recv;
