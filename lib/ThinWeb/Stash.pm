package ThinWeb::Stash;

sub new {
    my $class = shift;
    return bless { _param => {} }, $class;
}

sub param {
    my $self = shift; 
    my %args = @_ if int(@_) % 2 == 0;

    $self->{_param}->{$_} = $args{$_} 
        for keys %args;

    return wantarray? 
        keys %{$self->{_param}} : 
        ($_[0]? $self->{_param}->{$_[0]}: undef);
}

1;
