use strict;
use warnings;
use FindBin::libs;

use Cipherone;

use Data::Dumper;

my $cipherone = Cipherone->new;

my $row;

$row = $cipherone->schema('MediaType')->search_by_name('topsongs');
warn Dumper $row->get_columns;

$row = $cipherone->schema('MediaType')->search_by_name('topmovies');
warn Dumper $row->get_columns;
