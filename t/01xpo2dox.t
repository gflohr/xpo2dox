use strict;

use Test::More;

use XPO::Convert::Dox;

my @tests = qw(
	class-extends.xpo
	class-implements.xpo
	class-public.xpo
	enum.xpo
	interface.xpo
	job.xpo
);

plan tests => 1 + ((scalar @tests) << 1);

my $converter = XPO::Convert::Dox->new;
ok $converter, "constructor";

foreach my $test (@tests) {
	my $src = "t/$test";
	my $expect_file = "$src.cs";
	my $got = $converter->convert($src);
	ok defined $got;

	open my $fh, '<', $expect_file or die "$expect_file: $!";
	my $wanted = join '', <$fh>;
	is $got, $wanted, "convert $test";
}