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
is(sing2plural('líquene'),'líquenes');
is(sing2plural('país'),'países');
is(sing2plural('raíz'),'raízes');

is(sing2plural('mão'),'mãos');
is(sing2plural('cão'),'cães');
is(sing2plural('leão'),'leões');

is(sing2plural('homem'),'homens');
is(sing2plural('tom'),'tons');

is(sing2plural('casal'),'casais');
is(sing2plural('boi'),'bois');
is(sing2plural('paul'),'pauis');

is(sing2plural('anel'),'anéis');
is(sing2plural('farol'),'faróis');

is(sing2plural('funil'),'funis');
is(sing2plural('barril'),'barris');

is(sing2plural('réptil'),'répteis');
is(sing2plural('fóssil'),'fósseis');

is(sing2plural('gas'),'gases');
is(sing2plural('francês'),'franceses');

is(sing2plural('lápis'),'lápis');
is(sing2plural('pires'),'pires');
is(sing2plural('pírex'),'pírex');
is(sing2plural('inox'),'inox');
