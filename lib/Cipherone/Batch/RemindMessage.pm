package Cipherone::Batch::RemindMessage;
use Mouse;

extends 'Cipherone::Batch';

use utf8;

use DateTime;
use DateTime::Format::HTTP;

sub register {
    my $self = shift;

    my $cipherone = $self->cipherone;

    my $twitter  = $cipherone->twitter;
    my $mentions = $twitter->mentions;

    for my $mention (@{ $mentions }) {
        my $status_id = $mention->{id};
        next if ($cipherone->schema('RemindMessage')->search_by_status_id($status_id));

        my @hash_tags = map { $_->{text} } @{ $mention->{entities}->{hashtags} };

        if (grep { $_ eq 'remind' } @hash_tags) {
            my $body_from = $mention->{text};

            if ($body_from =~ /(\s\d{4}\/\d{1,2}\/\d{1,2} \d{1,2}:\d{1,2}$)/) {
                my $remind_date_string = $1;
                my $remind_date        = DateTime::Format::HTTP->parse_datetime($remind_date_string);

                my $screen_name_from = '@' . $mention->{user}->{screen_name};
                my $screen_name_to   = '@' . $twitter->account_settings->{screen_name};

                $body_from =~ s/(?:${remind_date_string})//g;
                $body_from =~ s/(?:${screen_name_to})//g;
                $body_from =~ s/^\s*(.*?)\s*$/$1/g;

                my $body_to = $screen_name_from;;
                my $attr = {
                    status_id   => $status_id,
                    screen_name => $screen_name_from,
                    body        => $body_from,
                    remind_date => $remind_date,
                };

                my $now = DateTime->now(time_zone => 'local');

                if ($remind_date > $now) {
                    my $tweet_text_type =
                        $now->hour > 1 && $now->hour < 7 ? 'register_remind_message_asleep'
                                                         : 'register_remind_message_awake';

                    $body_to .= $cipherone->tweet_text($tweet_text_type, {
                        date => $remind_date_string,
                    });
                    $attr->{is_tweet} = 0;
                }
                else {
                    $body_to = $cipherone->tweet_text('register_remind_message_error_past');
                    $attr->{is_tweet} = 1;
                }

                $cipherone->schema('RemindMessage')->insert($attr);

                $twitter->update({
                    status                => $body_to,
                    in_reply_to_status_id => $mention->{id},
                });
            }
        }
    }
}

__PACKAGE__->meta->make_immutable;

no Mouse;

1;
