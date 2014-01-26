use strict;
use warnings;

use Test::More;

use FindBin;
use lib "$FindBin::Bin/../lib";

# use test
use_ok 'ThinWeb';

# method tests
can_ok 'ThinWeb', $_ 
    for qw/new cgi route stash _start/;

my $t = ThinWeb->new;

# routes test
ok $t->route->isa('ThinWeb::Routes'), 'route test';
can_ok 'ThinWeb::Routes', $_
    for qw/new add get post/;

$t->route->add( type => 'GET', uri => '/', action => sub{} );
is ref $t->route->get('/'), 'HASH';
is ref $t->route->get('/')->{action}, 'CODE';

# stash test
ok $t->{_stash}->isa('ThinWeb::Stash'), 'stash test';
can_ok 'ThinWeb::Stash', $_
    for qw/new param/;

$t->stash( name => 'Joe Doe' );
is $t->stash('name'), 'Joe Doe';


done_testing;
