#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;
use Test::Exception;

{
    package TestClass;

    use Moose;
    use MooseX::Types::Tied::Hash::IxHash ':all';

    has ixhash => (
        traits => ['Hash'],
        is => 'rw', isa => IxHash, coerce => 1,
        handles => {
            h_keys   => 'keys',
            h_values => 'values',
            h_del    => 'delete',
            h_set    => 'set',
        },
    );
}

my $foo = TestClass->new();

# note arrayref
$foo->ixhash([ one => 'first', two => 'second', three => 'third' ]);

is_deeply(
    [ $foo->h_keys        ],
    [ qw{ one two three } ],
    'keys are sorted correctly',
);

is_deeply(
    [ $foo->h_values           ],
    [ qw{ first second third } ],
    'values returned as expected',
);

TODO: {
    local $TODO = 'Moose Hash native trait known to harmful to tied structs';

    $foo->h_del('two');
    $foo->h_set(four => 'fourth');

    is_deeply(
        [ $foo->h_keys         ],
        [ qw{ one three four } ],
        'keys are sorted correctly',
    );

    is_deeply(
        [ $foo->h_values           ],
        [ qw{ first third fourth } ],
        'values returned as expected',
    );
}

done_testing;
