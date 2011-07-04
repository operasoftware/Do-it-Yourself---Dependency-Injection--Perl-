use strict;
use warnings;

package TradingInjector;

use Account; 
use MarketClient;
use Trade;
use TradingArgs;

use MarketService;
use MarketClient;
use BookingService;
use Trade;
use Account;


my $instance;
        
sub injectMarketPrices { MarketService->fetchPrices() }
        
sub injectMarketClient {
    if( ! defined $instance ){
        $instance = MarketClient->new( cachedPrices => injectMarketPrices );
    }
    return $instance
}

sub injectBookingService {
    my @args = @_;
    return BookingService->new(
        market => injectMarketClient(),
        firmAccount => injectFirmAccount(),
        customerAccount => injectCustomerAccount( @args ),
        trade => injectTrade( @args ),
        commission => injectCommission( @args )
    )
}

sub injectTradingArgs { TradingArgs->new( args => \@_ ) }

sub injectSymbol { injectTradingArgs( @_ )->getSymbol() }

sub injectQuantity { injectTradingArgs( @_ )->getQuantity() }

sub injectCommission { injectTradingArgs( @_ )->getCommission }

sub injectAccountKey { injectTradingArgs( @_ )->getAccountKey }

sub injectTrade { Trade->new( symbol => injectSymbol( @_ ), quantity => injectQuantity( @_ ) ) }

sub injectCustomerAccount { Account->getCustomerAccount( injectAccountKey( @_ ) ) }

sub injectFirmAccount { Account->getFirmAccount }


1;
