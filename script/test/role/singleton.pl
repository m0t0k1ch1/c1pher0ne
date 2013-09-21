use strict;
use warnings;
use FindBin::libs;

use feature 'say';

use Cipherone;

my $cipherone = Cipherone->new;

say $cipherone->schema;
say $cipherone->schema;

say $cipherone->schema('Country');
say $cipherone->schema('Country');

say '';

say $cipherone->model;
say $cipherone->model;

say $cipherone->model('MediaRanking');
say $cipherone->model('MediaRanking');
