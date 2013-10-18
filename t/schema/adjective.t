use strict;
use warnings;
use utf8;
use FindBin::libs;

use Cipherone;
use Cipherone::Test;
use t::Util;

use Test::More;

my $row_num = 10;

for (1..$row_num) {
    insert_adjective;
}

my $cipherone = Cipherone->new;
my $adjective = $cipherone->schema('Adjective');

subtest 'count' => sub {
    my $count = $adjective->count;
    ok $count;
    is $count, $row_num, 'count: ' . $count;
};

subtest 'random' => sub {
    my $row = $adjective->random;
    ok $row;
    isa_ok $row, 'Teng::Row';
};

done_testing;
