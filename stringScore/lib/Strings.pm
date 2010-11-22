package Strings;

use Exporter;
use Unicode::Normalize;
use Encode;

@ISA = qw(Exporter);
@EXPORT = qw(normalization);

sub new{
    my $this = shift;
}

sub normalization{
    my $this = shift;
    my $word = shift;
    $word = decode_utf8($word);
    $word =lc NFKC($word);
    return $word;
}

1;
