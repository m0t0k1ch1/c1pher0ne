package Cipherone::Schema::TrendDetail;
use Mouse;

extends 'Cipherone::Schema';

has table => (
    is      => 'ro',
    default => 'trend_detail',
);

__PACKAGE__->meta->make_immutable;

no Mouse;

sub random {
    my ($self, $trend_id) = @_;

    my $itr = $self->teng->search($self->table, {
        trend_id => $trend_id,
        is_tweet => 0,
    }, {
        order_by => 'RAND()',
    });

    $itr->next;
}

1;
