package AppManager::Services::CoreServicesInterfaces::UndeployAppServiceInterface;

use strict;
use warnings FATAL => 'all';

use Moose::Role;
use namespace::autoclean;

requires 'undeploy_app';

1;
