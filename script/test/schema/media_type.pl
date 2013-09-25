use strict;
use warnings;
use FindBin::libs;

use Cipherone;

use Data::Dumper;

my $cipherone = Cipherone->new;

my $media_types = $cipherone->master_data('media_type');
for my $media_type (@{ $media_types }) {
    my $row = $cipherone->schema('MediaType')->search_by_name($media_type->{name});
    warn Dumper $row->get_columns;
}
