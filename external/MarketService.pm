use strict;
use warnings;

package MarketService;

use Math::BigFloat;

sub fetchPrices {
    print "Fetching prices\n";
    return { 
        symbol => Math::BigFloat->new( 1000 ),
    }
}

1;

