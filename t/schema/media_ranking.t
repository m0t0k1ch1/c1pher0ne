use strict;
use warnings;
use utf8;
use FindBin::libs;

use Cipherone;
use Cipherone::Test;
use t::Util;

use Test::More;

my $cipherone     = Cipherone->new;
my $media_ranking = $cipherone->schema('MediaRanking');

my $media_type_id = 1;
my $row_num       = 10;

for (1..$row_num) {
    insert_media_ranking({
        media_type_id => $media_type_id,
    });
}

subtest 'max_id' => sub {
    ok !$media_ranking->max_id(0);

    my $max_id = $media_ranking->max_id($media_type_id);
    ok $max_id;
    is $max_id, $row_num, 'max_id: ' . $max_id;
};

done_testing;
