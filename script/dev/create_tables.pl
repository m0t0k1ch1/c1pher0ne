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
    CREATE TABLE trend (
        id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
        body TEXT NOT NULL,
        created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )
});

$teng->do(q{
    CREATE TABLE country (
        id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
        name TEXT NOT NULL
    )
});

$teng->do(q{
    CREATE TABLE media_type (
        id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
        name TEXT NOT NULL
    )
});

$teng->do(q{
    CREATE TABLE media_category (
        id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
        im_id SMALLINT UNSIGNED NOT NULL,
        name TEXT NOT NULL,
        url TEXT NOT NULL
    )
});

$teng->do(q{
    CREATE TABLE media_ranking (
        id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
        country_id INT UNSIGNED NOT NULL,
        media_type_id INT UNSIGNED NOT NULL,
        media_category_id INT UNSIGNED NOT NULL,
        rank SMALLINT UNSIGNED NOT NULL,
        im_id BIGINT UNSIGNED NOT NULL,
        title TEXT NOT NULL,
        artist TEXT NOT NULL,
        url TEXT NOT NULL,
        image_url TEXT NOT NULL,
        release_date DATETIME NOT NULL,
        created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )
});
