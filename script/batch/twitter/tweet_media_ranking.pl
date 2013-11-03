use strict;
use warnings;
use utf8;
use FindBin::libs;

use Cipherone;

my $media_type_name = $ARGV[0];

my $cipherone = Cipherone->new;
$cipherone->twitter_batch('MediaRanking')->tweet($media_type_name);
