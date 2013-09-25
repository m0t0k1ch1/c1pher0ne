package Cipherone::Schema;
use Mouse;

with 'Cipherone::Util::Role::Singleton';

use DBI;
use Teng;
use Teng::Schema::Loader;

has config => (
    is       => 'ro',
    required => 1,
);

has teng => (
    is         => 'rw',
    lazy_build => 1,
);

sub _build_teng {
    my $self = shift;

    my $mysql_config = $self->config->{mysql};

    my $dbh = DBI->connect(
        'dbi:mysql:' . $mysql_config->{db_name},
        $mysql_config->{user},
        $mysql_config->{password},
        {
            'mysql_enable_utf8' => 1,
        },
    );

    my $teng = Teng::Schema::Loader->load(
        dbh       => $dbh,
        namespace => 'Cipherone::DB',
    );

    $teng->load_plugin('Count');

    $teng;
}

__PACKAGE__->meta->make_immutable;

no Mouse;

1;
