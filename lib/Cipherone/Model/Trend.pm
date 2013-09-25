package Cipherone::Model::Trend;
use Mouse;
extends 'Cipherone::Model';

use Cipherone::Model::Trend::Source::Kizasi;
use Cipherone::Model::Trend::Source::Twitter;

has source => (
    is   => 'rw',
    does => 'Cipherone::Model::Trend::Role::Source',
);

__PACKAGE__->meta->make_immutable;

no Mouse;

sub set_source {
    my ($self, $source) = @_;

    my $source_name = "Cipherone::Model::Trend::Source::${source}";

    $self->source($source_name->instance(config => $self->config));
}

sub get_trends {
    my $self = shift;

    $self->source->trends;
}

1;
