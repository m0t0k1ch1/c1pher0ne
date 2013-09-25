package Cipherone::Batch::Trend;
use Mouse;

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

    my $teng = $self->schema->teng;

    my $trend_source_id = $trend_source->get_column('id');
    my $results         = $self->model('Trend')->get($trend_source_id);

    my $trend = $teng->insert(trend => {
        trend_source_id => $trend_source_id,
    });

    for my $result (@{ $results }) {
        $teng->insert(trend_detail => {
            trend_id => $trend->id,
            body     => $result,
        });
    }
}

1;
