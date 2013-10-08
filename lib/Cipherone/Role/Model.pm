package Cipherone::Role::Model;
use Mouse::Role;
use utf8;

use File::Basename;

my $model_name_base = 'Cipherone::Model';
eval "use ${model_name_base}";

my @files = glob 'lib/Cipherone/Model/*';
for my $file (@files) {
    my ($model_name_tail) = fileparse $file, '.pm';
    my $model_name        = "${model_name_base}::${model_name_tail}";
    eval "use ${model_name}";
}

sub model {
    my ($self, $name) = @_;

    my $model_name = 'Cipherone::Model';
    if ($name) {
        $model_name .= "::${name}";
    }

    $model_name->instance;
}

1;


