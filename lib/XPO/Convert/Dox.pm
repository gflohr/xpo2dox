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
	my $content = join <$fh>;
	die "$filename: read error: $!\n" if !defined $content;

	return 'TODO';
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