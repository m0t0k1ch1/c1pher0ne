use strict;
use warnings;
use utf8;
use FindBin::libs;

use Cipherone;
use Cipherone::Test;
use t::Util;

use Test::More;

my $cipherone      = Cipherone->new;
my $media_category = $cipherone->schema('MediaCategory');

my $im_id = 1;

insert_media_category({
    im_id => $im_id,
});

subtest 'search_by_id' => sub {
    my $id = 1;

    my $row = $media_category->search_by_id($id);
    ok $row;
    isa_ok $row, 'Teng::Row';
    is $row->id, $id, 'id: ' . $row->id;
};

subtest 'search_by_im_id' => sub {
    my $row = $media_category->search_by_id($im_id);
    ok $row;
    isa_ok $row, 'Teng::Row';
    is $row->im_id, $im_id, 'im_id: ' . $row->im_id;
};

done_testing;
