use strict;
use warnings;

package TradingApplication;

use parent 'ApplicationWrapper';
use TradingInjector;

sub execute {
    my @args = @_;
    my $bookingService = TradingInjector::injectBookingService( @args );
    $bookingService->buy( );
}

1;

