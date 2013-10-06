package Cipherone::Batch::MediaRanking;
use Mouse;
use utf8;

extends 'Cipherone::Batch';

__PACKAGE__->meta->make_immutable;

no Mouse;

sub register {
    my ($self, $media_type_name, $country_name, $limit) = @_;

    my $cipherone = $self->cipherone;

    my $media_type = $cipherone->schema('MediaType')->search_by_name($media_type_name)
        // die 'invalid media_type!';

    my $country = $cipherone->schema('Country')->search_by_name($country_name)
        // die 'invalid country!';

    die 'no limit!' unless defined $limit;

    my $results = $cipherone->model('MediaRanking')->get($media_type_name, $country_name, $limit);

    my $media_ranking = $cipherone->schema('MediaRanking')->insert({
        country_id    => $country->id,
        media_type_id => $media_type->id,
    });

    for my $result (@{ $results }) {
        my $media_category =
            $cipherone->schema('MediaCategory')->search_by_im_id($result->{category}->{im_id});

        unless ($media_category) {
            $media_category = $cipherone->schema('MediaCategory')->insert({
                im_id => $result->{category}->{im_id},
                name  => $result->{category}->{name},
                url   => $result->{category}->{url},
            });
        }

        $cipherone->schema('MediaRankingDetail')->insert({
            media_ranking_id  => $media_ranking->id,
            media_category_id => $media_category->id,
            rank              => $result->{rank},
            im_id             => $result->{im_id},
            title             => $result->{title},
            artist            => $result->{artist},
            url               => $result->{url},
            image_url         => $result->{image_url},
            release_date      => $result->{release_date},
        });
    }
}

1;
