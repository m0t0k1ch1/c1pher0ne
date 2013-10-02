package Cipherone::Schema::Adjective;
use Mouse;

extends 'Cipherone::Schema';

has table => (
    is      => 'ro',
    default => 'adjective',
);

__PACKAGE__->meta->make_immutable;

no Mouse;

sub count {
    my $self = shift;

    $self->teng->count($self->table, '*');
}

sub random {
    my $self = shift;

    my $id = (int rand $self->count) + 1;

    $self->teng->single($self->table, {
        id => $id,
    });
}

1;
