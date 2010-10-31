package WordScore;

use Exporter;
use Encode;
use Strings;
use DB;


@ISA = qw(Exporter);
@EXPORT = qw(calc3gramProb filterAlphabet execute);

# WordScore->new(\@word);
sub new{
    my $this = shift;
    my $db = DB->new();
    my $strings = Strings->new();
    my $hash = {
	origin => shift,  #array_refference
	normal => [],
	result => {},
	DB => $db,
    };

    my %tmp;
    for(my $i=0;$i<@{$hash->{'origin'}};$i++){
	my $origin = $hash->{'origin'}->[$i];
	my $normal = $strings->normalization($origin);
	if(exists($tmp{$normal})){
	    next;
	}
	push(@{$hash->{'normal'}},$normal);
    }
    undef(%tmp);

    bless $hash,$this;
}

sub execute{
    my $this = shift;
    my @strs = $this->filterAlphabet($this->{'normal'});
    

    for(my $i=0;$i<@strs;$i++){
	my @base = "";
	my $baseStr = "";
	my %charHash;
	for(my $j=$i;$j<@strs;$j++){
	    if($#base > 12){
		last;
	    }
	    push(@base,split(//,$strs[$j]));
	    $baseStr .= $strs[$j];
	}
	if( exists($this->{'result'}->{$baseStr}) ){
	    next;
	}
	for(my $j=0;$j<@base;$j++){
	    $charHash{$base[$j]}++;
	}

	my $penalty = 1;

	foreach my $count (sort {$b <=> $a} values %charHash){
	    $penalty += $count - 1;
	}

	my $tryGramProb = 0;
	for(my $j=0;$j<=$#base-2;$j++){
	    my $tmpStr = $base[$j] . $base[$j+1] . $base[$j+2];
	    my $tmpProb = $this->calc3gramProb($tmpStr);
	    $tryGramProb += $tmpProb;
	}
	$tryGramProb /= $#base;
	$tryGramProb /= $penalty;

	$this->{'result'}->{$baseStr} = $tryGramProb;
	undef(%charHash);
    }

    return %{$this->{'result'}};
}

sub calc3gramProb{
    my $this = shift;
    my $str = shift;
    $str = decode_utf8($str);
    my @strs = split(//,$str);
    my $biFreq = $this->{'DB'}->getFreq2gram($strs[0] . $strs[1]);
    if($biFreq == 0){
	return 0.00001;
    }

    my $tryFreq = $this->{'DB'}->getFreq3gram($str);
    if($tryFreq == 0){
	return 0.00001;
    }
    my $tryGramProp = -1 * log( ($tryFreq / ( $biFreq + 1 ) ) )/log(10);
    return $tryGramProp;
}

sub filterAlphabet{
    my $this = shift;
    my $words = shift;
    my @result;
    for(my $i=0;$i<@{$words};$i++){
	if($words->[$i] !~ /[^ -~]+/){
	    next;
	}
	push(@result,$words->[$i]);
    }
    return @result;
}

1;
