use strict;
use warnings;
use utf8;
use FindBin::libs;

use Cipherone::Batch::Trend;

my $trend_source_name = $ARGV[0];

my $batch = Cipherone::Batch::Trend->new;
$batch->register($trend_source_name);

