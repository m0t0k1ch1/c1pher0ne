package Cipherone::Role::Batch;
use Mouse::Role;
use utf8;

use Cipherone::Batch;

my @batches = glob 'lib/Cipherone/Batch/*';
for my $batch (@batches) {
    my $batch_name = 'Cipherone::Batch::' . fileparse($batch, '.pm');
    eval "use ${batch_name}";
}

my @twitter_batches = glob 'lib/Cipherone/Batch/Twitter/*';
for my $twitter_batch (@twitter_batches) {
    my $twitter_batch_name = 'Cipherone::Batch::Twitter::' . fileparse($twitter_batch, '.pm');
    eval "use ${twitter_batch_name}";
}

use File::Basename;

sub batch {
    my ($self, $batch) = @_;

    my $batch_name = 'Cipherone::Batch';
    if ($batch) {
        $batch_name .= "::${batch}";
    }

    $batch_name->instance;
}

sub twitter_batch {
    my ($self, $twitter_batch) = @_;

    my $twitter_batch_name = 'Cipherone::Batch::Twitter';
    if ($twitter_batch) {
        $twitter_batch_name .= "::${twitter_batch}";
    }

    $twitter_batch_name->instance;
}

1;
