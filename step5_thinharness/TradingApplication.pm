use strict;
use warnings;

package TradingApplication;

use parent 'ApplicationWrapper';
use BookingService;

sub execute {
    my @args = @_;
    my $bookingService = BookingService->fromArgs( @args );
    $bookingService->buy( );
}

1;

