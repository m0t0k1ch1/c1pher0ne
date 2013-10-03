use strict;
use warnings;
use utf8;
use FindBin::libs;

use Cipherone;
use Cipherone::Test;
use t::Util;

use Test::More;

insert_master_data;

my $cipherone    = Cipherone->new;
my $trend_source = $cipherone->schema('TrendSource');

subtest 'search_by_name' => sub {
    my $master = $cipherone->master_data('trend_source')->[0];

    ok my $row = $trend_source->search_by_name($master->{name});
    isa_ok $row, 'Teng::Row';
    is $row->id, $master->{id};
};

done_testing;
