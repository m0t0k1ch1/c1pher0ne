use strict;
use warnings;
use utf8;
use FindBin::libs;

use Cipherone;
use Cipherone::Test;
use t::Util;

use Test::More;

insert_master_data;

my $cipherone = Cipherone->new;
my $country   = $cipherone->schema('Country');

subtest 'search_by_name' => sub {
    my $master = $cipherone->master_data('country')->[0];

    my $row = $country->search_by_name($master->{name});
    ok $row;
    isa_ok $row, 'Teng::Row';
    is $row->id, $master->{id};
};

done_testing;
