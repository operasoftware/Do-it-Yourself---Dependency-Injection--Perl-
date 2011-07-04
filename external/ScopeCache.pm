use strict;
use warnings;

package ScopeCache;

my $cache = {};

sub get{
    my $provider = shift;
    if( $provider->isa( 'Provider' ) ){
		if( ! defined $cache->{ ref $provider } ) {
			$cache->{ ref $provider } = $provider->get();
		}
		return $cache->{ ref $provider };
	}
}

1;

