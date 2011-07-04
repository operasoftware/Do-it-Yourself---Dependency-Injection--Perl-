package SettlementCalculator;

use Moose;
use Math::BigFloat;

has price => ( is => 'ro', isa => 'Provider' );
has quantity => ( is => 'ro', isa => 'Math::BigFloat' );
has commission => ( is => 'ro', isa => 'Math::BigFloat' );

sub getSettlementAmount {
    my $self = shift;

    my $marketValue = $self->price->get->bmul( $self->quantity );
    my $settlementAmount = $marketValue->badd( $self->commission );
    return $settlementAmount;
}

1;
