package Cipherone::Role::Config;
use Mouse::Role;

has _config => (
    is      => 'ro',
    default => sub {
        do 'config.pl' || die $!;
    },
);

sub master_data {
    my ($self, $table) = @_;

    $self->_config->{master_data}->{$table};
}

1;
