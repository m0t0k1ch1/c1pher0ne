use strict;
use warnings;
use utf8;
use FindBin::libs;

use Cipherone;
use Cipherone::Test;
use t::Util;

use Test::More;

my $cipherone  = Cipherone->new;
my $media_type = $cipherone->schema('MediaType');

insert_master_data;

subtest 'search_by_name' => sub {
    my $masters = $cipherone->master_data('media_type');

    for my $master (@{ $masters }) {
        my $row = $media_type->search_by_name($master->{name});
        ok $row, 'name: ' . $row->name;
        isa_ok $row, 'Teng::Row';
        is $row->id, $master->{id}, 'id: ' . $row->id;
    }
};

done_testing;
