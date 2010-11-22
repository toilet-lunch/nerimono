package Conf;

use Exporter;

@ISA = qw(Exporter);
@EXPORT = qw(get);

sub new{
    my $this = shift;
    my $confFile = "../conf/nerimono.conf";
    my $hash = {};

    open(IN,"<",$confFile) or die "$!:$confFile";
    while(my $line = <IN>){
	chomp($line);
	$line =~ s/\s//g;
	if($line !~ /\=/){
	    next;
	}elsif($line eq ""){
	    next;
	}elsif($line =~ /^\#|^\;/){
	    next;
	}
	my ($key,$value) = split(/\=/,$line);
	if($key eq "DAT_DIR"){
	    $value =~ s/\/$//;
	}
	$hash->{$key} = $value;
    }
    close(IN);
    bless $hash,$this;
}

sub get{
    my $this = shift;
    my $key = shift;

    if(!defined($key) || $key eq ""){
	return ;
    }

    if(exists($this->{$key})){
	return $this->{$key};
    }

    return ;
}

1;
