package Cipherone::Model::Trend;
use Mouse;
use utf8;

extends 'Cipherone::Model';

use File::Basename;

my $source_name_base = 'Cipherone::Model::Trend::Source';

my @files = glob 'lib/Cipherone/Model/Trend/Source/*';
for my $file (@files) {
    my ($source_name_tail) = fileparse $file, '.pm';
    my $source_name        = "${source_name_base}::${source_name_tail}";
    eval "use ${source_name}";
}

__PACKAGE__->meta->make_immutable;

no Mouse;

sub _source {
    my ($self, $name) = @_;

    my $trend_source_name = 'Cipherone::Model::Trend::Source';
    if ($name) {
        my $trend_source_name_tail = join '', (map { ucfirst $_ } (split /_/, $name));
        $trend_source_name .= "::${trend_source_name_tail}"
    }

    $trend_source_name->instance;
}

sub get {
    my ($self, $name) = @_;

    my $trend_source = $self->_source($name);

    $trend_source->trends;
}

1;
