package Cipherone::Batch::Twitter::Basic;
use Mouse;
use utf8;

extends 'Cipherone::Batch::Twitter',
with 'Cipherone::Role::Model';

has _tweet_text => (
    is      => 'rw',
    default => sub {
        {
            wake_up     => 'おはよう',
            go_to_sleep => 'おやすみ',
        }
    },
);

has profile_image => (
    is      => 'rw',
    default => sub {
        {
            on  => 'static/img/c1pher0ne_on.png',
            off => 'static/img/c1pher0ne_off.png',
        }
    },
);

__PACKAGE__->meta->make_immutable;

no Mouse;

sub tweet {
    my ($self, $tweet_text_type) = @_;

    $self->twitter->update($self->_tweet_text->{$tweet_text_type});
}

sub change_image_on {
    my $self = shift;

    $self->twitter->update_profile_image([$self->profile_image->{on}]);
}

sub change_image_off {
    my $self = shift;

    $self->twitter->update_profile_image([$self->profile_image->{off}]);
}

1;
