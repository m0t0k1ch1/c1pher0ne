package Cipherone::Schema::RemindMessage;
use Mouse;
use utf8;

extends 'Cipherone::Schema';

has table => (
    is      => 'ro',
    default => 'remind_message',
);

__PACKAGE__->meta->make_immutable;

no Mouse;

sub search_by_status_id {
    my ($self, $status_id) = @_;

    $self->teng->single($self->table, {
        status_id => $status_id,
    });
}

sub have_to_tweet_now_list {
    my $self = shift;

    my $table = $self->table;

    my @result = $self->teng->search_by_sql(qq/
        SELECT *
        FROM ${table}
        WHERE remind_date <= ?
            AND is_tweet = 0
    /, [$self->now]);

    \@result;
}

1;
