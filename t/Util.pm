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
    'insert_remind_message',
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
    my $attr = shift;

    $cipherone->schema('MediaCategory')->insert({
        name => _make_random_string(_rand(10)),
        %{ $attr },
    });
}

sub insert_media_ranking {
    my $attr = shift;

    $cipherone->schema('MediaRanking')->insert($attr);
}

sub insert_media_ranking_detail {
    my $attr = shift;

    $cipherone->schema('MediaRankingDetail')->insert({
        title => _make_random_string(_rand(10)),
        %{ $attr },
    });
}

sub insert_remind_message {
    my $attr = shift;

    $cipherone->schema('RemindMessage')->insert({
        body => _make_random_string(_rand(10)),
        %{ $attr },
    });
}

1;
