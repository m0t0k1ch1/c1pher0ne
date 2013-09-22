package Cipherone::Model;
use Mouse;

with (
    'Cipherone::Util::Role::Singleton',
);

__PACKAGE__->meta->make_immutable;

no Mouse;

1;
