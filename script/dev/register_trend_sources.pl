use strict;
use warnings;
use utf8;
use FindBin::libs;

use Cipherone;

my $cipherone = Cipherone->new;
my $teng      = $cipherone->schema->teng;

my $trend_sources = $cipherone->config->{master_data}->{trend_source};
for my $trend_source (@{ $trend_sources }) {
    $teng->insert(trend_source => {
        id   => $trend_source->{id},
        name => $trend_source->{name},
    });
}
