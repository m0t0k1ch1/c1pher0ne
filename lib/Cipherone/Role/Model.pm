package Cipherone::Role::Model;
use Mouse::Role;

use Cipherone::Model;
use Cipherone::Model::MediaRanking;

sub model {
    my ($self, $model) = @_;

    my $model_name = 'Cipherone::Model';
    if ($model) {
        $model_name .= "::${model}";
    }

    $model_name->instance(config => $self->config);
}

1;


