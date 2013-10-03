package Cipherone::Role::Singleton;
use Mouse::Role;
use utf8;

sub instance {
    my ($self, %option) = @_;

    no strict 'refs';

    my $instance = \${ "${self}::_instance" };

    defined $$instance
        ? $$instance
        : ($$instance = $self->new(%option));
}

1;
