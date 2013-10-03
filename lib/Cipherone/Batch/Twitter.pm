package Cipherone::Batch::Twitter;
use Mouse;

extends 'Cipherone::Batch';

use utf8;

use Encode;
use File::Basename;
use LWP::UserAgent;

has image_on => (
    is      => 'ro',
    default => 'static/img/c1pher0ne_on.png',
);

has image_off => (
    is      => 'ro',
    default => 'static/img/c1pher0ne_off.png',
);

__PACKAGE__->meta->make_immutable;

no Mouse;

sub tweet {
    my ($self, $body) = @_;

    $self->cipherone->twitter->update($body);
}

sub change_image_on {
    my $self = shift;

    $self->cipherone->twitter->update_profile_image([$self->image_on]);
}

sub change_image_off {
    my $self = shift;

    $self->cipherone->twitter->update_profile_image([$self->image_off]);
}

sub tweet_trend {
    my $self = shift;

    my $cipherone = $self->cipherone;

    my $trend_id     = $cipherone->schema('Trend')->max_id;
    my $trend_detail = $cipherone->schema('TrendDetail')->random($trend_id);
    my $adjective    = $cipherone->schema('Adjective')->random;

    my $body = $cipherone->tweet_text('tweet_trend', {
        trend     => $trend_detail->body,
        adjective => $adjective->body,
        url       => $cipherone->bitly->shorten('http://google.com/search?q=' . $trend_detail->body),
    });

    $cipherone->twitter->update($body);
    $trend_detail->update({is_tweet => 1});
}

sub tweet_media_ranking {
    my ($self, $media_type_name) = @_;

    my $cipherone = $self->cipherone;

    my $media_type           = $cipherone->schema('MediaType')->search_by_name($media_type_name);
    my $media_ranking_id     = $cipherone->schema('MediaRanking')->max_id($media_type->id);
    my $media_ranking_detail = $cipherone->schema('MediaRankingDetail')->random($media_ranking_id);
    my $media_category_id    = $media_ranking_detail->media_category_id;
    my $media_category       = $cipherone->schema('MediaCategory')->search_by_id($media_category_id);

    my $body = $cipherone->tweet_text('tweet_media_ranking', {
        category => $media_category->name,
        title    => $media_ranking_detail->title,
        artist   => $media_ranking_detail->artist,
        url      => $cipherone->bitly->shorten($media_ranking_detail->url),
    });

    my $user_agent = LWP::UserAgent->new;
    my $res        = $user_agent->get($media_ranking_detail->image_url);

    $cipherone->twitter->update_with_media(encode('utf8', $body), [
        undef,
        basename($media_ranking_detail->image_url),
        Content => $res->content,
    ]);
    $media_ranking_detail->update({is_tweet => 1});
}

sub tweet_poem {
    my $self = shift;

    my $cipherone = $self->cipherone;

    my $poem = $cipherone->model('Poem');

    my @sentences;
    for my $length (5, 7, 5, 7, 7) {
        push @sentences, $poem->get_hanamogera($length);
    }

    $cipherone->twitter->update(join('　', @sentences));
}

sub tweet_remind_message {
    my $self = shift;

    my $cipherone = $self->cipherone;

    my $remind_messages = $cipherone->schema('RemindMessage')->have_to_tweet_now_list;

    for my $remind_message (@{ $remind_messages }) {
        my $body = $remind_message->screen_name . ' ' . $remind_message->body;

        $cipherone->twitter->update($body);

        $remind_message->update({is_tweet => 1});
    }
}

1;
