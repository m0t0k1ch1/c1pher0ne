use strict;
use warnings;
use utf8;
use FindBin::libs;

use feature 'say';

use Cipherone;

use Data::Dumper;
use Encode;

my $cipherone = Cipherone->new;
my $twitter   = $cipherone->model('Twitter')->twitter;

test_status($twitter);

sub test_status {
    my $twitter = shift;

    $twitter->update('good afternoon, everyone');
}

sub test_trends_available {
    my $twitter = shift;

    my $trends_available = $twitter->trends_available;
    for my $trend (@{ $trends_available }) {
        say $trend->{country};
        say $trend->{woeid};
        say $trend->{name};
        say $trend->{parentid};
    }
}

sub test_trends_place {
    my $twitter = shift;

    my $results = $twitter->trends_place(23424856);

    for my $result (@{ $results }) {
        my $trends = $result->{trends};
        for my $trend (@{ $trends }) {
            say $trend->{name};
        }
    }
}
