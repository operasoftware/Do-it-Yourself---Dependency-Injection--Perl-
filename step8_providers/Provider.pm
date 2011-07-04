package Provider;

use Moose;

has something => ( is => 'ro' );

sub get { shift->something->() }

1;
