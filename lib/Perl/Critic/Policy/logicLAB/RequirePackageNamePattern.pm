package Perl::Critic::Policy::logicLAB::RequirePackageNamePattern;

# $Id: ProhibitShellDispatch.pm 8114 2013-07-25 12:57:04Z jonasbn $

use strict;
use warnings;
use 5.006;

use base 'Perl::Critic::Policy';
use Perl::Critic::Utils qw{ $SEVERITY_MEDIUM :booleans};
use Carp qw(carp);

our $VERSION = '0.01';

Readonly::Scalar my $EXPL => q{Use specified requirement for package naming};
Readonly::Scalar my $warning =>
    q{Package naming is not complying with required standard};

use constant supported_parameters => qw(names debug exempt_programs);
use constant default_severity     => $SEVERITY_MEDIUM;
use constant default_themes       => qw(logiclab);

sub prepare_to_scan_document {
    my ( $self, $document ) = @_;
    if ( $self->{exempt_programs} && $document->is_program() ) {
        return $FALSE;
    }

    return $document->is_module();
}

sub applies_to {
    return (
        qw(
            PPI::Statement::Package
            )
    );
}

sub violates {
    my ( $self, $elem ) = @_;

    if ( not $self->{_names} ) {
        return;
    }

    my @children = $elem->children;

    if ( $children[0]->content eq 'package' ) {
        my $package = $children[1];
        my $regex   = $self->{_names};

        if ( $package !~ m/$regex/xsm ) {
            return $self->violation( $warning, $EXPL, $elem );
        }
    } else {
        carp 'Unable to locate package keyword';
    }

    return;
}

sub initialize_if_enabled {
    my ( $self, $config ) = @_;

    #Names:
    #fetching configured names
    my $names = $config->get('names');

    #parsing configured names, see also _parse_names
    if ($names) {
        $self->{_names} = $self->_parse_names($names) || q{};
    }

    #debug
    $self->{debug} = $config->get('debug') || $FALSE;

    #exempt_programs
    $self->{exempt_programs} = $config->get('exempt_programs') || $TRUE;

    return $TRUE;
}

sub _parse_names {
    my ( $self, $config_string ) = @_;

    my @names = split m{ \s* [||]+ \s* }xsm, $config_string;

    return \@names;
}

1;

__END__

=head1 NAME

Perl::Critic::Policy::logicLAB::RequirePackageNamePattern - simple policy for enforcing a package naming policy

=head1 AFFILIATION 

This policy is a policy in the Perl::Critic::logicLAB distribution. The policy
is themed: logiclab.

=cut

