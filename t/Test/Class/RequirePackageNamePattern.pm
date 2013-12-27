package Test::Class::RequirePackageNamePattern;

# $Id$

use strict;
use warnings;

use Env qw($TEST_VERBOSE);
use Data::Dumper;
use Test::More qw(no_plan);
use base qw(Test::Class);
use lib qw(lib);

sub startup : Test(startup) {
    my $self = shift;

    require Perl::Critic;
    use Perl::Critic::Policy::logicLAB::RequirePackageNamePattern;

    $self->{perl_string} = join '', <DATA>;
}

sub no_requirement : Test(2) {
    my $self = shift;

    my $critic = Perl::Critic->new(
        '-profile'       => '',
        '-single-policy' => 'logicLAB::RequirePackageNamePattern'
    );

    my @p = $critic->policies;
    is( scalar @p, 1, 'single policy RequirePackageNamePattern' );

    my $policy = $p[0];

    if ($TEST_VERBOSE) {
        diag Dumper $policy;
    }

    my @violations = $critic->critique( \$self->{perl_string} );

    is( scalar @violations, 0 );

    foreach my $violation (@violations) {
        is( $violation->explanation,
            q{Use specified requirement for package naming for This::Is::A::Test} );
        is( $violation->description,
            q{Package name: This::Is::A::Test is not complying with required standard} );
    }

    if ($TEST_VERBOSE) {
        diag Dumper \@violations;
    }
}

sub requiring_presence : Test(4) {
    my $self = shift;

    my $critic = Perl::Critic->new(
        '-profile'       => 't/presence.conf',
        '-single-policy' => 'logicLAB::RequirePackageNamePattern'
    );

    my @p = $critic->policies;
    is( scalar @p, 1, 'single policy RequirePackageNamePattern' );

    my $policy = $p[0];

    if ($TEST_VERBOSE) {
        diag Dumper $policy;
    }

    my @violations = $critic->critique( \$self->{perl_string} );

    is( scalar @violations, 1 );

    foreach my $violation (@violations) {
        is( $violation->explanation,
            q{Use specified requirement for package naming for This::Is::A::Test} );
        is( $violation->description,
            q{Package name: This::Is::A::Test is not complying with required standard} );
    }

    if ($TEST_VERBOSE) {
        diag Dumper \@violations;
    }
}

sub requiring_prefix : Test(4) {
	my $self = shift;

    my $critic = Perl::Critic->new(
        '-profile'       => 't/prefix.conf',
        '-single-policy' => 'logicLAB::RequirePackageNamePattern'
    );

    my @p = $critic->policies;
    is( scalar @p, 1, 'single policy RequirePackageNamePattern' );

    my $policy = $p[0];

    if ($TEST_VERBOSE) {
        diag Dumper $policy;
    }

    my @violations = $critic->critique( \$self->{perl_string} );

    is( scalar @violations, 1 );

    foreach my $violation (@violations) {
        is( $violation->explanation,
            q{Use specified requirement for package naming for This::Is::A::Test} );
        is( $violation->description,
            q{Package name: This::Is::A::Test is not complying with required standard} );
    }

    if ($TEST_VERBOSE) {
        diag Dumper \@violations;
 	}
 }

sub requiring_postfix : Test(4) {
    my $self = shift;

    my $critic = Perl::Critic->new(
        '-profile'       => 't/postfix.conf',
        '-single-policy' => 'logicLAB::RequirePackageNamePattern'
    );

    my @p = $critic->policies;
    is( scalar @p, 1, 'single policy RequirePackageNamePattern' );

    my $policy = $p[0];

    if ($TEST_VERBOSE) {
        diag Dumper $policy;
    }

    my @violations = $critic->critique( \$self->{perl_string} );

    is( scalar @violations, 1 );

    foreach my $violation (@violations) {
        is( $violation->explanation,
            q{Use specified requirement for package naming for This::Is::A::Test} );
        is( $violation->description,
            q{Package name: This::Is::A::Test is not complying with required standard} );
    }

    if ($TEST_VERBOSE) {
        diag Dumper \@violations;
    }
}

sub requiring_toplevel_namespace : Test(4) {
    my $self = shift;

    my $critic = Perl::Critic->new(
        '-profile'       => 't/toplevel.conf',
        '-single-policy' => 'logicLAB::RequirePackageNamePattern'
    );

    my @p = $critic->policies;
    is( scalar @p, 1, 'single policy RequirePackageNamePattern' );

    my $policy = $p[0];

    if ($TEST_VERBOSE) {
        diag Dumper $policy;
    }

    my @violations = $critic->critique( \$self->{perl_string} );

    is( scalar @violations, 1 );

    foreach my $violation (@violations) {
        is( $violation->explanation,
            q{Use specified requirement for package naming for This::Is::A::Test} );
        is( $violation->description,
            q{Package name: This::Is::A::Test is not complying with required standard} );
    }

    if ($TEST_VERBOSE) {
        diag Dumper \@violations;
    }
}

sub requiring_subclass : Test(4) {
    my $self = shift;

    my $critic = Perl::Critic->new(
        '-profile'       => 't/subclass.conf',
        '-single-policy' => 'logicLAB::RequirePackageNamePattern'
    );

    my @p = $critic->policies;
    is( scalar @p, 1, 'single policy RequirePackageNamePattern' );

    my $policy = $p[0];

    if ($TEST_VERBOSE) {
        diag Dumper $policy;
    }

    my @violations = $critic->critique( \$self->{perl_string} );

    is( scalar @violations, 1 );

    foreach my $violation (@violations) {
        is( $violation->explanation,
            q{Use specified requirement for package naming for This::Is::A::Test} );
        is( $violation->description,
            q{Package name: This::Is::A::Test is not complying with required standard} );
    }

    if ($TEST_VERBOSE) {
        diag Dumper \@violations;
    }
}

sub requiring_multiple_or : Test(4) {
    my $self = shift;

    my $critic = Perl::Critic->new(
        '-profile'       => 't/or.conf',
        '-single-policy' => 'logicLAB::RequirePackageNamePattern'
    );

    my @p = $critic->policies;
    is( scalar @p, 1, 'single policy RequirePackageNamePattern' );

    my $policy = $p[0];

    if ($TEST_VERBOSE) {
        diag Dumper $policy;
    }

    my @violations = $critic->critique( \$self->{perl_string} );

    is( scalar @violations, 1 );

    foreach my $violation (@violations) {
        is( $violation->explanation,
            q{Use specified requirement for package naming for This::Is::A::Test} );
        is( $violation->description,
            q{Package name: This::Is::A::Test is not complying with required standard} );
    }

    if ($TEST_VERBOSE) {
        diag Dumper \@violations;
    }
}

sub requiring_multiple_and : Test(4) {
    my $self = shift;

    my $critic = Perl::Critic->new(
        '-profile'       => 't/and.conf',
        '-single-policy' => 'logicLAB::RequirePackageNamePattern'
    );

    my @p = $critic->policies;
    is( scalar @p, 1, 'single policy RequirePackageNamePattern' );

    my $policy = $p[0];

    if ($TEST_VERBOSE) {
        diag Dumper $policy;
    }

    my @violations = $critic->critique( \$self->{perl_string} );

    is( scalar @violations, 1 );

    foreach my $violation (@violations) {
        is( $violation->explanation,
            q{Use specified requirement for package naming for This::Is::A::Test} );
        is( $violation->description,
            q{Package name: This::Is::A::Test is not complying with required standard} );
    }

    if ($TEST_VERBOSE) {
        diag Dumper \@violations;
    }
}


1;

__DATA__
package This::Is::A::Test;

use strict;
use warnings;

1;
