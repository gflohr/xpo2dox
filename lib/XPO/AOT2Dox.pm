package XPO::AOT2Dox;

use strict;

use Getopt::Long 2.36 qw(GetOptionsFromArray);
use Time::HiRes qw(gettimeofday);
use Git;

use XPO::Convert::Dox;

our $VERSION = '0.1.0';

sub new {
	my ($class, $options, @argv) = @_;

	($options->{source_directory}, $options->{output_directory}) = @argv;

	bless $options, $class;
}

sub newFromArgv {
	my ($class, @argv) = @_;

	my $self;
	if (ref $class) {
		$self = $class;
	} else {
		$self = bless {}, $class;
	}

	my %options = eval { $self->__getOptions(\@argv) };
	if ($@) {
		$self->__usageError($@);
	}

	$self->__displayUsage if $options{help};
	delete $options{help};

	if ($options{version}) {
		delete $options{version};
		$self->__versionInformation;
		exit 0;
	}

	if (@argv != 2) {
		my $pn = $self->__programName;
		$self->__usageError("Usage: $pn SOURCEDIR OUTPUTDIR");
	}

	return $class->new(\%options, @argv);
}

sub run {
	my ($self) = @_;

	my $files = $self->__gatherFiles;
	my $total = @$files;

	my $converter = XPO::Convert::Dox->new;
	my $srcdir = $self->{source_directory};

	my $count = 0;
	foreach my $filename (@$files) {
		++$count;
		$self->info("($count/$total) '$filename'");
		eval {
			my $path = "$srcdir/$filename";
			my $cs = $converter->convert($path);
		};
		if ($@) {
			$self->fatal($@);
		}
	}

	return $self;
}

sub info {
	my ($self, @message) = @_;

	return $self if !$self->{verbose};

	return $self->__log(info => @message);
}

sub fatal {
	my ($self, @message) = @_;

	$self->__log(fatal => @message);

	exit 1;
}

sub __log {
	my ($self, $level, @message) = @_;

	my ($epoch, $usec) = gettimeofday;
	my ($sec, $min, $hour,
	    $mday, $mon, $year) = localtime $epoch;

	my $timestamp = sprintf(
		'%04u-%02u-%02uT%02u:%02u:%02u.%06uZ',
		$year + 1900, $mon + 1, $mday, $hour, $min, $sec,
		$usec
	);

	foreach my $message (@message) {
		$message =~ s/\s+$//;
		print STDERR "[$timestamp][$level] $message\n";
	}

	return $self
}

sub __gatherFiles {
	my ($self) = @_;

	$self->info("start gathering files");

	my $repo = Git->repository(Directory => $self->{source_directory});
	my @files = grep { /\.xpo$/ }
		grep { ! m{^\.vscode/} }
		grep { ! m{^System Documentation/} }
		grep { ! m{^Application(?: Developer)? Documentation/} }
		$repo->command('ls-files');

	my $num_files = @files;
	$self->info("found $num_files source files");

	return \@files;
}

sub __getOptions {
	my ($self, $argv) = @_;

	my %options;

	Getopt::Long::Configure('bundling');

	# Make all warnings fatal.
	$SIG{__WARN__} = sub {
		$SIG{__WARN__} = 'DEFAULT';
		die shift;
	};

	GetOptionsFromArray($argv,
		# Mode of operation.
		'v|verbose' => \$options{verbose},

		# Informative output.
		'h|help' => \$options{help},
		'V|version' => \$options{version},
	);

	# Restore warning handler.
	$SIG{__WARN__} = 'DEFAULT';

	foreach my $key (keys %options) {
		delete $options{$key} if !defined $options{$key};
	}

	return %options;
}

sub __versionInformation {
	my ($self) = @_;

	my $package = ref $self;

	my $version;
	{
		## no critic
		no strict 'refs';

		my $varname = "${package}::VERSION";
		$version = ${$varname};
	};

	$version = '' if !defined $version;

	$package =~ s/::/-/g;

	my $program_name = $self->__programName;

	print <<"EOF";
${program_name} (${package}) ${version}
Please see the source for copyright information!
EOF
}

sub __programName { $0 }

sub __displayUsage {
	my ($self) = @_;

	my $program_name = $self->__programName;

	print <<"EOF";
Usage: $program_name SOURCEDIR OUTPUTDUR

Convert AX Export XPO Files to C# Pseudo Code

Mandatory arguments to long options are mandatory for short options too.
Similarly for optional arguments.

File Locations:

  SOURCEDIR                   directory containing a checkout of our AX40 AOT
  OUTPUTDIR                   name of the output directory to store the
                              code-only XPO files (must not exist!)

Mode of Operation:

  -v, --verbose               enable verbose output on standard error

Informative output:
  -h, --help                  display this help and exit
  -V, --version               output version information and exit

Report bugs at https://github.com/gflohr/xpo2dox/issues
EOF

	exit 0;
}

sub __usageError {
	my ($self, $message) = @_;

	my $program_name = $self->__programName;

	if (defined $message && length $message) {
		$message =~ s/\s+$//;
		$message = "$program_name: $message\n";
	} else {
		$message = '';
	}

	die $message . "Try '$program_name --help' for more information!\n";
}

1;

=head1 NAME

XPO::AOT2Dox - Convert AX Export XPO Files to C# Pseudo Code

=head1 SYNOPSIS

    XPO::AOT2Dox->new($options, $src, $dest)->run;

=head1 DESCRIPTION

Convert an entire Git repository with XPO files to C# pseudo code.

=head1 CONSTRUCTOR

=over 4

=item B<new OPTIONS, SOURCE, DEST>

Create a conversion object.  B<OPTIONS> must be a possible empty hash reference
with the following allowed keys:

=over 8

=item B<verbose> - enable verbose output on standard error

=back

=item B<newFromARGV ARG, ...>

Command-line interface. Call this with the C<ARGV> of a script.  The options
will get converted into options suitable for the L</new> constructor.

=back

=head1 METHODS

=over 4

=item B<run>

Do the actual work by creating a converter L<XPO::Convert::Dox> for each source
file found.  Source files are all non-directory files in the git repository
that have a filename extension F<.xpo> and are not in one of the following
top-level directories:

=over 8

=item F<Application Developer Documentation>

=item F<Application Documentation>

=item F<System Documentation>

=item F<.vscode>

=back

=back

=head1 SEE ALSO

L<XPO::Convert::Dox>, perl(1)