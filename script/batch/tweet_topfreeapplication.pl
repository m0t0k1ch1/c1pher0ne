use strict;
use warnings;
use utf8;
use FindBin::libs;

use Cipherone::Batch::Twitter;

my $batch = Cipherone::Batch::Twitter->new;

$batch->tweet_media_ranking('topfreeapplications');