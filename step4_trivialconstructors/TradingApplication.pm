use strict;
use warnings;

package TradingApplication;

use parent 'ApplicationWrapper';
use Account;
use Math::BigFloat;

use Trade;
use BookingService;

sub execute {
    my @args = @_;
    my $accountKey = $args[0];
    my $customerAccount = Account->getCustomerAccount( $accountKey );
    my $symbol = $args[1];
    my $quantity = Math::BigFloat->new( $args[2] );
    my $commission = Math::BigFloat->new( $args[3] );
    my $trade = Trade->new( symbol => $symbol, quantity => $quantity );
    my $bookingService = BookingService->new( firmAccount => Account->getFirmAccount, market => MarketClient->getInstance() );
    $bookingService->buy( $customerAccount, $trade, $commission );
}

1;

