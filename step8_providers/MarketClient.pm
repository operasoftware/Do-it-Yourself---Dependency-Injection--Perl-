package MarketClient;

use Moose;
use Math::BigFloat;

use MarketService;


has cachedPrices => ( is => 'rw' );

my $instance;

sub getInstance { 
    if( defined $instance ){
        return $instance
    }
    else{
        $instance = MarketClient->new( cachedPrices => MarketService->fetchPrices() );
    }
}

sub getPrice {
    my( $self, $symbol ) = @_;
    return $self->cachedPrices()->{$symbol};
}

1;
