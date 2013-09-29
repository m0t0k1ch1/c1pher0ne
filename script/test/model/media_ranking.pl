use strict;
use warnings;
use FindBin::libs;

use Cipherone;

use Data::Dumper;

my $cipherone = Cipherone->new;

my $media_types = $cipherone->master_data('media_type');
my $countries   = $cipherone->master_data('country');
my $limit       = 1;

for my $media_type (@{ $media_types }) {
    for my $country (@{ $countries }) {
        my $media_ranking
            = $cipherone->model('MediaRanking')->get($media_type->{name}, $country->{name}, 1);
        warn Dumper $media_ranking;
    }
}
