package Cipherone::Model::Trend;
use Mouse;

extends 'Cipherone::Model';

use Cipherone::Model::Trend::Source::Kizasi;
use Cipherone::Model::Trend::Source::Twitter;

has _sources => (
    is         => 'rw',
    lazy_build => 1,
);

sub _build__sources {
    my $self = shift;

    my $trend_sources = $self->master_data('trend_source');

    my %sources;
    for my $trend_source (@{ $trend_sources }) {
        my $source_name
            = 'Cipherone::Model::Trend::Source::' . $trend_source->{name};

        $sources{$trend_source->{id}} = $source_name->instance;
    }

    $self->_sources(\%sources);
}

__PACKAGE__->meta->make_immutable;

no Mouse;

sub get {
    my ($self, $trend_source_id) = @_;

    $self->_sources->{$trend_source_id}->trends;
}

1;
