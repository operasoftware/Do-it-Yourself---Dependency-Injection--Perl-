package Trade;

use Moose;

use Math::BigFloat;
use Account; 

use MarketClient;

has 'symbol' => ( is => 'ro', isa => 'Str' );
has 'quantity' => ( is => 'ro', isa => 'Math::BigFloat' );


1;
