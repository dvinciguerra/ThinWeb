#!/usr/bin/perl

use FindBin;
use lib "$FindBin::Bin/lib";

use ThinWeb;

get '/' => sub {
    my $self = shift;

    $self->stash( 
        name => 'Joe Doe', 
        foo => 'bar'
    );

    $self->stash(
        baz => $self->stash('name') . ' test'
    )
};

main->start;

__DATA__

@@ index.html.tt
hello [% stash(place) %]
