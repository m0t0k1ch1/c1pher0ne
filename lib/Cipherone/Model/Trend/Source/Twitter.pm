package Cipherone::Model::Trend::Source::Twitter;
use Mouse;
extends 'Cipherone::Model';

with 'Cipherone::Model::Trend::Role::Source';

sub trends {
    my ($self, $woe_id) = @_;
    $woe_id //= $self->config->{twitter}->{default_woe_id};

    my $result = $self->twitter->trends_place($woe_id);

    my @trends;
    for my $trend (@{ $result->[0]->{trends} }) {
        push @trends, $trend->{name};
    }

    \@trends;
}

__PACKAGE__->meta->make_immutable;

no Mouse;

1;
