use strict;
use warnings;
use utf8;
use FindBin::libs;

use Cipherone;

my $cipherone = Cipherone->new;
$cipherone->schema->create_tables;
