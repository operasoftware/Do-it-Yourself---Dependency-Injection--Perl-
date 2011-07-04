package BookingService;

use Account; 
use MarketClient;

sub buy {
    my( $customerAccount, $trade, $commission ) = @_;
    my $market = MarketClient->getInstance();
    my $price = $market->getPrice($trade->symbol);
    my $marketValue = $price->bmul( $trade->quantity );
    my $settlementAmount = $marketValue->badd( $commission );
    my $firmAccount = Account->getFirmAccount();
    $customerAccount->transferCash( $settlementAmount, $firmAccount );
    $firmAccount->transferSecurity( $trade->symbol, $trade->quantity, $customerAccount);
}

1;
