use strict;
use warnings;
use utf8;
use FindBin::libs;

use Cipherone;

my $cipherone = Cipherone->new;

my $model = $cipherone->model('Twitter');
my $body  = $cipherone->tweet_text('go_to_sleep');

$model->change_image_off;
$model->tweet($body);
