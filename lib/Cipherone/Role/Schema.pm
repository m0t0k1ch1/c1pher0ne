package Cipherone::Role::Schema;
use Mouse::Role;
use utf8;

use Cipherone::Schema;

my @schemas = glob 'lib/Cipherone/Schema/*';
for my $schema (@schemas) {
    my $schema_name = 'Cipherone::Schema::' . fileparse($schema, '.pm');
    eval "use ${schema_name}";
}

use File::Basename;

sub schema {
    my ($self, $schema) = @_;

    my $schema_name = 'Cipherone::Schema';
    if ($schema) {
        $schema_name .= "::${schema}";
    }

    $schema_name->instance;
}

1;
