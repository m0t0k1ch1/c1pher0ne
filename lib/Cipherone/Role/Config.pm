package Cipherone::Role::Config;
use Mouse::Role;
use utf8;

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

    $key ? $self->_config->{$key} : $self->_config;
}

sub master_data {
    my ($self, $table) = @_;

    $table ? $self->_master_data->{$table} : $self->_master_data;
}

1;
