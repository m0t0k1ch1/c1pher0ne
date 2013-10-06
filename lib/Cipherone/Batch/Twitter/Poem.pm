package Cipherone::Batch::Twitter::Poem;
use Mouse;
use utf8;

extends 'Cipherone::Batch::Twitter',
with 'Cipherone::Role::Model';

__PACKAGE__->meta->make_immutable;

no Mouse;

sub tweet {
    my $self = shift;

    my $poem = $self->model('Poem');

    my @sentences;
    for my $length (5, 7, 5, 7, 7) {
        push @sentences, $poem->get_hanamogera($length);
    }

    $self->twitter->update(join('　', @sentences));
}

1;
