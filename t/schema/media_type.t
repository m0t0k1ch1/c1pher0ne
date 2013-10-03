use strict;
use warnings;
use utf8;
use FindBin::libs;

use Cipherone;
use Cipherone::Test;
use t::Util;

use Test::More;

insert_master_data;

my $cipherone  = Cipherone->new;
my $media_type = $cipherone->schema('MediaType');

subtest 'search_by_name' => sub {
    my $master = $cipherone->master_data('media_type')->[0];

    my $row = $media_type->search_by_name($master->{name});
    ok $row;
    isa_ok $row, 'Teng::Row';
    is $row->id, $master->{id};
};

done_testing;
