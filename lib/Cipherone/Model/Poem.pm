package Cipherone::Model::Poem;
use Mouse;

extends 'Cipherone::Model';
with 'Cipherone::Role::Config';

use utf8;

use Data::WeightedRoundRobin;
use Encode;
use JSON qw/decode_json/;
use LWP::UserAgent;
use XML::Simple;

has user_agent => (
    is      => 'rw',
    default => sub {
        LWP::UserAgent->new;
    },
);

has convert_weight => (
    is      => 'rw',
    default => sub {
        Data::WeightedRoundRobin->new([
            {value => 1, weight => 50},
            {value => 0, weight => 50},
        ]);
    },
);

has conversion_api_url => (
    is      => 'rw',
    default => 'http://jlp.yahooapis.jp/JIMService/V1/conversion',
);

has hanamogera_api_url => (
    is      => 'rw',
    default => 'http://truelogic.biz/hanamogera-devel/get-hanamogera',
);

__PACKAGE__->meta->make_immutable;

no Mouse;

sub _build_conversion_api_url {
    my ($self, $sentence) = @_;

    my $application_id = $self->_config->{yahoo}->{application_id};

    $self->conversion_api_url . "?appid=${application_id}&sentence=${sentence}";
}

sub _build_hanamogera_api_url {
    my ($self, $length) = @_;

    $self->hanamogera_api_url . "?length=${length}&output=json";
}

sub _convert_sentence {
    my ($self, $sentence) = @_;

    my $xml = XML::Simple->new;

    my $url = $self->_build_conversion_api_url($sentence);
    my $res = $self->user_agent->get($url);
    die $res->status_line unless $res->is_success;

    my $data = $xml->XMLin($res->content);

    my $segments = $data->{Result}->{SegmentList}->{Segment};
    $segments = [ $segments ] if ref $segments ne 'ARRAY';

    my $result;
    for my $segment (@{ $segments }) {
        $result .= $self->_convert_segment($segment);
    }

    $result;
}

sub _convert_segment {
    my ($self, $segment) = @_;

    if ($self->convert_weight->next) {
        my $candidates = $segment->{CandidateList}->{Candidate};

        ref $candidates eq 'ARRAY' ? $candidates->[0] : $candidates;
    }
    else {
        $segment->{SegmentText};
    }
}

sub get_hanamogera {
    my ($self, $length) = @_;

    my $url = $self->_build_hanamogera_api_url($length);
    my $res = $self->user_agent->get($url);
    die $res->status_line unless $res->is_success;

    my $data = decode_json($res->content);

    my $sentence = encode('utf8', $data->{hanamogera});

    $self->_convert_sentence($sentence);
}

1;
