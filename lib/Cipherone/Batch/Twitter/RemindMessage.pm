package Cipherone::Batch::Twitter::RemindMessage;
use Mouse;
use utf8;

extends 'Cipherone::Batch::Twitter',
with 'Cipherone::Role::Schema';

__PACKAGE__->meta->make_immutable;

no Mouse;

sub tweet {
    my $self = shift;

    my $remind_messages = $self->schema('RemindMessage')->have_to_tweet_now_list;

    for my $remind_message (@{ $remind_messages }) {
        my $body = $remind_message->screen_name . ' ' . $remind_message->body;

        $self->twitter->update($body);

        $remind_message->update({is_tweet => 1});
    }
}

1;
