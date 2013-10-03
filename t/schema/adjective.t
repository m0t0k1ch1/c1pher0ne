use strict;
use warnings;
use utf8;
use FindBin::libs;

use Cipherone;
use Cipherone::Test;
use t::Util;

use Test::More;

my $row_count = 10;

for (1..$row_count) {
    insert_adjective;
}

my $cipherone = Cipherone->new;
my $adjective = $cipherone->schema('Adjective');

subtest 'count' => sub {
    ok my $count = $adjective->count;
    is $count, $row_count;
};

subtest 'random' => sub {
    ok my $row = $adjective->random;
    isa_ok $row, 'Teng::Row';
};

done_testing;
