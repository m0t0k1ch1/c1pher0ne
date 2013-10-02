use strict;
use warnings;
use FindBin::libs;

use Cipherone;

my $cipherone = Cipherone->new;
my $teng      = $cipherone->schema->teng;

$teng->do(q/
    CREATE TABLE IF NOT EXISTS adjective (
        id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
        body TEXT NOT NULL
    )
/);

$teng->do(q/
    CREATE TABLE IF NOT EXISTS country (
        id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
        name TEXT NOT NULL
    )
/);

$teng->do(q/
    CREATE TABLE IF NOT EXISTS media_category (
        id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
        im_id INT UNSIGNED NOT NULL,
        name TEXT NOT NULL,
        url TEXT NOT NULL
    )
/);

$teng->do(q/
    CREATE TABLE IF NOT EXISTS media_ranking (
        id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
        country_id INT UNSIGNED NOT NULL,
        media_type_id INT UNSIGNED NOT NULL,
        created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )
/);

$teng->do(q/
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
/);

$teng->do(q/
    CREATE TABLE IF NOT EXISTS media_type (
        id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
        name TEXT NOT NULL
    )
/);

$teng->do(q/
    CREATE TABLE IF NOT EXISTS remind_message (
        id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
        status_id BIGINT UNSIGNED NOT NULL,
        screen_name TEXT NOT NULL,
        body TEXT NOT NULL,
        remind_date DATETIME NOT NULL,
        is_tweet TINYINT UNSIGNED NOT NULL DEFAULT 0,
        created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )
/);

$teng->do(q/
    CREATE TABLE IF NOT EXISTS trend (
        id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
        trend_source_id INT UNSIGNED NOT NULL,
        created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )
/);

$teng->do(q/
    CREATE TABLE IF NOT EXISTS trend_detail (
        id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
        trend_id INT UNSIGNED NOT NULL,
        body TEXT NOT NULL,
        is_tweet TINYINT UNSIGNED NOT NULL DEFAULT 0
    )
/);

$teng->do(q/
    CREATE TABLE IF NOT EXISTS trend_source (
        id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
        name TEXT NOT NULL
    )
/);

$teng->do(q/
    CREATE INDEX media_category_im_id
    ON media_category (im_id);
/);

$teng->do(q/
    CREATE INDEX media_ranking_media_type_id
    ON media_ranking (media_type_id);
/);

$teng->do(q/
    CREATE INDEX media_ranking_detail_media_ranking_id_and_is_tweet
    ON media_ranking_detail (media_ranking_id, is_tweet);
/);

$teng->do(q/
    CREATE INDEX remind_message_status_id
    ON remind_message (status_id);
/);

$teng->do(q/
    CREATE INDEX trend_detail_trend_id_and_is_tweet
    ON trend_detail (trend_id, is_tweet);
/);
