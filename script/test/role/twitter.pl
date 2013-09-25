use strict;
use warnings;
use utf8;
use FindBin::libs;

use Cipherone;

my $cipherone = Cipherone->new;
my $twitter   = $cipherone->twitter;

$twitter->update('so sleepy...');

