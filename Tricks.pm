#!/usr/bin/perl
package Pack::Tricks;
use strict;

use Exporter qw(import);
#our @EXPORT_OK=qw(pckIp4Port upckIp4Port);
our @EXPORT=qw(pckIp4Port upckIp4Port);

sub pckIp4Port {
 return unless defined wantarray; 
 my ($ip,$port)=@_;
 if ( (my $ix=index($ip,':'))>=0 ) {
  $port=substr($ip,$ix+1);
  $ip=substr($ip,0,$ix);  
 }
 return pack('CCCCS',(split /\./,$ip),$port);
}

sub upckIp4Port {
 my $pckd=shift;
 return 0 unless length($pckd)==6;
 my @upck=unpack('CCCCS',$pckd);
 my $ip=join('.',@upck[0..3]);
 my $port=$upck[4];
 if (wantarray) {
  return ($ip,$port);
 } elsif (defined wantarray) {
  return "$ip:$port";
 } else {
  print STDERR "$ip:$port\n";
 }
}

1;
