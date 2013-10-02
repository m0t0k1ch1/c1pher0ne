package Cipherone::Role::Config;
use Mouse::Role;

has _config => (
    is      => 'ro',
    default => sub {
        do 'config.pl' || die $!;
    },
);

has _master_data => (
    is      => 'ro',
    default => sub {
        do 'master_data.pl' || die $!;
    },
);

sub config {
    my ($self, $key) = @_;

    $self->_config->{$key};
}

sub master_data {
    my ($self, $table) = @_;

    $self->_master_data->{$table};
}

1;
