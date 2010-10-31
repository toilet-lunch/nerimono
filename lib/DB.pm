package DB;

use Exporter;
use Conf;
use TokyoCabinet;

@ISA = qw(Exporter);
@EXPORT = qw(getFreq2gram getFreq3gram);

sub new{
    my $this = shift;
    my $conf = Conf->new();
    my $datDir = $conf->get("DAT_DIR");
    if(!defined($datDir) || $datDir eq ""){
	die "please set dat directory to the config file.";
    }
    my $file2 = $datDir . '/2gm-0000.tch';
    my $file3 = $datDir . '/3gm-0000.tch';

    my $hdb2 = TokyoCabinet::HDB->new();
    my $hdb3 = TokyoCabinet::HDB->new();

    $hdb2->open($file2, $hdb2->OREADER);
    $hdb3->open($file3, $hdb3->OREADER);

    my $hash = {
	hdb2 => $hdb2,
	hdb3 => $hdb3
    };
    bless $hash,$this;
}

sub getFreq2gram{
    my $this = shift;
    my $word = shift;
    my $score = $this->{'hdb2'}->get($word);
    if(defined($score)){
	return $score;
    }
    return 0;
}

sub getFreq3gram{
    my $this = shift;
    my $word = shift;
    my $score = $this->{'hdb3'}->get($word);
    if(defined($score)){
	return $score;
    }
    return 0;
}

1;
