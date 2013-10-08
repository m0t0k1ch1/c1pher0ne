use strict;
use warnings;
use utf8;
use FindBin::libs;

use Cipherone;

my $cipherone = Cipherone->new;
$cipherone->twitter_batch('Stream')->streaming;
