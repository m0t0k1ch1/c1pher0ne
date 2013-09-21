package Cipherone::Role::Schema;
use Mouse::Role;

use Cipherone::Schema;
use Cipherone::Schema::Adjective;
use Cipherone::Schema::Country;
use Cipherone::Schema::MediaCategory;
use Cipherone::Schema::MediaType;
use Cipherone::Schema::Trend;

sub schema {
    my ($self, $schema) = @_;

    my $schema_name = 'Cipherone::Schema';
    if ($schema) {
        $schema_name .= "::${schema}";
    }

    $schema_name->instance(config => $self->config->{mysql});
}

1;
