use strict;
use warnings;
use utf8;
use FindBin::libs;

use Cipherone;
use Cipherone::Test;
use t::Util;

use Test::More;

my $cipherone    = Cipherone->new;
my $trend_detail = $cipherone->schema('TrendDetail');

my $trend_id = 1;

for my $i (1..10) {
    insert_trend_detail({
        trend_id => $trend_id,
        is_tweet => $i % 2 ? 1 : 0,
    });
}

subtest random => sub {
    my $row = $trend_detail->random($trend_id);
    ok $row;
    isa_ok $row, 'Teng::Row';
    is $row->trend_id, $trend_id, 'trend_id: ' . $trend_id;
    ok !$row->is_tweet, 'is_tweet: ' . $row->is_tweet;
};

done_testing;
