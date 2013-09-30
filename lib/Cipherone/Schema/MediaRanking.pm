package Cipherone::Schema::MediaRanking;
use Mouse;
extends 'Cipherone::Schema';

has _table => (
    is      => 'ro',
    default => 'media_ranking'
);

__PACKAGE__->meta->make_immutable;

no Mouse;

1;

sub max_id {
    my ($self, $media_type_id) = @_;

    my $itr = $self->teng->search($self->_table, {
        media_type_id => $media_type_id
    }, {order_by => 'id DESC'});

    $itr->next->id;
}
