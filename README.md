[![CPAN version](https://badge.fury.io/pl/Perl-Critic-Policy-logicLAB-RequirePackageNamePattern.svg)](http://badge.fury.io/pl/Perl-Critic-Policy-logicLAB-RequirePackageNamePattern)
[![Build Status](https://travis-ci.org/jonasbn/pcplrpnp.svg?branch=master)](https://travis-ci.org/jonasbn/pcplrpnp)
[![Coverage Status](https://coveralls.io/repos/jonasbn/pcplrpnp/badge.png)](https://coveralls.io/r/jonasbn/pcplrpnp)

# NAME

Perl::Critic::Policy::Module::RequirePackageNamePattern - simple policy for enforcing a package naming policy

# AFFILIATION

This policy is a policy in the Perl::Critic::logicLAB distribution. The policy
is themed: logiclab.

# VERSION

This documentation describes version 0.05.

# DESCRIPTION

The policy can be used to enforced naming conventions for packages.

# SYNOPSIS

Policy configuration:

    [Module::RequirePackageNamePattern]
    names = Acme

Your package:

    package This::Is::A::Test;

        # code goes here

    1;

Invocation of policy:

    $ perlcritic --single-policy Module::RequirePackageNamePattern lib

Explanation:

    Use specified requirement for package naming for This::Is::A::Test

Description:

    Package name: This::Is::A::Test is not complying with required standard

# CONFIGURATION AND ENVIRONMENT

This policy allow you to configure the contents of the shebang lines you
want to allow using ["names"](#names).

## names

`names`, is the configuration parameter used to specify the patterns you
want to enforce.

The different usage scenarios are documented below

### Toplevel namespace

    [Module::RequirePackageNamePattern]
    names = ^App::

### Subclass

    [Module::RequirePackageNamePattern]
    names = ::JONASBN$

### Postfix

    [Module::RequirePackageNamePattern]
    names = Utils$

### Prefix

    [Module::RequirePackageNamePattern]
    names = ^Acme

### Contains

    [Module::RequirePackageNamePattern]
    names = Tiny

### Or

    [Module::RequirePackageNamePattern]
    names = Acme || logicLAB

## debug

Optionally and for development purposes I have added a debug flag. This can be set in
your [Perl::Critic](https://metacpan.org/pod/Perl::Critic) configuration file as follows:

    [Module::RequirePackageNamePattern]
    debug = 1

This enables more explicit output on what is going on during the actual processing of
the policy.

# DEPENDENCIES AND REQUIREMENTS

- [Module::Build](https://metacpan.org/pod/Module::Build)
- [Perl::Critic](https://metacpan.org/pod/Perl::Critic)
- [Perl::Critic::Utils](https://metacpan.org/pod/Perl::Critic::Utils)
- [Perl::Critic::Policy](https://metacpan.org/pod/Perl::Critic::Policy)
- [Test::More](https://metacpan.org/pod/Test::More)
- [Test::Class](https://metacpan.org/pod/Test::Class)
- [Test::Perl::Critic](https://metacpan.org/pod/Test::Perl::Critic)
- [Data::Dumper](https://metacpan.org/pod/Data::Dumper)

# INCOMPATIBILITIES

This distribution has no known incompatibilities.

# BUGS AND LIMITATIONS

There are no known bugs or limitations

# TEST AND QUALITY

The following policies have been disabled for this distribution

- [Perl::Critic::Policy::ValuesAndExpressions::ProhibitConstantPragma](https://metacpan.org/pod/Perl::Critic::Policy::ValuesAndExpressions::ProhibitConstantPragma)

    Constants are good, - see the link below.

    - [https://logiclab.jira.com/wiki/display/OPEN/Perl-Critic-Policy-ValuesAndExpressions-ProhibitConstantPragma](https://logiclab.jira.com/wiki/display/OPEN/Perl-Critic-Policy-ValuesAndExpressions-ProhibitConstantPragma)

- [Perl::Critic::Policy::NamingConventions::Capitalization](https://metacpan.org/pod/Perl::Critic::Policy::NamingConventions::Capitalization)

See also `t/perlcriticrc`

## TEST COVERAGE

Coverage test executed the following way, the coverage report is based on the
version described in this documentation (see ["VERSION"](#version)).

    ./Build testcover

    ---------------------------- ------ ------ ------ ------ ------ ------ ------
    File                           stmt   bran   cond    sub    pod   time  total
    ---------------------------- ------ ------ ------ ------ ------ ------ ------
    ...uirePackageNamePattern.pm   89.2   68.2   36.4  100.0  100.0  100.0   82.5
    Total                          89.2   68.2   36.4  100.0  100.0  100.0   82.5
    ---------------------------- ------ ------ ------ ------ ------ ------ ------

# SEE ALSO

- [Perl::Critic](https://metacpan.org/pod/Perl::Critic)
- [perlmod manpage](http://perldoc.perl.org/perlmod.html)
- [http://logiclab.jira.com/wiki/display/PCPLRPNP/Home](http://logiclab.jira.com/wiki/display/PCPLRPNP/Home)
- [http://logiclab.jira.com/wiki/display/PCLL/Home](http://logiclab.jira.com/wiki/display/PCLL/Home)

# AUTHOR

- Jonas B. (jonasbn) `<jonasbn@cpan.org>`

# ACKNOWLEDGEMENT

- Jeffrey Ryan Thalhammer (THALJEF) and the Perl::Critic contributors for
Perl::Critic

# LICENSE AND COPYRIGHT

Copyright (c) 2013-2019 Jonas B. (jonasbn). All rights reserved.

Perl::Critic::Policy::Module::RequirePackageNamePattern is released under
the Artistic License 2.0

The distribution is licensed under the Artistic License 2.0, as specified by
the license file included in this distribution.
