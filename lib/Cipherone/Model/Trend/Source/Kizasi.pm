package Cipherone::Model::Trend::Source::Kizasi;
use Mouse;

extends 'Cipherone::Model::Trend::Source';
with 'Cipherone::Model::Trend::Role::Source';

use LWP::UserAgent;
use XML::Simple;

has api_url => (
    is      => 'rw',
    default => 'http://kizasi.jp/kizapi.py?type=rank',
);

__PACKAGE__->meta->make_immutable;

no Mouse;

sub trends {
    my $self = shift;

    my $user_agent = LWP::UserAgent->new;
    my $xml        = XML::Simple->new;

    my $res  = $user_agent->get($self->api_url);
    my $data = $xml->XMLin($res->content);

    my @trends = map { $_->{title} } @{ $data->{channel}->{item} };

    \@trends;
}

1;
