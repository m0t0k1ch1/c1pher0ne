use strict;
use warnings;
use utf8;
use FindBin::libs;

use Cipherone::Batch::MediaRanking;

my $media_type_name = $ARGV[0];
my $country_name    = $ARGV[1];
my $limit           = $ARGV[2];

my $batch = Cipherone::Batch::MediaRanking->new;
$batch->register($media_type_name, $country_name, $limit);
