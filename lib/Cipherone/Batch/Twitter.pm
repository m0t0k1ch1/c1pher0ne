package Cipherone::Batch::Twitter;
use Mouse;

use utf8;

with (
    'Cipherone::Role::Bitly',
    'Cipherone::Role::Config',
    'Cipherone::Role::Model',
    'Cipherone::Role::Schema',
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

sub tweet {
    my ($self, $body) = @_;

    $self->twitter->update($body);
}

sub change_image_on {
    my $self = shift;

    $self->twitter->update_profile_image([$self->image_on]);
}

sub change_image_off {
    my $self = shift;

    $self->twitter->update_profile_image([$self->image_off]);
}

sub tweet_trend {
    my $self = shift;

    my $trend_id_max = $self->schema('Trend')->max_id;
    my $trend_detail = $self->schema('TrendDetail')->random($trend_id_max);
    my $adjective    = $self->schema('Adjective')->random;

    my $body = $trend_detail->body . 'って、' . $adjective->body . 'よね';

    my $url         = 'http://google.com/search?q=' . $trend_detail->body;
    my $url_shorten = $self->bitly->shorten($url);

    $self->tweet($body . ' ' . $url_shorten->short_url);
    $trend_detail->update({is_tweet => 1});
}

1;
