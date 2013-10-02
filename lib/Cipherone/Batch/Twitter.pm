package Cipherone::Batch::Twitter;
use Mouse;

with (
    'Cipherone::Role::Bitly',
    'Cipherone::Role::Config',
    'Cipherone::Role::Model',
    'Cipherone::Role::Schema',
    'Cipherone::Role::Twitter',
);

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

    $self->twitter->update($body);
}

sub change_image_on {
    my $self = shift;

    $self->twitter->update_profile_image([$self->image_on]);
}

sub change_image_off {
    my $self = shift;

    $self->twitter->update_profile_image([$self->image_off]);
}

sub tweet_trend {
    my $self = shift;

    my $trend_id     = $self->schema('Trend')->max_id;
    my $trend_detail = $self->schema('TrendDetail')->random($trend_id);
    my $adjective    = $self->schema('Adjective')->random;

    my $body = $trend_detail->body . 'って、' . $adjective->body . 'よね';

    my $url         = 'http://google.com/search?q=' . $trend_detail->body;
    my $url_shorten = $self->bitly->shorten($url);

    $self->twitter->update($body . ' ' . $url_shorten->short_url);
    $trend_detail->update({is_tweet => 1});
}

sub tweet_media_ranking {
    my ($self, $media_type_name) = @_;

    my $media_type           = $self->schema('MediaType')->search_by_name($media_type_name);
    my $media_ranking_id     = $self->schema('MediaRanking')->max_id($media_type->id);
    my $media_ranking_detail = $self->schema('MediaRankingDetail')->random($media_ranking_id);
    my $media_category_id    = $media_ranking_detail->media_category_id;
    my $media_category       = $self->schema('MediaCategory')->search_by_id($media_category_id);

    my $body = '【' . $media_category->name . '】'
        . $media_ranking_detail->title
        . '（' . $media_ranking_detail->artist . '）'
        . '、はやってるらしいよ';

    my $url_shorten = $self->bitly->shorten($media_ranking_detail->url);

    my $user_agent = LWP::UserAgent->new;
    my $res        = $user_agent->get($media_ranking_detail->image_url);

    $self->twitter->update_with_media(
        encode('utf8', $body . ' ' . $url_shorten->short_url),
        [
            undef,
            basename($media_ranking_detail->image_url),
            Content => $res->content,
        ],
    );
    $media_ranking_detail->update({is_tweet => 1});
}

sub tweet_poem {
    my $self = shift;

    my $poem = $self->model('Poem');

    my @sentences;
    for my $length (5, 7, 5, 7, 7) {
        push @sentences, $poem->get_hanamogera($length);
    }

    $self->tweet(join('　', @sentences));
}

1;
