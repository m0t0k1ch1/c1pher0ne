use strict;
use warnings;
use FindBin::libs;

use Cipherone;

use Data::Dumper;

my $cipherone = Cipherone->new;

my $row;

$row = $cipherone->schema('Country')->search_by_name('jp');
warn Dumper $row->get_columns;

$row = $cipherone->schema('Country')->search_by_name('us');
warn Dumper $row->get_columns;
