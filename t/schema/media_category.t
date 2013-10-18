use strict;
use warnings;
use utf8;
use FindBin::libs;

use Cipherone;
use Cipherone::Test;
use t::Util;

use Test::More;

my $im_id = 1;

insert_media_category($im_id);

my $cipherone      = Cipherone->new;
my $media_category = $cipherone->schema('MediaCategory');

subtest 'search_by_id' => sub {
    my $row = $media_category->search_by_id(1);
    ok $row, 'name: ' . $row->name;
    isa_ok $row, 'Teng::Row';
    is $row->id, 1, 'id: ' . $row->id;
};

subtest 'search_by_im_id' => sub {
    my $row = $media_category->search_by_id($im_id);
    ok $row, 'name: ' . $row->name;
    isa_ok $row, 'Teng::Row';
    is $row->im_id, $im_id, 'im_id: ' . $row->im_id;
};

done_testing;
