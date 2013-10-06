package Cipherone::Batch::Twitter::MediaRanking;
use Mouse;
use utf8;

extends 'Cipherone::Batch::Twitter',
with (
    'Cipherone::Role::Bitly',
    'Cipherone::Role::Schema',
);

use Encode;
use LWP::UserAgent;

has _tweet_text => (
    is      => 'rw',
    default => sub {
        {
            topsongs            =>  '__artist__ の __title__、はやってるらしいよ __url__',
            topfreeapplications => '__title__、はやってるらしいよ __url__',
        }
    },
);

__PACKAGE__->meta->make_immutable;

no Mouse;

sub tweet {
    my ($self, $media_type_name) = @_;

    my $media_type           = $self->schema('MediaType')->search_by_name($media_type_name);
    my $media_ranking_id     = $self->schema('MediaRanking')->max_id($media_type->id);
    my $media_ranking_detail = $self->schema('MediaRankingDetail')->random($media_ranking_id);
    my $media_category_id    = $media_ranking_detail->media_category_id;
    my $media_category       = $self->schema('MediaCategory')->search_by_id($media_category_id);

    my $attr = {
        title => $media_ranking_detail->title,
        url   => $self->bitly->shorten($media_ranking_detail->url)->short_url,
    };
    if ($media_type_name eq 'topsongs') {
        $attr->{artist} = $media_ranking_detail->artist;
    }

    my $text = $self->tweet_text($self->_tweet_text->{$media_type_name}, $attr);

    my $user_agent = LWP::UserAgent->new;
    my $res        = $user_agent->get($media_ranking_detail->image_url);

    $self->twitter->update_with_media(encode('utf8', $text), [
        undef,
        basename($media_ranking_detail->image_url),
        Content => $res->content,
    ]);
    $media_ranking_detail->update({is_tweet => 1});
}

1;
