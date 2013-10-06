package Cipherone::Batch::Twitter;
use Mouse;
use utf8;

extends 'Cipherone::Batch';
with 'Cipherone::Role::Twitter';

has screen_name => (
    is      => 'rw',
    default => '@c1pher0ne',
);

__PACKAGE__->meta->make_immutable;

no Mouse;

sub tweet_text {
    my ($self, $text, $replace_words) = @_;

    if ($replace_words) {
        for my $key (keys %{ $replace_words }) {
            my $value = $replace_words->{$key};
            $text =~ s/(?:__${key}__)/$value/g;
        }
    }

    $text;
}

1;
