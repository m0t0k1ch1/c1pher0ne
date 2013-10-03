package Cipherone::Batch::Trend;
use Mouse;
use utf8;

extends 'Cipherone::Batch';

__PACKAGE__->meta->make_immutable;

no Mouse;

sub register {
    my ($self, $trend_source_name) = @_;

    my $cipherone = $self->cipherone;

    my $trend_source = $cipherone->schema('TrendSource')->search_by_name($trend_source_name)
        // die 'invalid trend_souce';

    my $trend_source_id = $trend_source->id;
    my $results         = $cipherone->model('Trend')->get($trend_source_id);

    my $trend = $cipherone->schema('Trend')->insert({
        trend_source_id => $trend_source_id,
    });

    for my $result (@{ $results }) {
        $cipherone->schema('TrendDetail')->insert({
            trend_id => $trend->id,
            body     => $result,
        });
    }
}

1;
