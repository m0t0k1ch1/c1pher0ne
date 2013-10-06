package Cipherone::Batch::Trend;
use Mouse;
use utf8;

extends 'Cipherone::Batch';
with (
    'Cipherone::Role::Model',
    'Cipherone::Role::Schema',
);

__PACKAGE__->meta->make_immutable;

no Mouse;

sub register {
    my ($self, $trend_source_name) = @_;

    my $trend_source = $self->schema('TrendSource')->search_by_name($trend_source_name)
        // die 'invalid trend_souce';

    my $trend_source_id = $trend_source->id;
    my $results         = $self->model('Trend')->get($trend_source_id);

    my $trend = $self->schema('Trend')->insert({
        trend_source_id => $trend_source_id,
    });

    for my $result (@{ $results }) {
        $self->schema('TrendDetail')->insert({
            trend_id => $trend->id,
            body     => $result,
        });
    }
}

1;
