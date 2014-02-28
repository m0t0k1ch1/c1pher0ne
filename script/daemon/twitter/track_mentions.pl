use strict;
use warnings;
use utf8;
use FindBin::libs;

use Cipherone;

local $| = 1;

my $cipherone = Cipherone->new;
$cipherone->daemon('Twitter')->track_mentions;
