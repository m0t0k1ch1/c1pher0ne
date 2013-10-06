use strict;
use warnings;
use utf8;
use FindBin::libs;

use Cipherone;

my $cipherone = Cipherone->new;

my $model = $cipherone->model('Twitter');
my $body  = $cipherone->tweet_text('wake_up');

$model->change_image_on;
$model->tweet($body);
