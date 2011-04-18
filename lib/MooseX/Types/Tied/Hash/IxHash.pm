package MooseX::Types::Tied::Hash::IxHash;

# ABSTRACT: The great new MooseX::Types::IxHash

use strict;
use warnings;

use MooseX::Types -declare => [ qw{ IxHash } ];
#use namespace::clean;

use Scalar::Util qw{ blessed };
use Tie::IxHash;
use MooseX::Types::Moose ':all';
use MooseX::Types::Tied  ':all';

subtype IxHash,
    as TiedHash,
    where { blessed(tied %$_) eq 'Tie::IxHash' },
    message { 'Referenced hash is not tied to an Tie::IxHash: ' . ref tied $_ },
    ;

coerce IxHash,
    from HashRef,
    via { tie my $x, 'Tie::IxHash', %{$_}; $x },
    from ArrayRef,
    via { tie my $x, 'Tie::IxHash', @{$_}; $x },
    ;

1;

__END__

=head1 SYNOPSIS

    use MooseX::Types::Tied::Hash::IxHash ':all';

=head1 DESCRIPTION

