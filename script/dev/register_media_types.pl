use strict;
use warnings;
use utf8;
use FindBin::libs;

use Cipherone;

my $cipherone = Cipherone->new;
my $teng      = $cipherone->schema->teng;

my @media_types = ('topsongs', 'topmovies');

for my $media_type (@media_types) {
    $teng->insert(media_type => {
        name => $media_type,
    });
}
