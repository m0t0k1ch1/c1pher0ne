use strict;
use warnings;
use utf8;
use FindBin::libs;

use Cipherone;

my $media_type_name = $ARGV[0];
my $country_name    = $ARGV[1];
my $limit           = $ARGV[2];

my $cipherone = Cipherone->new;
$cipherone->batch('MediaRanking')->register($media_type_name, $country_name, $limit);
