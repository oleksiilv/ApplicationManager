package AppManager::Services::CoreServicesInterfaces::DeployAppServiceInterface;

use strict;
use warnings FATAL => 'all';

use Moose::Role;
use namespace::autoclean;

requires 'deploy_app';

1;
