package t::Util;
use parent 'Exporter';

use strict;
use warnings;
use utf8;

use Cipherone;
use Cipherone::Test;

use String::Random;

our @EXPORT = (
    'create_adjective',
);

my $cipherone = Cipherone->new;

sub _make_random_string {
    my $length = shift;

    my $random_maker = String::Random->new;
    $random_maker->randregex("[A-Za-z0-9]{$length}")
}

sub create_adjective {
    $cipherone->schema('Adjective')->insert({
        body => _make_random_string((int rand 10) + 1),
    });
}

1;
