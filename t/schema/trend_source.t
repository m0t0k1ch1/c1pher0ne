use strict;
use warnings;
use utf8;
use FindBin::libs;

use Cipherone;
use Cipherone::Test;
use t::Util;

use Test::More;

my $cipherone    = Cipherone->new;
my $trend_source = $cipherone->schema('TrendSource');

insert_master_data;

subtest 'search_by_name' => sub {
    my $masters = $cipherone->master_data('trend_source');

    for my $master (@{ $masters }) {
        my $row = $trend_source->search_by_name($master->{name});
        ok $row, 'name: ' . $row->name;
        isa_ok $row, 'Teng::Row';
        is $row->id, $master->{id}, 'id: ' . $row->id;
    }
};

done_testing;
