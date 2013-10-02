package Cipherone::Role::Model;
use Mouse::Role;

use Cipherone::Model;

my @models = glob 'lib/Cipherone/Model/*';
for my $model (@models) {
    my $model_name = 'Cipherone::Model::' . fileparse($model, '.pm');
    eval "use ${model_name}";
}

use File::Basename;

sub model {
    my ($self, $model) = @_;

    my $model_name = 'Cipherone::Model';
    if ($model) {
        $model_name .= "::${model}";
    }

    $model_name->instance;
}

1;


