package Cipherone::Batch::Twitter::Trend;
use Mouse;
use utf8;

extends 'Cipherone::Batch::Twitter',
with (
    'Cipherone::Role::Bitly',
    'Cipherone::Role::Schema',
);

has _tweet_text => (
    is      => 'rw',
    default => '__trend__って、__adjective__よね __url__',
);

__PACKAGE__->meta->make_immutable;

no Mouse;

sub tweet {
    my ($self, $trend_source_name) = @_;

    my $trend_source = $self->schema('TrendSource')->search_by_name($trend_source_name);
    my $trend_id     = $self->schema('Trend')->max_id($trend_source->id);
    my $trend_detail = $self->schema('TrendDetail')->random($trend_id);
    my $adjective    = $self->schema('Adjective')->random;

    my $text = $self->tweet_text($self->_tweet_text, {
        trend     => $trend_detail->body,
        adjective => $adjective->body,
        url       => $self->bitly->shorten('http://google.com/search?q=' . $trend_detail->body)->short_url,
    });

    $self->twitter->update($text);
    $trend_detail->update({is_tweet => 1});
}

1;
