package BookingService;

use Moose;

use Account; 
use MarketClient;
use Trade;
use TradingArgs;

has firmAccount => ( is => 'ro', isa => 'Account' );

has customerAccount => ( is => 'ro', isa => 'Account' );
has trade => ( is => 'ro', isa => 'Trade' );
has settlementAmount => ( is => 'ro', isa => 'Math::BigFloat' );

sub buy {
    my $self = shift;
    my $firmAccount = $self->firmAccount;
    $self->customerAccount->transferCash( $self->settlementAmount, $firmAccount );
    $firmAccount->transferSecurity( $self->trade->symbol, $self->trade->quantity, $self->customerAccount);
}

1;
