package XPO::Convert::Dox;

use strict;

sub new {
	my ($class) = @_;

	my $self = '';

	bless \$self, $class;
}

sub convert {
	my ($self, $filename) = @_;

	open my $fh, '<', $filename or die "$filename: $!\n";
	
	my $cs = '';
	my ($is_in_class, $is_job);
	my $indent;
	while (my $line = <$fh>) {
		$line =~ s/^[ \t]*#//;
		my $in_body = $is_in_class || $is_job;
	
		if ($line =~ /^Exportfile for AOT version 1.0 or later/) {
			$indent = ' ' x 4;
			$cs .= '/** xpo2dox generated namespace for all classes. */ namespace AX { // '
				. $line;
		} elsif (!$in_body && $line =~ /(class)|(interface)/i) {
			$is_in_class = 1;

			$line =~ s/extends/:/;
			$line =~ s/implements/:/;

			$cs .= $indent . $line;
		} elsif ($is_in_class && $line =~ /^}/) {
			# The closing brace will be printed at the end of the file instead of the
			# end of the class declaration.
			#
			# As a consequence, all class members and methods will be inside the braces.
			undef $is_in_class;
			$indent = ' ' x 8;

			$cs .= $indent . '//' . $line;
		} elsif ($is_in_class && $line =~ /ENDCLASS/) {
			$indent = ' ' x 4;

			$cs .= $indent . '} // ' . $line;
		} elsif (!$in_body && $line =~ /JOBVERSION/) {
			$is_job = 1;

			$cs .= '/** xpo2dox generated wrapper class for all jobs. */ partial class Jobs { // '
				. $line;

			$indent = ' ' x 8;
		} elsif ($is_job && $line =~ /ENDSOURCE/) {
			undef $is_job;
			$indent = ' ' x 4;
			$cs .= $indent . '} // ' . $line;
		} elsif ($line =~ /\*\*\*Element: END/) {
			$indent = "";

			$cs .= $indent . '} // ' . $1;
		} elsif ($2 != "") {
			# Normal line of code
			$cs .= $indent . $line;
		} else {
			# Structuring element of the AX XPO (no code)
			$cs .= $indent . '//' . $line;
		}
	}

	return $cs;
}

1;


=head1 NAME

XPO::Convert::Dox - Convert an AX XPO File to C# Pseudo Code

=head1 SYNOPSIS

    $cs = XPO::Convert::Dox->new->convert($filename);

=head1 DESCRIPTION

Convert an XPO file to C# pseudo code.

=head1 CONSTRUCTOR

=over 4

=item B<new>

Create a converter instance.

=back

=head1 METHODS

=over 4

=item B<convert FILENAME>

Convert the file FILENAME into pseudo code that gets returned as a string.
Throws an exception if unsuccessful.

=over 8

=item F<Application Developer Documentation>

=item F<Application Documentation>

=item F<System Documentation>

=item F<.vscode>

=back

=back

=head1 SEE ALSO

L<XPO::Convert::Dox>, perl(1)