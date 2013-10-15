package Cipherone::Batch::MediaRanking;
use Mouse;
use utf8;

extends 'Cipherone::Batch';
with (
    'Cipherone::Role::Model',
    'Cipherone::Role::Schema',
);

__PACKAGE__->meta->make_immutable;

no Mouse;

sub register {
    my ($self, $media_type_name, $country_name, $limit) = @_;

    my $media_type = $self->schema('MediaType')->search_by_name($media_type_name)
        // die 'invalid media_type!';

    my $country = $self->schema('Country')->search_by_name($country_name)
        // die 'invalid country!';

    die 'no limit!' unless defined $limit;

    my $results = $self->model('MediaRanking')->get($media_type_name, $country_name, $limit);

    my $media_ranking = $self->schema('MediaRanking')->insert({
        country_id    => $country->id,
        media_type_id => $media_type->id,
    });

    for my $result (@{ $results }) {
        my $media_category
            = $self->schema('MediaCategory')->search_by_im_id($result->{category}->{im_id});

        unless ($media_category) {
            $media_category = $self->schema('MediaCategory')->insert({
                im_id => $result->{category}->{im_id},
                name  => $result->{category}->{name},
                url   => $result->{category}->{url},
            });
        }

        $self->schema('MediaRankingDetail')->insert({
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
