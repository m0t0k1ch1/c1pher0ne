use strict;
use warnings;
use FindBin::libs;

use Cipherone;

use Data::Dumper;

my $cipherone = Cipherone->new;

my $trend_sources = $cipherone->master_data('trend_source');
for my $trend_source (@{ $trend_sources }) {
    my $row = $cipherone->schema('TrendSource')->search_by_name($trend_source->{name});
    warn Dumper $row->get_columns;
}
