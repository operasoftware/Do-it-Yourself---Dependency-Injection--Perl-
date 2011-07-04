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
use SettlementCalculator;
use Provider;

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
        firmAccount => injectFirmAccount(),
        customerAccount => injectCustomerAccount( @args ),
        trade => injectTrade( @args ),
        settlementAmount => injectSettlementAmount( @args ),
    )
}

sub injectSettlementAmount { injectSettlementCalculator( @_ )->getSettlementAmount }

sub injectSettlementCalculator {
    my @args = @_;
    return SettlementCalculator->new(
        price => injectPrice( @args ),
        quantity => injectQuantity( @args ),
        commission => injectCommission( @args ),
    );
}

sub injectPrice { injectMarketClient->getPrice( injectSymbol( @_ ) ) }

sub injectTradingArgs { TradingArgs->new( args => \@_ ) }

sub injectSymbol { injectTradingArgs( @_ )->getSymbol() }

sub injectQuantity { injectTradingArgs( @_ )->getQuantity() }

sub injectCommission { injectTradingArgs( @_ )->getCommission }

sub injectAccountKey { injectTradingArgs( @_ )->getAccountKey }

sub injectTrade { Trade->new( symbol => injectSymbol( @_ ), quantity => injectQuantity( @_ ) ) }

sub injectCustomerAccount { Account->getCustomerAccount( injectAccountKey( @_ ) ) }

sub injectFirmAccount { Account->getFirmAccount }


1;
