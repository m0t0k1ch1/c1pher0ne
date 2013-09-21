use strict;
use warnings;
use utf8;
use FindBin::libs;

use Cipherone;

use Encode;
use HTML::TreeBuilder;
use List::MoreUtils qw/uniq/;
use LWP::UserAgent;

my $cipherone = Cipherone->new;
my $teng      = $cipherone->schema->teng;

my @adjectives = get_adjectives();

for my $adjective (@adjectives) {
    $teng->insert(adjective => {
        body => $adjective,
    });
}

sub get_adjectives {
    my $url        = 'http://gyobbit.nomaki.jp/100/hundred.html';
    my $user_agent = LWP::UserAgent->new();
    my $res        = $user_agent->get($url);

    my $tree = HTML::TreeBuilder->new();
    $tree->parse($res->content);

    my @tds = $tree->find('td');

    my @result;

    for my $td (@tds) {
        my $str   = decode('shiftjis', $td->as_trimmed_text);
        my @words = split(/ /, $str);

        my @adjectives = grep { length($_) > 1 } @words;

        for my $adjective (@adjectives) {
            push @result, (split(/　/, $adjective))[0];
        }
    }

    uniq @result;
}

