use strict;
use warnings;
use utf8;
use FindBin::libs;

use feature 'say';

use Cipherone;

use Data::Dumper;

my $cipherone = Cipherone->new;

my $trend = $cipherone->model('Trend');

$trend->set_source('Twitter');
say $_ for @{ $trend->get_trends };

$trend->set_source('Kizasi');
say $_ for @{ $trend->get_trends };
