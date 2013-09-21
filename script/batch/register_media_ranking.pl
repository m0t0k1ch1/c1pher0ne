use strict;
use warnings;
use utf8;
use FindBin::libs;

use Cipherone;

my $cipherone = Cipherone->new;

my $media_type_name = $ARGV[0];
my $country_name    = $ARGV[1];
my $limit           = $ARGV[2];

my $media_type = $cipherone->schema('MediaType')->search_by_name($media_type_name);
die 'invalid media_type!' unless $media_type;

my $country = $cipherone->schema('Country')->search_by_name($country_name);
die 'invalid country!' unless $country;

die 'no limit!' unless $limit;

my $medias = $cipherone->model('MediaRanking')->get($media_type_name, $country_name, $limit);
my $teng   = $cipherone->schema->teng;

for my $media (@{ $medias }) {
    my $media_category= $cipherone->schema('MediaCategory')->search_by_im_id($media->{category}->{im_id});
    unless ($media_category) {
        $media_category = $teng->insert(media_category => {
            im_id => $media->{category}->{im_id},
            name  => $media->{category}->{name},
            url   => $media->{category}->{url},
        });
    }

    $teng->insert(media_ranking => {
        country_id        => $country->get_column('id'),
        media_type_id     => $media_type->get_column('id'),
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
