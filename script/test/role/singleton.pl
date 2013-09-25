use strict;
use warnings;
use FindBin::libs;

use feature 'say';

use Cipherone;

my $cipherone = Cipherone->new;

say $cipherone->schema;
say $cipherone->schema;

say $cipherone->schema('Adjective');
say $cipherone->schema('Adjective');

say '';

say $cipherone->model;
say $cipherone->model;

say $cipherone->model('MediaRanking');
say $cipherone->model('MediaRanking');
