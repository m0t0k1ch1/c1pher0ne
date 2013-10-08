package Cipherone::Batch::Twitter;
use Mouse;
use utf8;

extends 'Cipherone::Batch';
with 'Cipherone::Role::Twitter';

__PACKAGE__->meta->make_immutable;

no Mouse;

1;
