# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl 1.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 28;
BEGIN { use_ok('Lingua::PT::Inflect') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

is(sing2plural(''),'');

is(sing2plural('mesa'),'mesas');
is(sing2plural('pai'),'pais');

is(sing2plural('flor'),'flores');
is(sing2plural('l�quene'),'l�quenes');
is(sing2plural('pa�s'),'pa�ses');
is(sing2plural('ra�z'),'ra�zes');

is(sing2plural('m�o'),'m�os');
is(sing2plural('c�o'),'c�es');
is(sing2plural('le�o'),'le�es');

is(sing2plural('homem'),'homens');
is(sing2plural('tom'),'tons');

is(sing2plural('casal'),'casais');
is(sing2plural('boi'),'bois');
is(sing2plural('paul'),'pauis');

is(sing2plural('anel'),'an�is');
is(sing2plural('farol'),'far�is');

is(sing2plural('funil'),'funis');
is(sing2plural('barril'),'barris');

is(sing2plural('r�ptil'),'r�pteis');
is(sing2plural('f�ssil'),'f�sseis');

is(sing2plural('gas'),'gases');
is(sing2plural('franc�s'),'franceses');

is(sing2plural('l�pis'),'l�pis');
is(sing2plural('pires'),'pires');
is(sing2plural('p�rex'),'p�rex');
is(sing2plural('inox'),'inox');
