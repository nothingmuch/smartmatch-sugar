#!/usr/bin/perl -w

use strict;

use ExtUtils::MakeMaker;

require 5.010;

WriteMakefile(
	NAME         => '',
	VERSION_FROM => '',
	INSTALLDIRS  => 'site',
	SIGN         => 1,
	PL_FILES     => { },
	PREREQ_PM    => {
		'Test::use::ok' => 0,
		'Scalar::Util' => 0, # core in 5.10.0 but whatever
		'Class::Inspector' => 0,
	},
);

