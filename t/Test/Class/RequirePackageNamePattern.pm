package Test::Class::RequirePackageNamePattern;

# $Id$

use strict;
use warnings;

use Env qw($DEBUG $TEST_VERBOSE);
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

    if ($DEBUG) {
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

    if ($DEBUG) {
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

    if ($DEBUG) {
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

    if ($DEBUG) {
        diag Dumper \@violations;
    }
}

sub requiring_presence_violation : Test(4) {
    my $self = shift;

    my $critic = Perl::Critic->new(
        '-profile'       => 't/presence.conf',
        '-single-policy' => 'logicLAB::RequirePackageNamePattern'
    );

    my @p = $critic->policies;
    is( scalar @p, 1, 'single policy RequirePackageNamePattern' );

    my $policy = $p[0];

    if ($DEBUG) {
        diag Dumper $policy;
    }

    my $perl_string = 'package Acme::No::Presence';
    my @violations = $critic->critique( \$perl_string );

    is( scalar @violations, 1 );

    foreach my $violation (@violations) {
        is( $violation->explanation,
            q{Use specified requirement for package naming for Acme::No::Presence} );
        is( $violation->description,
            q{Package name: Acme::No::Presence is not complying with required standard} );
    }

    if ($DEBUG) {
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

    if ($DEBUG) {
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

    if ($DEBUG) {
        diag Dumper \@violations;
 	}
}

sub requiring_prefix_violation : Test(4) {
    my $self = shift;

    my $critic = Perl::Critic->new(
        '-profile'       => 't/prefix.conf',
        '-single-policy' => 'logicLAB::RequirePackageNamePattern'
    );

    my @p = $critic->policies;
    is( scalar @p, 1, 'single policy RequirePackageNamePattern' );

    my $policy = $p[0];

    if ($DEBUG) {
        diag Dumper $policy;
    }

    my $perl_string = 'package Acme::Bad::Prefix';
    my @violations = $critic->critique( \$perl_string );

    is( scalar @violations, 1 );

    foreach my $violation (@violations) {
        is( $violation->explanation,
            q{Use specified requirement for package naming for Acme::Bad::Prefix} );
        is( $violation->description,
            q{Package name: Acme::Bad::Prefix is not complying with required standard} );
    }

    if ($DEBUG) {
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

    if ($DEBUG) {
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

    if ($DEBUG) {
        diag Dumper \@violations;
    }
}

sub requiring_postfix_violation : Test(4) {
    my $self = shift;

    my $critic = Perl::Critic->new(
        '-profile'       => 't/postfix.conf',
        '-single-policy' => 'logicLAB::RequirePackageNamePattern'
    );

    my @p = $critic->policies;
    is( scalar @p, 1, 'single policy RequirePackageNamePattern' );

    my $policy = $p[0];

    if ($DEBUG) {
        diag Dumper $policy;
    }

    my $perl_string = 'package Acme::This::Is::The::End';
    my @violations = $critic->critique( \$perl_string );

    is( scalar @violations, 1 );

    foreach my $violation (@violations) {
        is( $violation->explanation,
            q{Use specified requirement for package naming for Acme::This::Is::The::End} );
        is( $violation->description,
            q{Package name: Acme::This::Is::The::End is not complying with required standard} );
    }

    if ($DEBUG) {
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

    if ($DEBUG) {
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

    if ($DEBUG) {
        diag Dumper \@violations;
    }
}

sub requiring_toplevel_namespace_violation : Test(4) {
    my $self = shift;

    my $critic = Perl::Critic->new(
        '-profile'       => 't/toplevel.conf',
        '-single-policy' => 'logicLAB::RequirePackageNamePattern'
    );

    my @p = $critic->policies;
    is( scalar @p, 1, 'single policy RequirePackageNamePattern' );

    my $policy = $p[0];

    if ($DEBUG) {
        diag Dumper $policy;
    }

    my $perl_string = 'package Acme::Do::Not::Conform';
    my @violations = $critic->critique( \$perl_string );

    is( scalar @violations, 1 );

    foreach my $violation (@violations) {
        is( $violation->explanation,
            q{Use specified requirement for package naming for Acme::Do::Not::Conform} );
        is( $violation->description,
            q{Package name: Acme::Do::Not::Conform is not complying with required standard} );
    }

    if ($DEBUG) {
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

    if ($DEBUG) {
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

    if ($DEBUG) {
        diag Dumper \@violations;
    }
}

sub requiring_subclass_violation : Test(4) {
    my $self = shift;

    my $critic = Perl::Critic->new(
        '-profile'       => 't/subclass.conf',
        '-single-policy' => 'logicLAB::RequirePackageNamePattern'
    );

    my @p = $critic->policies;
    is( scalar @p, 1, 'single policy RequirePackageNamePattern' );

    my $policy = $p[0];

    if ($DEBUG) {
        diag Dumper $policy;
    }

    my $perl_string = 'package Acme::I::Am::No::Subclass';
    my @violations = $critic->critique( \$perl_string );

    is( scalar @violations, 1 );

    foreach my $violation (@violations) {
        is( $violation->explanation,
            q{Use specified requirement for package naming for Acme::I::Am::No::Subclass} );
        is( $violation->description,
            q{Package name: Acme::I::Am::No::Subclass is not complying with required standard} );

        if ($TEST_VERBOSE) {
            diag 'explanation: ', $violation->explanation;
            diag 'description: ', $violation->description,
        }
    }

    if ($DEBUG) {
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

    if ($DEBUG) {
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

    if ($DEBUG) {
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

    if ($DEBUG) {
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

    if ($DEBUG) {
        diag Dumper \@violations;
    }
}


1;

__DATA__
package This::Is::A::Test;

use strict;
use warnings;

1;
