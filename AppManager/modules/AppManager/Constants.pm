package AppManager::Constants;

use strict;
use warnings FATAL => 'all';

use base qw( Exporter );
use Readonly;

Readonly::Scalar our $APP_SERVER_TOMCAT => "Tomcat";
Readonly::Scalar our $APP_SERVER_WEBLOGIC => "Weblogic";
Readonly::Scalar our $APP_SERVER_GLASSFISH => "Glassfish";
Readonly::Scalar our $APP_SERVER_IIS => "IIS";

our @APP_SERVERS = qw(
    $APP_SERVER_TOMCAT
        $APP_SERVER_WEBLOGIC
        $APP_SERVER_GLASSFISH
        $APP_SERVER_IIS
    );

Readonly::Scalar our $ACTION_DEPLOY => "deploy";
Readonly::Scalar our $ACTION_UNDEPLOY => "undeploy";
Readonly::Scalar our $ACTION_START => "start";
Readonly::Scalar our $ACTION_STOP => "stop";
Readonly::Scalar our $ACTION_CHECK => "check";

our @ACTIONS = qw(
        $ACTION_DEPLOY
        $ACTION_UNDEPLOY
        $ACTION_START
        $ACTION_STOP
    $ACTION_CHECK
    );

our @EXPORT_OK = qw(
    $APP_SERVER_TOMCAT
    $APP_SERVER_WEBLOGIC
    $APP_SERVER_GLASSFISH
    $APP_SERVER_IIS
    $ACTION_DEPLOY
        $ACTION_UNDEPLOY
        $ACTION_START
        $ACTION_STOP
        $ACTION_CHECK
    );

our %EXPORT_TAGS = (
    'all' => \@EXPORT_OK,
    'app_servers' => \@APP_SERVERS,
    'actions' => \@ACTIONS,
);

1;