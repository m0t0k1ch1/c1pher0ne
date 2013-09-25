use strict;
use warnings;
use FindBin::libs;

use Cipherone;

use Data::Dumper;

my $cipherone = Cipherone->new;

my $countries = $cipherone->master_data('country');
for my $country (@{ $countries }) {
    my $row = $cipherone->schema('Country')->search_by_name($country->{name});
    warn Dumper $row->get_columns;
}
