use strict;
use warnings;
use utf8;
use FindBin::libs;

use Cipherone;

use DateTime;
use Encode;

my $cipherone = Cipherone->new;

my $img = 'static/img/cake.jpg';

my $now  = DateTime->now(time_zone => 'local');
my $hour = $now->hour;

if ($now->ymd eq '2013-10-24') {
    my $message = '@m0t0k1ch1 誕生日おめでとう！';
    unless ($hour == 0) {
        $message .= 'そういえば、' . $hour . '年前の今日も誕生日だったね！';
    }
    $cipherone->twitter->update_with_media(encode('utf8', $message), [$img]);
}
