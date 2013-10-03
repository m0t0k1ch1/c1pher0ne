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
    create_adjective;
}

my $cipherone = Cipherone->new;
my $adjective = $cipherone->schema('Adjective');

subtest 'count' => sub {
    is $adjective->count, $row_count;
};

subtest 'random' => sub {
    isa_ok $adjective->random, 'Teng::Row';
};

done_testing;
