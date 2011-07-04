package BookingService;

use Moose;

use Account; 
use MarketClient;

has market => ( is => 'ro', isa => 'MarketClient' );
has firmAccount => ( is => 'ro', isa => 'Account' );

sub buy {
    my( $self, $customerAccount, $trade, $commission ) = @_;
    my $price = $self->market->getPrice($trade->symbol);
    my $marketValue = $price->bmul( $trade->quantity );
    my $settlementAmount = $marketValue->badd( $commission );
    my $firmAccount = $self->firmAccount;
    $customerAccount->transferCash( $settlementAmount, $firmAccount );
    $firmAccount->transferSecurity( $trade->symbol, $trade->quantity, $customerAccount);
}

1;
