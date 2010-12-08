#!/usr/bin/perl

use strict;
use warnings;

use Test::More 'no_plan';

use ok 'SmartMatch::Sugar';

{
	package Bar;
	sub blah { }

	package Foo;
	use base qw(Bar);

	use overload fallback => 1, '""' => "blah";
}

foreach my $obj ( bless({}, "Foo"), bless([], "Bar") ) {
	ok( $obj ~~ object, "it's an object" );
	ok( $obj ~~ inv_can("isa"), "can 'isa'" );
	ok( $obj ~~ inv_can("blah"), "can 'isa'" );
	ok( ref($obj) ~~ class, "ref is a class" );
	ok( not( $obj ~~ class ), "the object is not a class though" );
	ok( $obj ~~ inv_isa("UNIVERSAL"), "isa universal" );
	ok( $obj ~~ inv_isa("Bar"), "isa Bar" );
	ok( not ( $obj ~~ inv_can("not_a_method") ), "can't nonexistent method" );
	ok( not ( $obj ~~ inv_isa("NotAClass") ), "not isa non existent class" );
	ok( not ( $obj ~~ non_ref ), '$obj is not a non_ref');
	ok( $obj ~~ any, '$obj is any');
	ok( not ( $obj ~~ none ), '$obj isn\'t none');
}

ok( bless({}, "Foo") ~~ overloaded, "object Foo is overloaded" );
ok( bless({}, "Foo") ~~ stringifies, "it stringifies, too" );
ok( not( "Foo" ~~ overloaded ), "but not the class itself" );

ok( not( bless({}, "Bar") ~~ overloaded ), "object Bar is not overloaded" );

ok( "Foo" ~~ inv_can("blah"), "Class can methods too" );

ok( 'Non empty string' ~~ non_empty_string, 'Non empty string is indeed non-empty');

ok( 'foobar' ~~ string_length_is(6));

