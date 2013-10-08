package Cipherone::Role::Schema;
use Mouse::Role;
use utf8;

use File::Basename;

my $schema_name_base = 'Cipherone::Schema';
eval "use ${schema_name_base}";

my @files = glob 'lib/Cipherone/Schema/*';
for my $file (@files) {
    my ($schema_name_tail) = fileparse $file, '.pm';
    my $schema_name        = "${schema_name_base}::${schema_name_tail}";
    eval "use ${schema_name}";
}

sub schema {
    my ($self, $name) = @_;

    my $schema_name = 'Cipherone::Schema';
    if ($name) {
        $schema_name .= "::${name}";
    }

    $schema_name->instance;
}

1;
