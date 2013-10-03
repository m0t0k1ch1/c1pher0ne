package Cipherone::Test;

use Test::mysqld;

my $mysqld;

sub import {
    my $self = shift;

    unless ($ENV{TEST_DSN}) {
        $mysqld = Test::mysqld->new(
            my_cnf => {
                'skip-networking' => '',
            },
        );
    }

    $ENV{TEST_DSN} = $mysqld->dsn;
}

1;
