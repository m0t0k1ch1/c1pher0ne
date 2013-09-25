package Cipherone::Model::Trend;
use Mouse;
extends 'Cipherone::Model';

use Cipherone::Model::Trend::Source::Kizasi;
use Cipherone::Model::Trend::Source::Twitter;

has sources => (
    is         => 'rw',
    lazy_build => 1,
);

sub _build_sources {
    my $self = shift;

    my $trend_sources = $self->config->{master_data}->{trend_source};

    my %sources;
    for my $trend_source (@{ $trend_sources }) {
        my $source_name
            = 'Cipherone::Model::Trend::Source::' . $trend_source->{name};

        $sources{$trend_source->{id}}
            = $source_name->instance(_config => $self->_config);
    }

    $self->sources(\%sources);
}

__PACKAGE__->meta->make_immutable;

no Mouse;

sub get {
    my ($self, $trend_source_id) = @_;

    $self->sources->{$trend_source_id}->trends;
}

1;
