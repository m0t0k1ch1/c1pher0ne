use strict;
use warnings;
use utf8;
use FindBin::libs;

use Cipherone;

my $cipherone = Cipherone->new;
my $teng      = $cipherone->schema->teng;

my @trend_sources = ('twitter', 'kizasi');

for my $trend_source (@trend_sources) {
    $teng->insert(trend_source => {
        name => $trend_source,
    });
}
