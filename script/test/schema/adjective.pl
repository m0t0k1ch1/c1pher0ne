use strict;
use warnings;
use FindBin::libs;

use feature 'say';

use Cipherone;

my $cipherone = Cipherone->new;

say $cipherone->schema('Adjective')->count;
say $cipherone->schema('Adjective')->random;
