package AppManager::Models::AppServerManagerModelTomcat;

use strict;
use warnings FATAL => 'all';

use Moose;
use MooseX::StrictConstructor;
use namespace::autoclean;
use Params::Validate qw(:all);

with 'AppManager::Models::AppServerManagerModelAbstract';

has 'hostname' => ( required => 1,
        is => 'ro',
        isa => 'Str',
        writer => undef,
        reader => 'get_hostname'
    );

has 'port' => ( required => 1,
        is => 'ro',
        isa => 'Int',
        writer => undef,
        reader => 'get_port'
    );

has 'user' => ( required => 1,
        is => 'ro',
        isa => 'Str',
        writer => undef,
        reader => 'get_user'
    );

has 'password' => ( required => 1,
        is => 'ro',
        isa => 'Str',
        writer => undef,
        reader => 'get_password'
    );

has 'base_url' => ( init_arg => undef,
        is => 'ro',
        isa => 'Str',
        writer => undef,
        reader => 'get_base_url',
        lazy    => 1,
        builder => '_build_base_url',
    );

has 'manager_text_url' => ( init_arg => undef,
        is => 'ro',
        isa => 'Str',
        writer => undef,
        reader => 'get_manager_text_url',
        lazy    => 1,
        builder => '_build_manager_text_url',
    );

sub _build_base_url {
    my $this = shift;

    my $hostname = $this->get_hostname();
    my $port = $this->get_port();
    my $user = $this->get_user();
    my $password = $this->get_password();

    my $manager_text_url = "http://$user:$password\@$hostname:$port/";
    return $manager_text_url;
}

sub _build_manager_text_url {
    my $this = shift;
    my $base_url = $this->get_base_url();

    my $manager_text_url = $base_url . "manager/text/";
    return $manager_text_url;
}

sub get_url_for_deploy_app {
    my $this = shift;
    my %args = validate(
        @_, {
            application => 1,
            war_filepath => 1,
        }
    );
    my $application = $args{application};
    my $war_filepath = $args{war_filepath};
    my $manager_text_url = $this->get_manager_text_url();
    my $action = "deploy";

    return $manager_text_url . "$action?path=/$application&war=file:$war_filepath";
}

sub get_url_for_undeploy_app {
    my $this = shift;
    my %args = validate(
        @_, {
            application => 1
        }
    );
    my $application = $args{application};
    my $manager_text_url = $this->get_manager_text_url();
    my $action = "undeploy";

    return $manager_text_url . "$action?path=/$application";
}

sub get_url_for_start_app {
    my $this = shift;
    my %args = validate(
        @_, {
            application => 1
        }
    );
    my $application = $args{application};
    my $manager_text_url = $this->get_manager_text_url();
    my $action = "start";

    return $manager_text_url . "$action?path=/$application";
}

sub get_url_for_stop_app {
    my $this = shift;
    my %args = validate(
        @_, {
            application => 1
        }
    );
    my $application = $args{application};
    my $manager_text_url = $this->get_manager_text_url();
    my $action = "stop";

    return $manager_text_url . "$action?path=/$application";
}

sub get_url_for_check_app {
    my $this = shift;
    my %args = validate(
        @_, {
            application => 1
        }
    );
    my $application = $args{application};
    my $base_url = $this->get_base_url();

    return $base_url . "$application";
}

__PACKAGE__->meta->make_immutable;

1;