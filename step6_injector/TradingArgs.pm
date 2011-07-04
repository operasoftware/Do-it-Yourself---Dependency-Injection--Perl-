package TradingArgs;

use Moose;

use Math::BigFloat;

has args => ( is => 'ro' );

sub getAccountKey { shift->args->[0] }

sub getSymbol { shift->args->[1] }

sub getQuantity { Math::BigFloat->new( shift->args->[2] ) }

sub getCommission { Math::BigFloat->new( shift->args->[3] ) }


1;

