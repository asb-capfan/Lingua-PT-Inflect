package Lingua::PT::Inflect;

use 5.008;
use strict;
use warnings;
use Lingua::PT::Hyphenate;

require Exporter;

our @ISA = qw(Exporter);

our %EXPORT_TAGS = ( 'all' => [ qw(
	sing2plural
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	sing2plural
);

our $VERSION = '0.02';

=head1 NAME

Lingua::PT::Inflect - Converts Portuguese words from singular to plural.

=head1 SYNOPSIS

  use Lingua::PT::Inflect;

  $plural = sin2plural('anel')   # now holds 'aneis'

=cut

my (%exceptions,@rules,%rules);

BEGIN {
  %exceptions = (
    'l·pis'	=> 'l·pis',
    'pires'	=> 'pires',

    'm„o'	=> 'm„os',
    'afeg„o'	=> 'afeg„os',

    'p„o'	=> 'p„es',
    'capit„o'	=> 'capit„es',
    'c„o'	=> 'c„es',
    'alem„o'	=> 'alem„es',
  );

  @rules = map { qr/$_/ } qw(·s Ís el ol al oi ul m „o (?<=[aeiou]) (?<=[rnsz]));

  %rules = (
    qr/·s/	=> 'ases',
    qr/Ís/	=> 'eses',
    qr/el/	=> 'Èis',
    qr/ol/	=> 'Ûis',
    qr/al/	=> 'ais',
    qr/oi/	=> 'ois',
    qr/ul/	=> 'uis',
    qr/m/	=> 'ns',
    qr/„o/	=> 'ıes',
    qr/(?<=[aeiou])/	=> 's',
    qr/(?<=[rnsz])/	=> 'es',
  );

}

sub sing2plural {
  $_ = shift;
  defined $_ || return undef;

  defined $exceptions{$_} && return $exceptions{$_};

  for my $rule (@rules) {
    if (s/$rule$/$rules{$rule}/) {return $_}
  }

  if (/il$/) {
    my @syl = hyphenate($_);

    s!il$!$syl[-2] =~ /[„‚·ÍÈÌÛıÙ˙√¡…Õ”’‘ ¬⁄]/ ? 'eis' : 'is' !e;
  }

  return $_;
}

1;
__END__

=head1 DESCRIPTION

Converts Portuguese words from singular to plural. There may be some
special cases that will fail (words ending in -„o or -s might fail);
this should be taken care of soon.

=head1 SEE ALSO

If you're into Natural Language Processing tools, you may like this
Portuguese site: http://natura.di.uminho.pt

Gram·tica Universal da LÌngua Portuguesa (Texto Editora)

=head1 MESSAGE FROM THE AUTHOR

If you're using this module, please drop me a line to my e-mail. Tell
me what you're doing with it. Also, feel free to suggest new
bugs^H^H^H^H^H features.

=head1 AUTHOR

Jose Alves de Castro, E<lt>cog [at] cpan [dot] org<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2004 by Jose Alves de Castro

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut
