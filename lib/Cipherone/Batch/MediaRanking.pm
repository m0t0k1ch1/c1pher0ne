package Cipherone::Batch::MediaRanking;
use Mouse;

with (
    'Cipherone::Role::Config',
    'Cipherone::Role::Model',
    'Cipherone::Role::Schema',
);

__PACKAGE__->meta->make_immutable;

no Mouse;

sub register {
    my ($self, $media_type_name, $country_name, $limit) = @_;

    my $media_type = $self->schema('MediaType')->search_by_name($media_type_name);
    die 'invalid media_type!' unless $media_type;

    my $country = $self->schema('Country')->search_by_name($country_name);
    die 'invalid country!' unless $country;

    die 'no limit!' unless $limit;

    my $medias = $self->model('MediaRanking')->get($media_type_name, $country_name, $limit);
    my $teng   = $self->schema->teng;

    my $media_ranking = $teng->insert(media_ranking => {
        country_id    => $country->get_column('id'),
        media_type_id => $media_type->get_column('id'),
    });

    for my $media (@{ $medias }) {
        my $media_category = $self->schema('MediaCategory')->search_by_im_id($media->{category}->{im_id});
        unless ($media_category) {
            $media_category = $teng->insert(media_category => {
                im_id => $media->{category}->{im_id},
                name  => $media->{category}->{name},
                url   => $media->{category}->{url},
            });
        }

        $teng->insert(media_ranking_detail => {
            media_ranking_id  => $media_ranking->id,
            media_category_id => $media_category->get_column('id'),
            rank              => $media->{rank},
            im_id             => $media->{im_id},
            title             => $media->{title},
            artist            => $media->{artist},
            url               => $media->{url},
            image_url         => $media->{image_url},
            release_date      => $media->{release_date},
        });
    }
}

1;

