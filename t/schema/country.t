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
    my $masters = $cipherone->master_data('country');

    for my $master (@{ $masters }) {
        my $row = $country->search_by_name($master->{name});
        ok $row, 'name: ' . $row->name;
        isa_ok $row, 'Teng::Row';
        is $row->id, $master->{id}, 'id: ' . $row->id;
    }
};

done_testing;
