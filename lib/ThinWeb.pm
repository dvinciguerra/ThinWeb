package ThinWeb;
use strict;
use warnings;
our $VERSION = '0.001';

use CGI;
use ThinWeb::Stash;
use ThinWeb::Routes;

#DEBUG
use Data::Dumper;
use Data::Printer;

our $_app;

# exporting subs
sub import {
    my $class  = shift;
    my $caller = caller;

    $_app = ThinWeb->new;

    no strict 'refs';
    *{"${caller}::get"} = sub { _get( $_app, @_ ) };
    *{"${caller}::start"} = sub { _start( $_app, @_ ) };
}

sub _get {
    my $self = shift;
    $self->route->add(
        type        => 'GET',
        uri         => $_[0] || undef,
        action      => $_[1] || undef,
    );
}

sub _post {
    my $self = shift;
    $self->route->add(
        type        => 'POST',
        uri         => $_[0] || undef,
        action      => $_[1] || undef,
    );
}

sub _any {
    # TODO any http method type
}


# object oriented
sub new {
    my $class = shift;
    return bless {
        _cgi     => CGI->new,
        _session => {}, #ThinWeb::Session->new,
        _stash   => ThinWeb::Stash->new,
        _routes  => ThinWeb::Routes->new,
    }, $class;
}

# accessors
sub cgi {
    return (shift)->{_cgi};
}

sub route {
    return (shift)->{_routes};
}

sub session {
    return (shift)->{_session}->param(@_);
}

sub stash {
    my $self = shift;
    return $self->{_stash}->param(@_);
}

sub _start {
    my $self = shift;

    # get http request method
    my $http_method = $self->cgi->request_method || 'GET';
    
    # execute action (or default)
    my $r = $self->route;
    $r->routes->get('/')->{action}->($self)
        if $http_method eq 'GET';

    $r->routes->post('/')->{action}->($self)
        if $http_method eq 'POST';

    print 'teste start';
    #print Dumper \%args;
    p $self;
    p $self->{_stash};
    p $self->{_routes};
}

1;
