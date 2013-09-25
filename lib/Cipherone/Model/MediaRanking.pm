package Cipherone::Model::MediaRanking;
use Mouse;
extends 'Cipherone::Model';

use JSON qw/decode_json/;
use LWP::UserAgent;

__PACKAGE__->meta->make_immutable;

no Mouse;

sub _build_url {
    my ($self, $media_type, $country, $limit) = @_;

    "https://itunes.apple.com/${country}/rss/${media_type}/limit=${limit}/json";
}

sub _get_entry_summary {
    my ($self, $entry, $media_type) = @_;

    my $url;
    if ($media_type eq 'topsongs') {
        $url = $entry->{'im:collection'}->{link}->{attributes}->{href};
    } elsif ($media_type eq 'topmovies') {
        $url = $entry->{'link'}->[0]->{attributes}->{href};
    }

    {
        category => {
           im_id => $entry->{category}->{attributes}->{'im:id'},
           name  => $entry->{category}->{attributes}->{'term'},
           url   => $entry->{category}->{attributes}->{'scheme'},
        },
        im_id        => $entry->{id}->{attributes}->{'im:id'},
        title        => $entry->{'im:name'}->{label},
        artist       => $entry->{'im:artist'}->{label},
        url          => $url,
        image_url    => $entry->{'im:image'}->[2]->{label},
        release_date => $entry->{'im:releaseDate'}->{label},
    };
}

sub get {
    my ($self, $media_type, $country, $limit) = @_;

    my $url = $self->_build_url($media_type, $country, $limit);

    my $user_agent = LWP::UserAgent->new;
    my $res        = $user_agent->get($url);
    my $data       = decode_json($res->content);

    my $entries = $limit == 1 ? [ $data->{feed}->{entry} ] : $data->{feed}->{entry};

    my @result;

    my $rank = 1;
    for my $entry (@{ $entries }) {
        my $summary = $self->_get_entry_summary($entry, $media_type);
        $summary->{rank} = $rank;

        push @result, $summary;

        $rank++;
    }

    \@result;
}

1;
