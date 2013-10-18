use strict;
use warnings;
use utf8;
use FindBin::libs;

use Cipherone;
use Cipherone::Test;
use t::Util;

use Test::More;

my $cipherone            = Cipherone->new;
my $media_ranking_detail = $cipherone->schema('MediaRankingDetail');

my $media_ranking_id = 1;

for (1..10) {
    insert_media_ranking_detail({
        media_ranking_id => $media_ranking_id,
    });
}

subtest 'random' => sub {
    my $row = $media_ranking_detail->random($media_ranking_id);
    ok $row;
    isa_ok $row, 'Teng::Row';
    is $row->media_ranking_id, $media_ranking_id, 'media_ranking_id: ' . $row->media_ranking_id;
};

done_testing;
