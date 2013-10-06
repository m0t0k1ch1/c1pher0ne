use strict;
use warnings;
use utf8;
use FindBin::libs;

use Cipherone;

my $trend_source_name = $ARGV[0];

my $cipherone = Cipherone->new;
$cipherone->batch('Trend')->register($trend_source_name);

