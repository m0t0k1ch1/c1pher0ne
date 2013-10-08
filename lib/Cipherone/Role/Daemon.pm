package Cipherone::Role::Daemon;
use Mouse::Role;
use utf8;

use File::Basename;

my $daemon_name_base = 'Cipherone::Daemon';
eval "use ${daemon_name_base}";

my @files = glob 'lib/Cipherone/Daemon/*';
for my $file (@files) {
    my ($daemon_name_tail) = fileparse $file, '.pm';
    my $daemon_name        = "${daemon_name_base}::${daemon_name_tail}";
    eval "use ${daemon_name}";
}

sub daemon {
    my ($self, $name) = @_;

    my $daemon_name = 'Cipherone::Daemon';
    if ($name) {
        $daemon_name .= "::${name}";
    }

    $daemon_name->instance;
}

1;
