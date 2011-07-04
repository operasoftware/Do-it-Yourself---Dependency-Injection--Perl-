package Trade;

use Moose;

use Math::BigFloat;
use Account; 

use MarketClient;

has 'symbol' => ( is => 'rw', isa => 'Str' );
has 'quantity' => ( is => 'rw', isa => 'Math::BigFloat' );

sub buy {
    my( $self, $customerAccount, $commission ) = @_;
    my $market = MarketClient->getInstance();
    my $price = $market->getPrice($self->symbol);
    my $marketValue = $price->bmul( $self->quantity );
    my $settlementAmount = $marketValue->badd( $commission );
    my $firmAccount = Account->getFirmAccount();
    $customerAccount->transferCash( $settlementAmount, $firmAccount );
    $firmAccount->transferSecurity( $self->symbol, $self->quantity, $customerAccount);
}

1;
