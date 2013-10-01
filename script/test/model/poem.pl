use strict;
use warnings;
use utf8;
use FindBin::libs;

use feature 'say';

use Cipherone::Model::Poem;

my $poem = Cipherone::Model::Poem->new;

say $poem->get_hanamogera(5);
say $poem->get_hanamogera(7);
say $poem->get_hanamogera(5);
say $poem->get_hanamogera(7);
say $poem->get_hanamogera(7);
