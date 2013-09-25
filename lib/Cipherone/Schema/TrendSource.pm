package Cipherone::Schema::TrendSource;
use Mouse;
extends 'Cipherone::Schema';

has _table => (
    is      => 'ro',
    default => 'trend_source',
);

__PACKAGE__->meta->make_immutable;

no Mouse;

sub search_by_name {
    my ($self, $name) = @_;

    $self->teng->single($self->_table, {name => $name});
}

1;
