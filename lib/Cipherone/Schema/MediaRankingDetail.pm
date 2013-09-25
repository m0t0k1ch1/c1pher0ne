package Cipherone::Schema::MediaRankingDetail;
use Mouse;
extends 'Cipherone::Schema';

has _table => (
    is      => 'ro',
    default => 'media_ranking_detail'
);

__PACKAGE__->meta->make_immutable;

no Mouse;

1;
