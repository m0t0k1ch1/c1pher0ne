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
        my $screen_name = $remind_message->screen_name;
        my $body        = $remind_message->body;
        my $timestamp   = $self->schema->now->strftime('%Y-%m-%d %H:%M:%S');

        my $text = "${screen_name} ${body} 【${timestamp}】";
        $self->twitter->update($text);

        $remind_message->update({is_tweet => 1});
    }
}

1;
