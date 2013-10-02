package Cipherone::Schema::MediaCategory;
use Mouse;

extends 'Cipherone::Schema';

has table => (
    is      => 'ro',
    default => 'media_category',
);

__PACKAGE__->meta->make_immutable;

no Mouse;

sub search_by_id {
    my ($self, $id) = @_;

    $self->teng->single($self->_table, {
        id => $id,
    });
}

sub search_by_im_id {
    my ($self, $im_id) = @_;

    $self->teng->single($self->_table, {
        im_id => $im_id,
    });
}

1;
