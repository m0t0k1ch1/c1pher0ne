package Cipherone::Role::Schema;
use Mouse::Role;

use Cipherone::Schema;
use Cipherone::Schema::Adjective;
use Cipherone::Schema::Country;
use Cipherone::Schema::MediaCategory;
use Cipherone::Schema::MediaRanking;
use Cipherone::Schema::MediaRankingDetail;
use Cipherone::Schema::MediaType;
use Cipherone::Schema::Trend;
use Cipherone::Schema::TrendDetail;
use Cipherone::Schema::TrendSource;

sub schema {
    my ($self, $schema) = @_;

    my $schema_name = 'Cipherone::Schema';
    if ($schema) {
        $schema_name .= "::${schema}";
    }

    $schema_name->instance;
}

1;
