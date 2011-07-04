package Account;

use Moose;

has id => ( is => 'ro', isa => 'Str' );
has securities => ( is => 'rw', default => sub { {} } );
has cash => ( is => 'rw', isa => 'Math::BigFloat' );

my %accounts;

sub getCustomerAccount {
    my( $class, $id ) = @_;
    print "Using account: '$id'\n";
    if( !exists $accounts{$id} ){
        $accounts{$id} = $class->new( id => $id );
    }
    return $accounts{$id};
}

my $firm = Account->new( id => 'our company' );

sub getFirmAccount {
    my( $class ) = @_;
    return $firm;
}

sub transferSecurity {
    my( $self, $symbol, $quantity, $account ) = @_;
    print "Transferring $quantity of $symbol to " . $account->id . "\n";
    $self->securities()->{$symbol} -= $quantity;
    $account->securities()->{$symbol} += $quantity;
}

sub transferCash {
    my( $self, $quantity, $account ) = @_;
    print "Transferring $quantity of cash to " . $account->id . "\n";
    $self->cash( $self->cash - $quantity );
    $account->cash( $account->cash + $quantity );
}


1;
