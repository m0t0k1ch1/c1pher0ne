use strict;
use warnings;
use utf8;
use FindBin::libs;

use Cipherone;

my $cipherone = Cipherone->new;
my $batch     = $cipherone->twitter_batch('Basic');

$batch->change_image_off;
$batch->tweet('go_to_sleep');
