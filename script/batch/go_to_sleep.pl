use strict;
use warnings;
use utf8;
use FindBin::libs;

use Cipherone::Batch::Twitter;

my $batch = Cipherone::Batch::Twitter->new;
my $body  = $batch->cipherone->tweet_text('go_to_sleep');

$batch->change_image_off;
$batch->tweet($body);
