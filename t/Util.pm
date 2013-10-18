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
);

my $cipherone = Cipherone->new;

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
        body => _make_random_string((int rand 10) + 1),
    });
}

sub insert_media_category {
    my $im_id = shift;

    $cipherone->schema('MediaCategory')->insert({
        im_id => $im_id,
        name  => _make_random_string((int rand 10) + 1),
    });
}

sub insert_media_ranking {
    my $media_type_id = shift;

    $cipherone->schema('MediaRanking')->insert({
        media_type_id => $media_type_id,
    });
}

1;
