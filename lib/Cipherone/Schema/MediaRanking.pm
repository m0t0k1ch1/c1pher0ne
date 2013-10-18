package Cipherone::Schema::MediaRanking;
use Mouse;
use utf8;

extends 'Cipherone::Schema';

has table => (
    is      => 'ro',
    default => 'media_ranking'
);

__PACKAGE__->meta->make_immutable;

no Mouse;

1;

sub max_id {
    my ($self, $media_type_id) = @_;

    my $itr = $self->teng->search($self->table, {
        media_type_id => $media_type_id,
    }, {
        order_by => 'id DESC',
    });

    my $row = $itr->next;
    $row ? $row->id : 0;
}
