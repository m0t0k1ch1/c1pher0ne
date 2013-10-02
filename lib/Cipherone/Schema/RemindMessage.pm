package Cipherone::Schema::RemindMessage;
use Mouse;

extends 'Cipherone::Schema';

has _table => (
    is      => 'ro',
    default => 'remind_message',
);

__PACKAGE__->meta->make_immutable;

no Mouse;

sub search_by_status_id {
    my ($self, $status_id) = @_;

    $self->teng->single($self->_table, {
        status_id => $status_id,
    });
}

1;
