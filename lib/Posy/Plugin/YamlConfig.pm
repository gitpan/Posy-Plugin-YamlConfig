package Posy::Plugin::YamlConfig;
use strict;

=head1 NAME

Posy::Plugin::YamlConfig - Posy plugin to read config files in YAML format.

=head1 VERSION

This describes version B<0.41> of Posy::Plugin::YamlConfig.

=cut

our $VERSION = '0.41';

=head1 SYNOPSIS

    @plugins = qw(Posy::Core
	Posy::Plugin::YamlConfig
	...);

=head1 DESCRIPTION

This uses the YAML module to parse config files, instead of the
default name:value format.  This enables config values to be
more complicated than simple strings; they can be arrays and hashes,
put in a simple format that's user-friendly.

For a simple name:value set of config variables, the only difference
between YAML format and Posy::Core format is that the file has to
start with a line of three dashes:

    ---
    site_title: My Wonderful Site
    sort_type: path

See L</YAML> for further details of YAML format.  If you have problems with
a particular config file, use the ysh program to help figure out what's
wrong and fix it.  (If the YAML module is installed, so should ysh be)

This replaces the 'read_config_file' method, and returns the hash
of values read.

=cut

use YAML;

=head1 Helper Methods

Methods which can be called from within other methods.

=head2 read_config_file

$self->read_config_file($filename);

Read the given config file, and return a hash of config settings from it.
The $filename is the full name of the file to read.

The config file is expected to be in YAML format.

=cut
sub read_config_file {
    my $self = shift;
    my $filename = shift;

    $self->debug(2, "read_config_file: $filename");
    my %config;
    if (-r $filename)
    {
	my $hashref = YAML::LoadFile($filename);
	%config = %{$hashref} if $hashref;
	return %config;
    }
    return ();
} # read_config_file

=head1 INSTALLATION

Installation needs will vary depending on the particular setup a person
has.

=head2 Administrator, Automatic

If you are the administrator of the system, then the dead simple method of
installing the modules is to use the CPAN or CPANPLUS system.

    cpanp -i Posy::Plugin::YamlConfig

This will install this plugin in the usual places where modules get
installed when one is using CPAN(PLUS).

=head2 Administrator, By Hand

If you are the administrator of the system, but don't wish to use the
CPAN(PLUS) method, then this is for you.  Take the *.tar.gz file
and untar it in a suitable directory.

To install this module, run the following commands:

    perl Build.PL
    ./Build
    ./Build test
    ./Build install

Or, if you're on a platform (like DOS or Windows) that doesn't like the
"./" notation, you can do this:

   perl Build.PL
   perl Build
   perl Build test
   perl Build install

=head2 User With Shell Access

If you are a user on a system, and don't have root/administrator access,
you need to install Posy somewhere other than the default place (since you
don't have access to it).  However, if you have shell access to the system,
then you can install it in your home directory.

Say your home directory is "/home/fred", and you want to install the
modules into a subdirectory called "perl".

Download the *.tar.gz file and untar it in a suitable directory.

    perl Build.PL --install_base /home/fred/perl
    ./Build
    ./Build test
    ./Build install

This will install the files underneath /home/fred/perl.

You will then need to make sure that you alter the PERL5LIB variable to
find the modules, and the PATH variable to find the scripts (posy_one,
posy_static).

Therefore you will need to change:
your path, to include /home/fred/perl/script (where the script will be)

	PATH=/home/fred/perl/script:${PATH}

the PERL5LIB variable to add /home/fred/perl/lib

	PERL5LIB=/home/fred/perl/lib:${PERL5LIB}


=head1 REQUIRES

    Posy
    Posy::Core

    YAML

    Test::More

=head1 SEE ALSO

perl(1).
Posy
YAML

=head1 BUGS

Please report any bugs or feature requests to the author.

=head1 AUTHOR

    Kathryn Andersen (RUBYKAT)
    perlkat AT katspace dot com
    http://www.katspace.com

=head1 COPYRIGHT AND LICENCE

Copyright (c) 2004-2005 by Kathryn Andersen

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1; # End of Posy::Plugin::YamlConfig
__END__
