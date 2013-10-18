use strict;
use warnings;
use utf8;
use FindBin::libs;

use Cipherone;
use Cipherone::Test;
use t::Util;

use Test::More;

my $cipherone = Cipherone->new;
my $trend     = $cipherone->schema('Trend');

my $trend_source_id = 1;
my $row_num         = 10;

for (1..$row_num) {
    insert_trend({
        trend_source_id => $trend_source_id,
    });
}

subtest max_id => sub {
    ok !$trend->max_id(0);

    my $max_id = $trend->max_id($trend_source_id);
    ok $max_id;
    is $max_id, $row_num, 'max_id: ' . $max_id;
};

done_testing;
