package MooseX::Types::Tied;

# ABSTRACT: Basic tied Moose types library

use strict;
use warnings;

use MooseX::Types -declare => [ qw{ Tied TiedHash TiedArray TiedHandle } ];
use MooseX::Types::Moose ':all';

#use namespace::clean;

subtype Tied,
    as Ref,
    where { defined tied $$_ },
    message { 'Referenced scalar is not tied!' },
    ;

subtype TiedArray,
    as ArrayRef,
    where { defined tied @$_ },
    message { 'Array is not tied!' },
    ;

subtype TiedHash,
    as HashRef,
    where { defined tied %$_ },
    message { 'Hash is not tied!' },
    ;

subtype TiedHandle,
    as FileHandle,
    where { defined tied $$_ },
    message { 'Handle is not tied!' },
    ;

1;

__END__

=for stopwords TiedArray TiedHash TiedHandle

=head1 SYNOPSIS

    use Moose;
    use MooseX::Types::Tied ':all';

    has tied_array => (is => 'ro', isa => TiedArray);

    # etc...

=head1 DESCRIPTION

This is a collection of basic L<Moose> types for tied references.  The package
behaves as you'd expect a L<MooseX::Types> library to act: either specify the
types you want imported explicitly or use the ':all' catchall.

=head1 TYPES

=head2 Tied

Base type: Ref (to Scalar)

=head2 TiedArray

Base type: ArrayRef

=head2 TiedHash

Base type: HashRef

=head2 TiedHandle

Base type: FileHandle

=cut
