package Cipherone::Batch::RemindMessage;
use Mouse;

with (
    'Cipherone::Role::Config',
    'Cipherone::Role::Model',
    'Cipherone::Role::Schema',
    'Cipherone::Role::Twitter',
);

use utf8;

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

            if ($body_from =~ /(\d{4}-\d{1,2}-\d{1,2} \d{1,2}:\d{1,2})/) {
                my $remind_date = $1;

                my $screen_name_from = '@' . $mention->{user}->{screen_name};
                my $screen_name_to   = '@' . $twitter->account_settings->{screen_name};

                $body_from =~ s/(?:${remind_date})//g;
                $body_from =~ s/(?:${screen_name_to})//g;
                $body_from =~ s/^ *(.*?) *$/$1/g;

                $self->schema('RemindMessage')->insert({
                    status_id   => $status_id,
                    screen_name => $screen_name_from,
                    body        => $body_from,
                    remind_date => $remind_date,
                });

                my $body_to = "${screen_name_from} 押忍！${remind_date}になったらリマインドするね";

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
