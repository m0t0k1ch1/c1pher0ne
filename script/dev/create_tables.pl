use strict;
use warnings;
use FindBin::libs;

use Cipherone;

my $cipherone = Cipherone->new;
my $teng      = $cipherone->schema->teng;

$teng->do(q{
    CREATE TABLE IF NOT EXISTS adjective (
        id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
        body TEXT NOT NULL
    )
});

$teng->do(q{
    CREATE TABLE IF NOT EXISTS country (
        id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
        name TEXT NOT NULL
    )
});

$teng->do(q{
    CREATE TABLE IF NOT EXISTS media_category (
        id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
        im_id INT UNSIGNED NOT NULL,
        name TEXT NOT NULL,
        url TEXT NOT NULL
    )
});

$teng->do(q{
    CREATE TABLE IF NOT EXISTS media_ranking (
        id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
        country_id INT UNSIGNED NOT NULL,
        media_type_id INT UNSIGNED NOT NULL,
        created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )
});

$teng->do(q{
    CREATE TABLE IF NOT EXISTS media_ranking_detail (
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
    CREATE TABLE IF NOT EXISTS media_type (
        id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
        name TEXT NOT NULL
    )
});

$teng->do(q{
    CREATE TABLE IF NOT EXISTS remind_message (
        id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
        body TEXT NOT NULL,
        remind_date DATETIME NOT NULL,
        is_tweet TINYINT UNSIGNED NOT NULL DEFAULT 0,
        created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )
});

$teng->do(q{
    CREATE TABLE IF NOT EXISTS trend (
        id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
        trend_source_id INT UNSIGNED NOT NULL,
        created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )
});

$teng->do(q{
    CREATE TABLE IF NOT EXISTS trend_detail (
        id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
        trend_id INT UNSIGNED NOT NULL,
        body TEXT NOT NULL,
        is_tweet TINYINT UNSIGNED NOT NULL DEFAULT 0
    )
});

$teng->do(q{
    CREATE TABLE IF NOT EXISTS trend_source (
        id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
        name TEXT NOT NULL
    )
});
