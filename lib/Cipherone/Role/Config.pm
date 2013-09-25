package Cipherone::Role::Config;
use Mouse::Role;

has _config => (
    is      => 'ro',
    default => sub {
        do 'config.pl' || die $!;
    },
);

1;
