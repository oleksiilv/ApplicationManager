package AppManager::Services::CoreServicesInterfaces::StopAppServiceInterface;

use strict;
use warnings FATAL => 'all';

use Moose::Role;
use namespace::autoclean;

requires 'stop_app';

1;