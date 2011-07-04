package MarketClient;

use Moose;
use Math::BigFloat;

use MarketService;



has cachedPrices => ( is => 'rw' );

my $instance = MarketClient->new( cachedPrices => MarketService->fetchPrices() );
sub getInstance { return $instance }

sub getPrice {
    my( $self, $symbol ) = @_;
    return $self->cachedPrices()->{$symbol};
}

1;
