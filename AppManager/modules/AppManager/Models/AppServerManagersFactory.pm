package AppManager::Models::AppServerManagersFactory;

use strict;
use warnings FATAL => 'all';

use base qw( Exporter );
use Params::Validate qw(:all);
use Switch;

use AppManager::Constants qw( :app_servers );
use AppManager::Models::AppServerManagerModelTomcat;

sub get_app_server_manager_model {
    my %args = validate(
        @_,
        {
            app_server => 1,
            hostname   => 1,
            port       => 1,
            user       => 1,
            password   => 1
        }
    );

    my $app_server = $args{app_server};

    my $hostname = $args{hostname};
    my $port     = $args{port};
    my $user     = $args{user};
    my $password = $args{password};

    switch ($app_server) {
        case "$APP_SERVER_TOMCAT" {
            return AppManager::Models::AppServerManagerModelTomcat->new(
                hostname => $hostname,
                port     => $port,
                user     => $user,
                password => $password
            );
        }
        else {
            die "app_server '$app_server' is not supported";
        }
    }

}

our @EXPORT_OK = qw(
  get_app_server_manager_model
);

our %EXPORT_TAGS = ( 'all' => \@EXPORT_OK, );

1;
