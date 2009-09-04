package Test::EnhancedIs;
use base qw(Devel::UseFromCommandLineOnly);

use strict;
use warnings;
no warnings "redefine"; ## no critic (ProhibitNoWarnings)

our $VERSION = 0.00_01;

use Term::ANSIColor qw(colored);
use List::Util qw(min);

use Test::Builder;

# remember the original subroutine.  Note the BEGIN { } here - this is because
# without it this code will be run after the sub Test::Builder::_is_diag
# has been declared and we'll grab a ref to the wrong subroutine
my $uboat;
BEGIN { $uboat = \&Test::Builder::_is_diag }; ## no critic (ProtectPrivateVars)

# now write a new subroutine, overriding the subroutine in another package
# don't try this at home kids.
sub Test::Builder::_is_diag { ## no critic (ProtectPrivateSubs)
  my( $self, $got, $type, $expect ) = @_;

  # look for either a different character, or the end of either string
  my $index;
  foreach (0..min(length $got,length $expect)) {
    $index = $_;
    last if substr($got,$index,1) ne substr($expect,$index,1);
  }

  # put a marker in there
  substr($got,$index,0,colored("*","white on_red"));
  substr($expect,$index,0,colored("*","white on_red"));

  # run the original code
  return $uboat->($self,$got,$type,$expect);
}

1;

__END__

=head1 NAME

Test::EnhancedIs - show where things differ with Test::Builder

=head1 SYNOPSIS

  # Run your tests like so:
  perl -Ilib -MTest::EnhancedIs t/test.t

  # this will print out a red backgrounded astrix before the second o
  use Test::More tests => 1;
  is("fooo","foao");

=head1 DESCRIPTION

Helper module that monkeypatches Test::Builder to point out where the
string differ.

WARNING: This code is EXPERIMENTAL and relies on code in the internals
of Test::Builder that could change AT ANY TIME.  Use at your own Perl.
DO NOT hardcode this into your test scripts.

=head1 AUTHOR

Written by Mark Fowler E<lt>mark@twoshortplanks.comE<gt>

Copryright Mark Fowler 2009.  All Rights Reserved.

This program is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.

=head1 BUGS

Probably many.  This jumps into Test::Builder's internals.
This is a bad idea.

=head1 SEE ALSO

L<Test::More>, L<Test::Builder>

=cut
