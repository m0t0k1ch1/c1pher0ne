package Cipherone::Schema::Trend;
use Mouse;

extends 'Cipherone::Schema';

has table => (
    is      => 'ro',
    default => 'trend',
);

__PACKAGE__->meta->make_immutable;

no Mouse;

sub max_id {
    my $self = shift;

    my $itr = $self->teng->search($self->_table, {}, {
        order_by => 'id DESC',
    });

    $itr->next->id;
}

1;
