package Lingua::PT::Inflect;

use 5.008;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

our %EXPORT_TAGS = ( 'all' => [ qw(
	sing2plural
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	sing2plural
);

our $VERSION = '0.01';

=head1 NAME

Lingua::PT::Inflect - Converts Portuguese words from singular to plural.

=head1 SYNOPSIS

  use Lingua::PT::Inflect;

  $plural = sin2plural('anel')   # now holds 'anéis'

=cut

my %sing2plural; # this hash stores special cases

BEGIN {
  %sing2plural = (
    'lápis'	=> 'lápis',
    'pires'	=> 'pires',

    'pírex'	=> 'pírex',
    'inox'	=> 'inox',

    'mão'	=> 'mãos',

    'pão'	=> 'pães',
    'capitão'	=> 'capitães',
    'cão'	=> 'cães',

    'leão'	=> 'leões',
  );
}

sub sing2plural {
  $_ = shift;
  defined $_ || return undef;

  defined $sing2plural{$_} && return $sing2plural{$_};

  # -s, -x -> no change is needed (unless its a particular case)
  # if (s/[sx]$//) {return $_}
  # -ás, -ês -> adds 'es'
  if (s/ás$/ases/) {return $_}
  if (s/ês$/eses/) {return $_}
  # -il tónico -> the 'l' changes to 's' NOT YET IMPLEMENTED
  # if (s/il$/is/) {return $_}
  # -il átono -> changes to 'eis' NOT YET IMPLEMENTED
  # if (s/il$/eis/) {return $_}
  # -el, -ol -> -éis, -óis
  if (s/el$/éis/) {return $_}
  if (s/ol$/óis/) {return $_}
  # -al, -oi, -ul -> changes to -ais, -ois, -uis
  if (s/al$/ais/) {return $_}
  if (s/oi$/ois/) {return $_}
  if (s/ul$/uis/) {return $_}
  # -m -> changes to -ns
  if (s/m$/ns/) {return $_}
  # -ão -> changes to -ãos, -ães, -ões NOT YET IMPLEMENTED
  # ...

  # general rules
  if (s/(?<=[rnsz])$/es/) {return $_} # adds 'es'
  if (s/([aeiou]|[aeiou][iu]|[iu][aeiou])$/$&s/) {return $_} # adds 's'
}

1;
__END__

=head1 DESCRIPTION

Converts Portuguese words from singular to plural. Words ending in -il still
aren't being treated. There may be some special cases that will fail (actually,
there *WILL* be some).

=head1 AUTHOR

Jose Alves de Castro, E<lt>jac@natura.di.uminho.pt<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2004 by Jose Alves de Castro

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut
