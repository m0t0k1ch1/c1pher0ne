package Cipherone::Util::Role::Singleton;
use Mouse::Role;

sub instance {
    my ($self, %option) = @_;

    no strict 'refs';

    my $instance = \${ "${self}::_instance" };

    defined $$instance
        ? $$instance
        : ($$instance = $self->new(%option));
}

1;
