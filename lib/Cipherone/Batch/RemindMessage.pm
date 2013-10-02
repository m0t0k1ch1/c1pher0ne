package Cipherone::Batch::RemindMessage;
use Mouse;

with (
    'Cipherone::Role::Config',
    'Cipherone::Role::Model',
    'Cipherone::Role::Schema',
    'Cipherone::Role::Twitter',
);

use utf8;

use DateTime;
use DateTime::Format::HTTP;

sub register {
    my $self = shift;

    my $twitter  = $self->twitter;
    my $mentions = $twitter->mentions;

    for my $mention (@{ $mentions }) {
        my $status_id = $mention->{id};
        next if ($self->schema('RemindMessage')->search_by_status_id($status_id));

        my @hash_tags = map { $_->{text} } @{ $mention->{entities}->{hashtags} };

        if (grep { $_ eq 'remind' } @hash_tags) {
            my $body_from = $mention->{text};

            if ($body_from =~ /(\d{4}\/\d{1,2}\/\d{1,2} \d{1,2}:\d{1,2})/) {
                my $remind_date_string = $1;
                my $remind_date        = DateTime::Format::HTTP->parse_datetime($remind_date_string);

                my $screen_name_from = '@' . $mention->{user}->{screen_name};
                my $screen_name_to   = '@' . $twitter->account_settings->{screen_name};

                $body_from =~ s/(?:${remind_date_string})//g;
                $body_from =~ s/(?:${screen_name_to})//g;
                $body_from =~ s/^ *(.*?) *$/$1/g;

                my $body_to = $screen_name_from;;
                my $attr = {
                    status_id   => $status_id,
                    screen_name => $screen_name_from,
                    body        => $body_from,
                    remind_date => $remind_date,
                };

                if ($remind_date > DateTime->now(time_zone => 'local')) {
                    $body_to .= " 御意！${remind_date_string}になったらリマインドするね";
                    $attr->{is_tweet} = 0;
                } else {
                    $body_to .= ' 過去には戻れないよ！現実を見て！';
                    $attr->{is_tweet} = 1;
                }

                $self->schema('RemindMessage')->insert($attr);

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
