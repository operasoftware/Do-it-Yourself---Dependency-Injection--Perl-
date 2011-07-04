use strict;
use warnings;

package TradingApplication;

use parent 'ApplicationWrapper';
use ApplicationScope;
use TradingInjector;

sub execute {
    my @args = @_;
    my $applicationScope = ApplicationScope->new( args => \@args );
    my $bookingService = TradingInjector::injectBookingService( $applicationScope );
    $bookingService->buy( );
}

1;

