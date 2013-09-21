use strict;
use warnings;
use utf8;
use FindBin::libs;

use Cipherone;

my $cipherone = Cipherone->new;
my $teng      = $cipherone->schema->teng;

my @countries = ('jp', 'us');

for my $country (@countries) {
    $teng->insert(country => {
        name => $country,
    });
}
