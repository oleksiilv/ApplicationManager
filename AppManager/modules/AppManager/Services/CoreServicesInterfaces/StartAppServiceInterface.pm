package AppManager::Services::CoreServicesInterfaces::StartAppServiceInterface;

use strict;
use warnings FATAL => 'all';

use Moose::Role;
use namespace::autoclean;

requires 'start_app';

1;
