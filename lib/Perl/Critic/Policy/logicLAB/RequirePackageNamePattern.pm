package Perl::Critic::Policy::logicLAB::RequirePackageNamePattern;

# $Id: ProhibitShellDispatch.pm 8114 2013-07-25 12:57:04Z jonasbn $

use strict;
use warnings;
use 5.006;

use base 'Perl::Critic::Policy';
use Perl::Critic::Utils qw{ $SEVERITY_MEDIUM :booleans};
use Carp qw(carp);
use Data::Dumper;

our $VERSION = '0.01';

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
        #TODO we might have to look for words here instead of using an array index
        #TODO and we should add exception in the case an actual package is not located
        my $package = $children[2]->content;

        if ($self->{debug}) {
            print STDERR "located package: $package\n";
        }

        my $no_of_patterns = scalar @{$self->{_names}};
        my $no_of_violations = 0;

        foreach my $name (@{$self->{_names}}) {
            my $regex = qr/$name/;

            if ($self->{debug}) {
                print STDERR "Regex: $regex\n";
            }

            if ( $package !~ m/$regex/xsm ) {
                if ($no_of_patterns > 1) {
                    $no_of_violations++;

                    if ($no_of_patterns == $no_of_violations) {
                        return $self->violation( 
                            "Package name: $package is not complying with required standard", 
                            "Use specified requirement for package naming for $package", 
                            $elem
                        );
                    }

                } else {

                    return $self->violation( 
                        "Package name: $package is not complying with required standard", 
                        "Use specified requirement for package naming for $package", 
                        $elem
                    );
                }
            }
        }

    } else {
        carp 'Unable to locate package keyword';
    }

    return;
}

sub initialize_if_enabled {
    my ( $self, $config ) = @_;

    #debug - order is significant, since we might need debugging
    $self->{debug} = $config->get('debug') || $FALSE;

    #Names:
    #fetching configured names
    my $names = $config->get('names');

    if ($self->{debug}) {
        warn "Requirements for package names are: $names\n";
    }

    #parsing configured names, see also _parse_names
    if ($names) {
        $self->{_names} = $self->_parse_names($names) || q{};
    }

    #exempt_programs
    $self->{exempt_programs} = $config->get('exempt_programs') || $TRUE;

    return $TRUE;
}

sub _parse_names {
    my ( $self, $config_string ) = @_;

    my @names = split /\s*\|\|\s*/, $config_string;

    if ($self->{debug}) {
        print STDERR "our split line:\n";
        print STDERR Dumper \@names;
    }

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

