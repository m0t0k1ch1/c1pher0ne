package Cipherone::Schema::TrendDetail;
use Mouse;
extends 'Cipherone::Schema';

has _table => (
    is      => 'ro',
    default => 'trend_detail',
);

__PACKAGE__->meta->make_immutable;

no Mouse;

1;
