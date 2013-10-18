use strict;
use warnings;
use utf8;
use FindBin::libs;

use Cipherone;
use Cipherone::Test;
use t::Util;

use DateTime;
use DateTime::Format::HTTP;
use Test::More;

my $cipherone      = Cipherone->new;
my $remind_message = $cipherone->schema('RemindMessage');

my $now = $cipherone->schema->now;

for my $i (1..10) {
    insert_remind_message({
        status_id   => $i,
        remind_date => $now->clone->subtract(days => 5, hours => 12)->add(days => $i),
        is_tweet    => $i % 2 ? 1 : 0,
    });
}

subtest 'search_by_statud_id' => sub {
    my $status_id = 1;

    my $row = $remind_message->search_by_status_id($status_id);
    ok $row;
    isa_ok $row, 'Teng::Row';
    is $row->status_id, $status_id, 'status_id: ' . $row->status_id;
};

subtest 'have_to_tweet_now_list' => sub {
    my $result = $remind_message->have_to_tweet_now_list;
    ok $result;
    isa_ok $result, 'ARRAY';

    for my $row (@{ $result }) {
        isa_ok $row, 'Teng::Row';
        my $remind_date = DateTime::Format::HTTP->parse_datetime($row->remind_date);
        ok $remind_date <= $now, 'remind_date: ' . $row->remind_date;
        ok !$row->is_tweet, 'is_tweet: ' . $row->is_tweet;
    }
};

done_testing;
