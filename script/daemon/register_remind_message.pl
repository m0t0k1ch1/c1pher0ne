use strict;
use warnings;
use utf8;
use FindBin::libs;

use Cipherone::Batch::RemindMessage;

my $batch = Cipherone::Batch::RemindMessage->new;
$batch->streaming('@c1pher0ne');
