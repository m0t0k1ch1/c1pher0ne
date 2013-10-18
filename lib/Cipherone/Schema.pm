package Cipherone::Schema;
use Mouse;
use utf8;

with (
    'Cipherone::Role::Config',
    'Cipherone::Role::Singleton',
);

use DateTime;
use DBI;
use Teng;
use Teng::Schema::Loader;

__PACKAGE__->meta->make_immutable;

no Mouse;

our $dbh;
our $teng;

sub now {
    DateTime->now(time_zone => 'local');
}

sub dbh {
    my $self = shift;

    if ($dbh) {
        $dbh;
    }
    else {
        if ($ENV{TEST_DSN}) {
            $dbh = DBI->connect($ENV{TEST_DSN});
        }
        else {
            my $mysql_config = $self->config('mysql');

            $dbh = DBI->connect(
                'dbi:mysql:' . $mysql_config->{db_name},
                $mysql_config->{user},
                $mysql_config->{password},
                {
                    'mysql_enable_utf8' => 1,
                },
            );
        }
    }
}

sub teng {
    my $self = shift;

    if ($teng) {
        $teng;
    }
    else {
        if ($ENV{TEST_DSN}) {
            $self->create_tables;
        }

        $teng = Teng::Schema::Loader->load(
            dbh       => $self->dbh,
            namespace => 'Cipherone::DB',
        );

        $teng->load_plugin('Count');

        $teng;
    }
}

sub create_tables {
    my $self = shift;

    my $dbh = $self->dbh;

    $dbh->do(q/
        CREATE TABLE IF NOT EXISTS adjective (
            id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
            body TEXT NOT NULL
        )
    /);

    $dbh->do(q/
        CREATE TABLE IF NOT EXISTS country (
            id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
            name TEXT NOT NULL
        )
    /);

    $dbh->do(q/
        CREATE TABLE IF NOT EXISTS media_category (
            id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
            im_id INT UNSIGNED NOT NULL,
            name TEXT NOT NULL,
            url TEXT NOT NULL
        )
    /);

    $dbh->do(q/
        CREATE TABLE IF NOT EXISTS media_ranking (
            id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
            country_id INT UNSIGNED NOT NULL,
            media_type_id INT UNSIGNED NOT NULL,
            created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
    /);

    $dbh->do(q/
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

    $dbh->do(q/
        CREATE TABLE IF NOT EXISTS media_type (
            id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
            name TEXT NOT NULL
        )
    /);

    $dbh->do(q/
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

    $dbh->do(q/
        CREATE TABLE IF NOT EXISTS trend (
            id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
            trend_source_id INT UNSIGNED NOT NULL,
            created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
    /);

    $dbh->do(q/
        CREATE TABLE IF NOT EXISTS trend_detail (
            id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
            trend_id INT UNSIGNED NOT NULL,
            body TEXT NOT NULL,
            is_tweet TINYINT UNSIGNED NOT NULL DEFAULT 0
        )
    /);

    $dbh->do(q/
        CREATE TABLE IF NOT EXISTS trend_source (
            id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
            name TEXT NOT NULL
        )
    /);

    $dbh->do(q/
        CREATE INDEX media_category_im_id
        ON media_category (im_id);
    /);

    $dbh->do(q/
        CREATE INDEX media_ranking_media_type_id
        ON media_ranking (media_type_id);
    /);

    $dbh->do(q/
        CREATE INDEX media_ranking_detail_media_ranking_id_and_is_tweet
        ON media_ranking_detail (media_ranking_id, is_tweet);
    /);

    $dbh->do(q/
        CREATE INDEX remind_message_status_id
        ON remind_message (status_id);
    /);

    $dbh->do(q/
        CREATE INDEX remind_message_remind_date_and_is_tweet
        ON remind_message (remind_date, is_tweet);
    /);

    $dbh->do(q/
        CREATE INDEX trend_detail_trend_id_and_is_tweet
        ON trend_detail (trend_id, is_tweet);
    /);
}

sub insert_master_data {
    my $self = shift;

    my $master_data = $self->master_data;

    for my $table (keys %{ $master_data }) {
        for my $row (@{ $master_data->{$table} }) {
            $self->teng->insert($table => $row);
        }
    }
}

sub insert {
    my ($self, $attr) = @_;

    $self->teng->insert($self->table => $attr);
}

1;
