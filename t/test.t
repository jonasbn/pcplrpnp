
# $Id: test.t 7587 2011-04-16 16:00:36Z jonasbn $

use strict;
use warnings;

use Env qw($TEST_VERBOSE);
use Data::Dumper;
use Test::More qw(no_plan);

use_ok 'Perl::Critic::Policy::logicLAB::RequirePackageNamePattern';

require Perl::Critic;
my $critic = Perl::Critic->new(
    '-profile'       => '',
    '-single-policy' => 'logicLAB::RequirePackageNamePattern'
);
{
    my @p = $critic->policies;
    is( scalar @p, 1, 'single policy RequirePackageNamePattern' );

    my $policy = $p[0];

    if ($TEST_VERBOSE) {
        diag Dumper $policy;
    }
}

my $str = q{package This::Is::A::Test;
use strict;
use warnings;

1;
};

my @violations = $critic->critique( \$str );

is( scalar @violations, 1 );

foreach my $violation (@violations) {
    is( $violation->explanation,
        q{Use specified requirement for package naming} );
    is( $violation->description,
        q{Package naming is not complying with required standard} );
}

if ($TEST_VERBOSE) {
    diag Dumper \@violations;
}

