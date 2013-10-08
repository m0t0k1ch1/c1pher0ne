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
                past => '過去には戻れないよ！現実を見て！',
            },
        }
    },
);

__PACKAGE__->meta->make_immutable;

no Mouse;

sub response {
    my ($self, $tweet) = @_;

    my $status_id = $tweet->{id};
    next if ($self->schema('RemindMessage')->search_by_status_id($status_id));

    my @hash_tags = map { $_->{text} } @{ $tweet->{entities}->{hashtags} };

    if (grep { $_ eq 'remind' } @hash_tags) {
        my $text_from = $tweet->{text};

        if ($text_from =~ /\s(\d{4}\/\d{1,2}\/\d{1,2} \d{1,2}:\d{1,2})$/) {
            my $remind_date_string = $1;
            my $remind_date        = DateTime::Format::HTTP->parse_datetime($remind_date_string);

            my $screen_name_from = '@' . $tweet->{user}->{screen_name};
            my $screen_name_to   = '@' . $self->screen_name;

            my $text_to;
            my $now = DateTime->now(time_zone => 'local');

            if ($remind_date > $now) {
                my $tweet_text_type = $now->hour >= 1 && $now->hour < 7 ? 'asleep' : 'awake';
                my $text_base       = "${screen_name_to} " . $self->_tweet_text->{$tweet_text_type};

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
            else {
                $text_to .= ' ' . $self->tweet_text->{error}->{past};
            }

            $self->twitter->update({
                status                => $text_to,
                in_reply_to_status_id => $tweet->{id},
            });
        }
    }
}

1;