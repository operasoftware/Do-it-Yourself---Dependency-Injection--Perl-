package ApplicationScope;

use Moose;
use ScopeCache;

has args => ( is => 'ro', reader => 'getArgs' );

sub getMarketClient {
    my( $self, $freshMarketClientProvider ) = @_;

    return ScopeCache::get( $freshMarketClientProvider );
}

1;

