package Cipherone::Schema::RemindMessage;
use Mouse;

extends 'Cipherone::Schema';

has _table => (
    is      => 'ro',
    default => 'remind_message',
);

__PACKAGE__->meta->make_immutable;

no Mouse;

1;
