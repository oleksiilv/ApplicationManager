package AppManager::Services::CoreServicesInterfaces::CheckAppServiceInterface;

use strict;
use warnings FATAL => 'all';

use Moose::Role;
use namespace::autoclean;

requires 'check_app';

1;
