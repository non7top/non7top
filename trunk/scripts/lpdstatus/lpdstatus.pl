#/usr/bin/env perl

if ($#ARGV <0){
	print "\nUsage: lpdstatus.pl LPDSERVER [QUEUE]\n";
	exit 1;
}

use IO::Socket;
$server = $ARGV[0];
$queue = $ARGV[1];
my $sock = new IO::Socket::INET ( 
	PeerAddr => $server,
	PeerPort => '515',
	Proto => 'tcp',
	Timeout => 15,
); 
die "lpdstatus> Error: Could not create socket: $!\n" unless $sock; 

sub print_answer
{
    printf("lpdstatus> Recieved answer: %s bytes.", length(join("",@_)));
    print("================");
    printf("%s", join("",@_));
    print("================\n");
}


$command = sprintf ("%c%s\n", 4, $queue);
printf $sock $command; 
        # Read response from server and format
        eval {
                local $SIG{ALRM} = sub { die "timeout\n" };
                alarm 15;
                while (<$sock>) {
                        push(@qstatus, $_);
                }
                alarm 0;
                1;
        };


    if( $@ )
    {

	print_answer @qstatus;
	printf("lpdstatus> Error: timed out reading from %s\n", $server)
            if( $@ =~ /timeout/ );

    }else{
	print_answer @qstatus;
	printf("lpdstatus> Exiting sucessfully.\n");
    }


close($sock);
