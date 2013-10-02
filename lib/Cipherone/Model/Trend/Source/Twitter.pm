package Cipherone::Model::Trend::Source::Twitter;
use Mouse;

extends 'Cipherone::Model::Trend::Source';
with (
    'Cipherone::Role::Config',
    'Cipherone::Role::Twitter',
    'Cipherone::Model::Trend::Role::Source',
);

__PACKAGE__->meta->make_immutable;

no Mouse;

sub trends {
    my ($self, $woe_id) = @_;
    $woe_id //= $self->config('twitter')->{default_woe_id};

    my $result = $self->twitter->trends_place($woe_id);
    my @trends = map { $_->{name} } @{ $result->[0]->{trends} };

    \@trends;
}

1;
