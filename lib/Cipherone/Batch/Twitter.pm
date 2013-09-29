package Cipherone::Batch::Twitter;
use Mouse;

with (
    'Cipherone::Role::Config',
    'Cipherone::Role::Twitter',
);

has image_on => (
    is      => 'ro',
    default => 'static/img/c1pher0ne_on.png',
);

has image_off => (
    is      => 'ro',
    default => 'static/img/c1pher0ne_off.png',
);

__PACKAGE__->meta->make_immutable;

no Mouse;

sub change_image_on {
    my $self = shift;

    $self->twitter->update_profile_image([$self->image_on]);
}

sub change_image_off {
    my $self = shift;

    $self->twitter->update_profile_image([$self->image_off]);
}

1;
