package Cipherone::Role::Batch;
use Mouse::Role;
use utf8;

use File::Basename;

my $batch_name_base = 'Cipherone::Batch';
eval "use ${batch_name_base}";

my @files;

@files = glob 'lib/Cipherone/Batch/*';
for my $file (@files) {
    my ($batch_name_tail) = fileparse $file, '.pm';
    my $batch_name        = "${batch_name_base}::${batch_name_tail}";
    eval "use ${batch_name}";
}

$batch_name_base .= '::Twitter';

@files = glob 'lib/Cipherone/Batch/Twitter/*';
for my $file (@files) {
    my ($twitter_batch_name_tail) = fileparse $file, '.pm';
    my $twitter_batch_name        = "${batch_name_base}::${twitter_batch_name_tail}";
    eval "use ${twitter_batch_name}";
}

sub batch {
    my ($self, $name) = @_;

    my $batch_name = 'Cipherone::Batch';
    if ($name) {
        $batch_name .= "::${name}";
    }

    $batch_name->instance;
}

sub twitter_batch {
    my ($self, $name) = @_;

    my $twitter_batch_name = 'Cipherone::Batch::Twitter';
    if ($name) {
        $twitter_batch_name .= "::${name}";
    }

    $twitter_batch_name->instance;
}

1;
