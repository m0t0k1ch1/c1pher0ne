package Cipherone::Schema::Country;
use Mouse;
extends 'Cipherone::Schema';

has table => (
    is      => 'rw',
    default => 'country',
);

__PACKAGE__->meta->make_immutable;

no Mouse;

sub search_by_name {
    my ($self, $name) = @_;

    $self->teng->single($self->table, {name => $name});
}

1;
