package Cipherone::Daemon::Twitter::Response::RemindMessage;
use Mouse;
use utf8;

extends 'Cipherone::Daemon::Twitter::Response';
with (
    'Cipherone::Role::Schema',
    'Cipherone::Daemon::Twitter::Role::Response',
);

use DateTime;
use DateTime::Format::HTTP;

has _tweet_text => (
    is      => 'rw',
    default => sub {
        {
            awake  => '御意！__date__ になったらリマインドするね',
            asleep => '...もー！起こさないでよ！__date__ ね！はいはい！おやすみ！',
            error  => {
                future => '先を見過ぎだよ！今を生きよう！',
                past   => '過去には戻れないよ！現実を見て！',
            },
        }
    },
);

__PACKAGE__->meta->make_immutable;

no Mouse;

sub response {
    my ($self, $tweet) = @_;

    my $status_id = $tweet->{id};
    my $text_from = $tweet->{text};

    if ($text_from =~ /\s(\d{4}\/\d{1,2}\/\d{1,2} \d{1,2}:\d{1,2})$/) {
        my $remind_date_string = $1;
        my $remind_date        = DateTime::Format::HTTP->parse_datetime($remind_date_string);

        my $screen_name_from = '@' . $tweet->{user}->{screen_name};
        my $screen_name_to   = '@' . $self->screen_name;

        my $text_to;
        my $now = $self->schema->now;

        if ($remind_date < $now) {
            $text_to .= $screen_name_from . ' ' . $self->_tweet_text->{error}->{past};
        }
        elsif ($remind_date->delta_days($now)->in_units('days') > 1000) {
            $text_to .= $screen_name_from . ' ' . $self->_tweet_text->{error}->{future};
        }
        else {
            my $tweet_text_type = $now->hour >= 1 && $now->hour < 7 ? 'asleep' : 'awake';
            my $text_base       = "${screen_name_from} " . $self->_tweet_text->{$tweet_text_type};

            $text_to = $self->tweet_text($text_base, {
                date => $remind_date_string,
            });

            $text_from =~ s/(?:${remind_date_string})//g;
            $text_from =~ s/(?:${screen_name_to})//g;
            $text_from =~ s/^\s*(.*?)\s*$/$1/g;

            $self->schema('RemindMessage')->insert({
                status_id   => $status_id,
                screen_name => $screen_name_from,
                body        => $text_from,
                remind_date => $remind_date,
            });
        }

        my $timestamp = $now->strftime('%Y-%m-%d %H:%M:%S.%3N');

        $self->twitter->update({
            status                => "${text_to} 【${timestamp}】",
            in_reply_to_status_id => $tweet->{id},
        });
    }
}

1;
