use strict;
use warnings;
use utf8;
use FindBin::libs;

use feature 'say';

use Cipherone;

my $cipherone = Cipherone->new;

my $trend_sources = $cipherone->master_data('trend_source');
for my $trend_source (@{ $trend_sources }) {
    say $_ for @{ $cipherone->model('Trend')->get($trend_source->{id}) };
}
