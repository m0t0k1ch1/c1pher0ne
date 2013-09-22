package Cipherone::Schema;
use Mouse;

with (
    'Cipherone::Util::Role::Singleton',
);

use DBI;
use Teng;
use Teng::Schema::Loader;

has config => (
    is       => 'rw',
    required => 1,
);

has teng => (
    is         => 'rw',
    lazy_build => 1,
);

sub _build_teng {
    my $self = shift;

    my $dbh = DBI->connect(
        'dbi:mysql:' . $self->config->{db_name},
        $self->config->{user},
        $self->config->{password},
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
