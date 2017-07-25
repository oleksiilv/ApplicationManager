package AppManager::Services::CoreServicesFactory;

use strict;
use warnings FATAL => 'all';

use base qw( Exporter );
use Params::Validate qw(:all);
use Switch;

use AppManager::Constants qw( :app_servers );
use AppManager::Services::CoreServicesImpl::DeployAppServiceTomcat;
use AppManager::Services::CoreServicesImpl::UndeployAppServiceTomcat;
use AppManager::Services::CoreServicesImpl::StartAppServiceTomcat;
use AppManager::Services::CoreServicesImpl::StopAppServiceTomcat;
use AppManager::Services::CoreServicesImpl::CheckAppServiceTomcat;

sub get_deploy_app_service {
    my %args = validate(
        @_,
        {
            app_server => 1
        }
    );

    my $app_server = $args{app_server};

    switch ($app_server) {
        case "$APP_SERVER_TOMCAT" {
            return
              AppManager::Services::CoreServicesImpl::DeployAppServiceTomcat
              ->new();
        }
        else {
            die "deploy for app_server '$app_server' is not supported";
        }
    }
}

sub get_undeploy_app_service {
    my %args = validate(
        @_,
        {
            app_server => 1
        }
    );

    my $app_server = $args{app_server};

    switch ($app_server) {
        case "$APP_SERVER_TOMCAT" {
            return
              AppManager::Services::CoreServicesImpl::UndeployAppServiceTomcat
              ->new();
        }
        else {
            die "undeploy for app_server '$app_server' is not supported";
        }
    }
}

sub get_start_app_service {
    my %args = validate(
        @_,
        {
            app_server => 1
        }
    );

    my $app_server = $args{app_server};

    switch ($app_server) {
        case "$APP_SERVER_TOMCAT" {
            return
              AppManager::Services::CoreServicesImpl::StartAppServiceTomcat
              ->new();
        }
        else {
            die "start for app_server '$app_server' is not supported";
        }
    }
}

sub get_stop_app_service {
    my %args = validate(
        @_,
        {
            app_server => 1
        }
    );

    my $app_server = $args{app_server};

    switch ($app_server) {
        case "$APP_SERVER_TOMCAT" {
            return AppManager::Services::CoreServicesImpl::StopAppServiceTomcat
              ->new();
        }
        else {
            die "stop for app_server '$app_server' is not supported";
        }
    }
}

sub get_check_app_service {
    my %args = validate(
        @_,
        {
            app_server => 1
        }
    );

    my $app_server = $args{app_server};

    switch ($app_server) {
        case "$APP_SERVER_TOMCAT" {
            return
              AppManager::Services::CoreServicesImpl::CheckAppServiceTomcat
              ->new();
        }
        else {
            die "check for app_server '$app_server' is not supported";
        }
    }
}

our @EXPORT_OK = qw(
  get_deploy_app_service
  get_undeploy_app_service
  get_start_app_service
  get_stop_app_service
  get_check_app_service
);

our %EXPORT_TAGS = ( 'all' => \@EXPORT_OK, );

1;
