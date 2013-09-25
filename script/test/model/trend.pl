use strict;
use warnings;
use utf8;
use FindBin::libs;

use feature 'say';

use Cipherone;

my $cipherone = Cipherone->new;

my $trend         = $cipherone->model('Trend');
my $trend_sources = $cipherone->config->{master_data}->{trend_source};

for my $trend_source (@{ $trend_sources }) {
    say $_ for @{ $trend->get_trends($trend_source->{id}) };
}
