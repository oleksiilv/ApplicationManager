package AppManager::Models::Status;

use strict;
use warnings FATAL => 'all';

use Moose;
use MooseX::StrictConstructor;
use namespace::autoclean;

has 'info_messages' => (
        traits  => ['Array'],
        is      => 'ro',
        isa     => 'ArrayRef[Str]',
        default => sub { [] },
        handles => {
            get_info_messages    => 'elements',
            has_info_messages    => 'count',
            add_info_message     => 'push',
            join_info_messages   => 'join',
        },
    );

has 'warning_messages' => (
        traits  => ['Array'],
        is      => 'ro',
        isa     => 'ArrayRef[Str]',
        default => sub { [] },
        handles => {
            get_warning_messages    => 'elements',
            has_warning_messages    => 'count',
            add_warning_message     => 'push',
            join_warning_messages   => 'join',
        },
    );

has 'error_messages' => (
        traits  => ['Array'],
        is      => 'ro',
        isa     => 'ArrayRef[Str]',
        default => sub { [] },
        handles => {
            get_error_messages    => 'elements',
            has_error_messages    => 'count',
            add_error_message     => 'push',
            join_error_messages   => 'join',
        },
    );

sub get_info_messages_str {
    my $this = shift;
    return $this->join_info_messages(", ");
}

sub get_warning_messages_str {
    my $this = shift;
    return $this->join_warning_messages(", ");
}

sub get_error_messages_str {
    my $this = shift;
    return $this->join_error_messages(", ");
}

__PACKAGE__->meta->make_immutable;

1;