use strict;
use warnings;
use utf8;
use FindBin::libs;

use Cipherone;
use Cipherone::Test;
use t::Util;

use Test::More;

my $media_type_id = 1;
my $row_count     = 10;

for (1..$row_count) {
    insert_media_ranking($media_type_id);
}

my $cipherone     = Cipherone->new;
my $media_ranking = $cipherone->schema('MediaRanking');

subtest 'max_id' => sub {
    my $max_id = $media_ranking->max_id($media_type_id);
    ok $max_id;
    is $max_id, $row_count, 'max_id: ' . $max_id;
};

done_testing;
