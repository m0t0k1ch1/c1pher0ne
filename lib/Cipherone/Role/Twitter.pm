package Cipherone::Role::Twitter;
use Mouse::Role;
use utf8;

use Net::Twitter;

has twitter => (
    is         => 'rw',
    lazy_build => 1,
);

has screen_name => (
    is      => 'rw',
    default => 'c1pher0ne',
);

sub _build_twitter {
    my $self = shift;

    Net::Twitter->new(
        traits => ['API::RESTv1_1'],
        apiurl => 'https://api.twitter.com/1.1',
        %{ $self->config('twitter') },
    );
}

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
