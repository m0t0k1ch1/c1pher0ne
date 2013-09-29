use strict;
use warnings;
use FindBin::libs;

use Cipherone;

my $cipherone = Cipherone->new;
my $teng      = $cipherone->schema->teng;

$teng->do(q{
    CREATE TABLE adjective (
        id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
        body TEXT NOT NULL
    )
});

$teng->do(q{
    CREATE TABLE country (
        id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
        name TEXT NOT NULL
    )
});

$teng->do(q{
    CREATE TABLE media_category (
        id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
        im_id INT UNSIGNED NOT NULL,
        name TEXT NOT NULL,
        url TEXT NOT NULL
    )
});

$teng->do(q{
    CREATE TABLE media_ranking (
        id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
        country_id INT UNSIGNED NOT NULL,
        media_type_id INT UNSIGNED NOT NULL,
        created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )
});

$teng->do(q{
    CREATE TABLE media_ranking_detail (
        id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
        media_ranking_id INT UNSIGNED NOT NULL,
        media_category_id INT UNSIGNED NOT NULL,
        rank INT UNSIGNED NOT NULL,
        im_id BIGINT UNSIGNED NOT NULL,
        title TEXT NOT NULL,
        artist TEXT NOT NULL,
        url TEXT NOT NULL,
        image_url TEXT NOT NULL,
        release_date DATETIME NOT NULL,
        is_tweet TINYINT UNSIGNED NOT NULL DEFAULT 0
    )
});

$teng->do(q{
    CREATE TABLE media_type (
        id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
        name TEXT NOT NULL
    )
});

$teng->do(q{
    CREATE TABLE trend (
        id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
        trend_source_id INT UNSIGNED NOT NULL,
        created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )
});

$teng->do(q{
    CREATE TABLE trend_detail (
        id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
        trend_id INT UNSIGNED NOT NULL,
        body TEXT NOT NULL,
        is_tweet TINYINT UNSIGNED NOT NULL DEFAULT 0
    )
});

$teng->do(q{
    CREATE TABLE trend_source (
        id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
        name TEXT NOT NULL
    )
});
