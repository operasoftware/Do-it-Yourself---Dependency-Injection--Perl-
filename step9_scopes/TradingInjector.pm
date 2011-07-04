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


sub injectBookingService {
    my $applicationScope = shift;
    return BookingService->new(
        firmAccount => injectFirmAccount(),
        customerAccount => injectCustomerAccount( $applicationScope ),
        trade => injectTrade( $applicationScope ),
        settlementAmount => injectSettlementAmount( $applicationScope ),
    )
}

sub injectSettlementAmount { injectSettlementCalculator( shift )->getSettlementAmount() }

sub injectSettlementCalculator {
    my $applicationScope = shift;
    return SettlementCalculator->new(
        price => injectPriceProvider( $applicationScope ),
        quantity => injectQuantity( $applicationScope ),
        commission => injectCommission( $applicationScope ),
    );
}

sub injectPriceProvider { 
    my $applicationScope = shift; 
    return Provider->new( something => sub { injectPrice( $applicationScope ) } );
}

sub injectPrice { 
    my $applicationScope = shift;
    my $marketClient = injectMarketClient( $applicationScope );
    return $marketClient->getPrice( injectSymbol( $applicationScope ) );
}

sub injectMarketClient { shift->getMarketClient( injectFreshMarketClientProvider() ) }

sub injectFreshMarketClientProvider {
    my $applicationScope = shift;
    return Provider->new( something => sub { injectFreshMarketClient( $applicationScope ) } );
}

sub injectFreshMarketClient{ MarketClient->new( cachedPrices => injectMarketPrices() ) }

sub injectMarketPrices { MarketService->fetchPrices() }

sub injectTradingArgs { TradingArgs->new( args => injectArgs( shift ) ) }

sub injectArgs { shift->getArgs() }

sub injectSymbol { injectTradingArgs( shift )->getSymbol() }

sub injectQuantity { injectTradingArgs( shift )->getQuantity() }

sub injectCommission { injectTradingArgs( shift )->getCommission() }

sub injectAccountKey { injectTradingArgs( shift )->getAccountKey }

sub injectTrade { 
    my $applicationScope = shift;
    Trade->new( 
        symbol => injectSymbol( $applicationScope ), 
        quantity => injectQuantity( $applicationScope ) 
    ) 
}

sub injectCustomerAccount { Account->getCustomerAccount( injectAccountKey( shift ) ) }

sub injectFirmAccount { Account->getFirmAccount() }


1;
