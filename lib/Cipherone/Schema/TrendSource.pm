package Cipherone::Schema::TrendSource;
use Mouse;
use utf8;

extends 'Cipherone::Schema';

has table => (
    is      => 'ro',
    default => 'trend_source',
);

__PACKAGE__->meta->make_immutable;

no Mouse;

sub search_by_name {
    my ($self, $name) = @_;

    $self->teng->single($self->table, {
        name => $name,
    });
}

1;
