package Cipherone::Schema::MediaRankingDetail;
use Mouse;

extends 'Cipherone::Schema';

has table => (
    is      => 'ro',
    default => 'media_ranking_detail'
);

__PACKAGE__->meta->make_immutable;

no Mouse;

sub random {
    my ($self, $media_ranking_id) = @_;

    my $itr = $self->teng->search($self->table, {
        media_ranking_id => $media_ranking_id,
        is_tweet         => 0,
    }, {
        order_by => 'RAND()',
    });

    $itr->next;
}

1;
