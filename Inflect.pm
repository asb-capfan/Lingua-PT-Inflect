package Lingua::PT::Inflect;

use 5.006;
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

our $VERSION = '0.04';

=head1 NAME

Lingua::PT::Inflect - Converts Portuguese words from singular to plural.

=head1 SYNOPSIS

  use Lingua::PT::Inflect;

  $plural = sing2plural('programador')   # now holds 'programadores'

=cut

my (%exceptions,@rules,%rules);

BEGIN {
  %exceptions = (
    'l�pis'	=> 'l�pis',
    'pires'	=> 'pires',

    'm�o'	=> 'm�os',
    'afeg�o'	=> 'afeg�os',

    'p�o'	=> 'p�es',
    'capit�o'	=> 'capit�es',
    'c�o'	=> 'c�es',
    'alem�o'	=> 'alem�es',
  );

  @rules = map { qr/$_/ } qw(�s �s el ol al oi ul m �o (?<=[aeiou]) (?<=[rnsz]));

  %rules = (
    qr/�s/	=> 'ases',
    qr/�s/	=> 'eses',
    qr/el/	=> '�is',
    qr/ol/	=> '�is',
    qr/al/	=> 'ais',
    qr/oi/	=> 'ois',
    qr/ul/	=> 'uis',
    qr/m/	=> 'ns',
    qr/�o/	=> '�es',
    qr/(?<=[aeiou])/	=> 's',
    qr/(?<=[rnsz])/	=> 'es',
  );

}

#

sub new {
  my ($self, $word) = @_;
  bless \$word, $self;
}

sub sing2plural {
  defined $_[0] || return undef;

  my $word;
  if (ref($_[0]) eq 'Lingua::PT::Inflect') {
    my $self = shift;
    $word = $$self;
  }
  else {
    $word = shift;
  }

  $_ = $word;

  defined $exceptions{$_} && return $exceptions{$_};

  for my $rule (@rules) {
    if (s/$rule$/$rules{$rule}/) {return $_}
  }

  if (/il$/) {
    my @syl = hyphenate($_);

    s!il$!$syl[-2] =~ /[��������������������]/ ? 'eis' : 'is' !e;
  }

  return $_;
}

1;
__END__

=head1 DESCRIPTION

Converts Portuguese words from singular to plural. There may be some
special cases that will fail (words ending in -�o or -s might fail, as
many special cases are yet to be prevented; anyone volunteering to look
at a huge list of words?)

=head1 SEE ALSO

If you're looking for Natural Language Processing tools, you may like
this Portuguese site: http://natura.di.uminho.pt

Gram�tica Universal da L�ngua Portuguesa (Texto Editora)

=head1 AUTHOR

Jose Alves de Castro, E<lt>cog [at] cpan [dot] org<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2004 by Jose Alves de Castro

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut
