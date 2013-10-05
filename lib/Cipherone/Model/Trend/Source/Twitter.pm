package Cipherone::Model::Trend::Source::Twitter;
use Mouse;
use utf8;

extends 'Cipherone::Model::Trend::Source';
with (
    'Cipherone::Role::Config',
    'Cipherone::Role::Twitter',
    'Cipherone::Model::Trend::Role::Source',
);

has woe_id_default => (
    is      => 'rw',
    default => 23424856, # japan
);

__PACKAGE__->meta->make_immutable;

no Mouse;

sub trends {
    my ($self, $woe_id) = @_;
    $woe_id //= $self->woe_id_default;

    my $result = $self->twitter->trends_place($woe_id);
    my @trends = map { $_->{name} } @{ $result->[0]->{trends} };

    \@trends;
}

1;
