package Cipherone;
use Mouse;

with (
    'Cipherone::Role::Schema',
    'Cipherone::Role::Model',
);

use Cipherone::Schema;

has config => (
    is      => 'rw',
    default => sub {
        do 'config.pl' || die $!;
    },
);

__PACKAGE__->meta->make_immutable;

no Mouse;

1;
