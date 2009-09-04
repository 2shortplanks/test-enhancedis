#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;
use Test::Builder::Tester;
use Term::ANSIColor qw(colored);

use Test::EnhancedIs qw(disable_command_line_checks);

test_out("not ok 1");
test_fail(+3);
test_diag("         got: 'fo".colored("*","white on_red")."oo'");
test_diag("    expected: 'fo".colored("*","white on_red")."ao'");
is("fooo","foao");
test_test("midstring");

test_out("not ok 1");
test_fail(+3);
test_diag("         got: 'foo".colored("*","white on_red")."'");
test_diag("    expected: 'foo".colored("*","white on_red")."oo'");
is("foo","foooo");
test_test("end expect");

test_out("not ok 1");
test_fail(+3);
test_diag("         got: 'foo".colored("*","white on_red")."oo'");
test_diag("    expected: 'foo".colored("*","white on_red")."'");
is("foooo","foo");
test_test("end expect");
