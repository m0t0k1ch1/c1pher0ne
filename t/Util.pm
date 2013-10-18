package t::Util;
use parent 'Exporter';

use strict;
use warnings;
use utf8;

use Cipherone;
use Cipherone::Test;

use String::Random;

our @EXPORT = (
    'insert_master_data',
    'insert_adjective',
    'insert_media_category',
    'insert_media_ranking',
    'insert_media_ranking_detail',
);

my $cipherone = Cipherone->new;

sub _rand {
    my $length = shift;

    (int rand $length) + 1;
}

sub _make_random_string {
    my $length = shift;

    my $random_maker = String::Random->new;
    $random_maker->randregex("[A-Za-z0-9]{$length}");
}

sub insert_master_data {
    $cipherone->schema->insert_master_data;
}

sub insert_adjective {
    $cipherone->schema('Adjective')->insert({
        body => _make_random_string(_rand(10)),
    });
}

sub insert_media_category {
    my $im_id = shift;

    $cipherone->schema('MediaCategory')->insert({
        im_id => $im_id,
        name  => _make_random_string(_rand(10)),
    });
}

sub insert_media_ranking {
    my $media_type_id = shift;

    $cipherone->schema('MediaRanking')->insert({
        media_type_id => $media_type_id,
    });
}

sub insert_media_ranking_detail {
    my $media_ranking_id = shift;

    $cipherone->schema('MediaRankingDetail')->insert({
        media_ranking_id => $media_ranking_id,
        title            => _make_random_string(_rand(10)),
    });
}

1;
