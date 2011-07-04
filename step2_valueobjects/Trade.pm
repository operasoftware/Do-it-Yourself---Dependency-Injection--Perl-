package Trade;

use Moose;

use Math::BigFloat;
use Account; 

use MarketClient;

has 'symbol' => ( is => 'rw', isa => 'Str' );
has 'quantity' => ( is => 'rw', isa => 'Math::BigFloat' );


1;
