use strict;
use warnings;

use Test::More;

use lib '../external';

use TradingApplication;
TradingApplication::execute( 'user', 'symbol', 10, 1 );

my $account = Account->getCustomerAccount( 'user' );
is( $account->cash, -( 1000 * 10 + 1 ), 'Cash taken from user' );
is( $account->securities()->{symbol}, 10, 'Security transfered to customer' );

my $firm = Account->getFirmAccount;
is( $firm->cash, 1000 * 10 + 1, 'Cash transfered to company' );
is( $firm->securities()->{symbol}, -10, 'Security taken from company' );


done_testing;

