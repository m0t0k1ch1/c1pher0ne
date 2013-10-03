use strict;
use warnings;
use utf8;
use FindBin::libs;

use Cipherone::Batch::Twitter;

my $batch = Cipherone::Batch::Twitter->new;
my $body  = $batch->cipherone->tweet_text('wake_up');

$batch->change_image_on;
$batch->tweet($body);
