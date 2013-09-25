use strict;
use warnings;
use utf8;
use FindBin::libs;

use Cipherone;

my $cipherone = Cipherone->new;
my $teng      = $cipherone->schema->teng;

my $countries = $cipherone->config->{master_data}->{country};
for my $country (@{ $countries }) {
    $teng->insert(country => {
        id   => $country->{id},
        name => $country->{name},
    });
}
