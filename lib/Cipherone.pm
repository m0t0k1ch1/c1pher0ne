package Cipherone;
use Mouse;
use utf8;

with (
    'Cipherone::Role::Bitly',
    'Cipherone::Role::Config',
    'Cipherone::Role::Model',
    'Cipherone::Role::Schema',
    'Cipherone::Role::Singleton',
    'Cipherone::Role::Twitter',
);

has _tweet_texts => (
    is      => 'rw',
    default => sub {
        {
            wake_up     => 'おはよう',
            go_to_sleep => 'おやすみ',
            tweet_trend => '__trend__って、__adjective__よね __url__',
            tweet_topsong            => '__artist__ の __title__、はやってるらしいよ __url__',
            tweet_topfreeapplication => '__title__、はやってるらしいよ __url__',
            register_remind_message_awake      => '御意！__date__ になったらリマインドするね',
            register_remind_message_asleep     => '...もー！起こさないでよ！__date__ ね！はいはい！おやすみ！',
            register_remind_message_error_past => '過去には戻れないよ！現実を見て！',
        };
    },
);

__PACKAGE__->meta->make_immutable;

no Mouse;

sub tweet_text {
    my ($self, $type, $replace_words) = @_;

    my $body = $self->_tweet_texts->{$type};

    if ($replace_words) {
        for my $key (keys %{ $replace_words }) {
            my $value = $replace_words->{$key};
            $body =~ s/(?:__${key}__)/$value/g;
        }
    }

    $body;
}

1;
