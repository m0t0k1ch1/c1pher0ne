package Cipherone::Schema::Trend;
use Mouse;
use utf8;

extends 'Cipherone::Schema';

has table => (
    is      => 'ro',
    default => 'trend',
);

__PACKAGE__->meta->make_immutable;

no Mouse;

sub max_id {
    my ($self, $trend_source_id)= @_;

    my $itr = $self->teng->search($self->table, {
        trend_source_id => $trend_source_id,
    }, {
        order_by => 'id DESC',
    });

    my $row = $itr->next;
    $row ? $row->id : 0;
}

1;
