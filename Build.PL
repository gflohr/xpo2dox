use strict;
use warnings;
use Module::Build;
 
use 5.008;
 
my $builder = Module::Build->new(
	module_name => 'xpo2dox',
	dist_abstract => 'Convert XPO to Doxygen/CS sources',
	dist_version_from => 'lib/XPO/AOT2Dox.pm',
	create_makefile_pl => 0,
	script_files => 'aot2dox',
	create_readme => 0,
	requires => {
		Git => 0,
	},
	build_requires => {
		'Test::More' => '0',
	},
	meta_merge => {
		resources => {
			repository => 'https://github.com/gflohr/xpo2doc',
			bugtracker => 'https://github.com/gflohr/xpo2doc/issues'
		}
	},
);
 
$builder->create_build_script();