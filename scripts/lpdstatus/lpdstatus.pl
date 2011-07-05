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
	PeerPort => '1234',
	Proto => 'tcp',
); 
die "Error: Could not create socket: $!\n" unless $sock; 

sub print_answer
{
    use bytes;
    printf("Recieved answer: %s bytes. \n%s\n", length(join("",@_)));
    printf("%s\n", join("",@_));
}


$command = sprintf ("%c%s", 4, $queue);
#printf $command;
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
	printf("Error: timed out reading from %s\n", $server)
            if( $@ =~ /timeout/ );

    }else{
	print_answer @qstatus;
	printf("Exiting sucessfully.\n");
    }


close($sock);
