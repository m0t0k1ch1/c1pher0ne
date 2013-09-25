use strict;
use warnings;
use utf8;
use FindBin::libs;

use Cipherone;

my $cipherone = Cipherone->new;
my $teng      = $cipherone->schema->teng;

my $media_types = $cipherone->config->{master_data}->{media_type};
for my $media_type (@{ $media_types }) {
    $teng->insert(media_type => {
        id   => $media_type->{id},
        name => $media_type->{name},
    });
}
