use strict;
use warnings;
use FindBin::libs;

use Cipherone;

use Data::Dumper;

my $cipherone = Cipherone->new;

my $music_ranking_ja = $cipherone->model('MediaRanking')->get('topsongs', 'jp', 1);
warn Dumper $music_ranking_ja;

my $music_ranking_us = $cipherone->model('MediaRanking')->get('topsongs', 'us', 1);
warn Dumper $music_ranking_us;

my $movie_ranking_ja = $cipherone->model('MediaRanking')->get('topmovies', 'ja', 1);
warn Dumper $movie_ranking_ja;

my $movie_ranking_us = $cipherone->model('MediaRanking')->get('topmovies', 'us', 1);
warn Dumper $movie_ranking_us;
