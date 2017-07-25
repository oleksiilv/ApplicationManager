package AppManager::AppManagerOrchestrator;

use strict;
use warnings FATAL => 'all';

use base qw( Exporter );
use Params::Validate qw(:all);
use Switch;
use feature qw(say);

use AppManager::Constants qw( :actions );
use AppManager::Models::AppServerManagersFactory qw( get_app_server_manager_model );
use AppManager::Services::CoreServicesFactory qw(
    get_deploy_app_service
    get_undeploy_app_service
    get_start_app_service
    get_stop_app_service
    get_check_app_service
    );

sub manage_app {
    my %args = validate(
        @_, {
            action => 1,
            app_server => 1,
            hostname => 1,
            port => 1,
            user => 1,
            password => 1,
            application => 0,
            war_filepath => 0,
        }
    );

    my $action     = $args{action};
    my $app_server = $args{app_server};

    my $hostname    = $args{hostname};
    my $port        = $args{port};
    my $user        = $args{user};
    my $password    = $args{password};

    my $application = $args{application};
    my $war_filepath = $args{war_filepath};

    my $app_server_manager_model = get_app_server_manager_model( app_server => $app_server,
        hostname => $hostname,
        port => $port,
        user => $user,
        password => $password );


    my $status;
    switch ($action) {
        case "$ACTION_DEPLOY" {
            $status = get_deploy_app_service( app_server => $app_server )->deploy_app( app_server_manager_model => $app_server_manager_model,
                application => $application,
                war_filepath => $war_filepath );
        }
        case "$ACTION_UNDEPLOY" {
            $status = get_undeploy_app_service( app_server => $app_server )->undeploy_app( app_server_manager_model => $app_server_manager_model,
                application => $application );
        }
        case "$ACTION_START" {
            $status = get_start_app_service( app_server => $app_server )->start_app( app_server_manager_model => $app_server_manager_model,
                application => $application );
        }
        case "$ACTION_STOP" {
            $status = get_stop_app_service( app_server => $app_server )->stop_app( app_server_manager_model => $app_server_manager_model,
                application => $application );
        }
        case "$ACTION_CHECK" {
            $status = get_check_app_service( app_server => $app_server )->check_app( app_server_manager_model => $app_server_manager_model,
                application => $application );
        }
        else {
            die "action '$action' is not supported"
        }
    }

    if ( $status->has_error_messages() ) {
        die "action '$action' failed: " . $status->get_error_messages_str;
    }
    elsif ( $status->has_warning_messages() ) {
        say "action '$action' succeeded with warning: " . $status->get_warning_messages_str;
    }
    else {
        say "action '$action' succeeded";
    }
}

sub manage_configs {
    my $args = shift;
    my $config_filepath = $args->{config_filepath};
    my $save_to_config_filepath = $args->{save_to_config_filepath};

    die "both options config_filepath and save_to_config_filepath cannot be specified" if $config_filepath && $save_to_config_filepath;

    if ( $config_filepath ) {
        delete($args->{config_filepath});
        open my $fh, '<', $config_filepath
            or die "unable to open configuration file $config_filepath";

        my $options = Config::Properties->new();
        $options->load($fh);
        my %options_hash = $options->properties;
        foreach my $option (keys %options_hash) {
            if ($args->{$option}) {
                die "option '$option' is duplicated in config file and command line args. This behavior is not supported";
            }
            else {
                $args->{$option} = $options_hash{$option};
            }
        }
    }
    elsif ($save_to_config_filepath) {
        delete($args->{save_to_config_filepath});
        open my $fh, '>', $save_to_config_filepath
            or die "unable to open configuration file for writing";

        my $options = Config::Properties->new();
        foreach my $option ( keys %{$args} ) {
            $options->setProperty($option, $args->{$option});
        }
        $options->store($fh);
    }
}

our @EXPORT_OK = qw(
    manage_app
    manage_configs
    );

our %EXPORT_TAGS = (
    'all' => \@EXPORT_OK,
);

1;