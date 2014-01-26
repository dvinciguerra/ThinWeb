package ThinWeb::Routes;

sub new {
    my $class = shift;
    return bless {
        _r => {}
    }, $class;
}

sub routes {
    my $self = shift;
    return $self->{_r};
}

sub add {
    my ($self, %args) = @_;

    $self->{_r}->{$args{type}}->{$args{uri}}
        = \%args;
}

sub get {
    my ($self, $uri) = @_;
    return $self->{_r}->{'GET'}->{$uri};
}

sub post {
    my ($self, $uri) = @_;
    return $self->{_r}->{'POST'}->{$uri};
}

1;
