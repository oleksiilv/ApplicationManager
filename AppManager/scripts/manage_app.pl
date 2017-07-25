#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

#use lib "../modules";

use Getopt::Long;
use Data::Dumper;
use feature qw(say);
use Config::Properties;
use File::Basename qw( dirname );
use Cwd  qw( abs_path );
use lib dirname(dirname abs_path $0) . '/modules';

use AppManager::AppManagerOrchestrator qw(
    manage_app
    manage_configs
    );

say "Hello World!";

my %args;

GetOptions (
    \%args,
    "action=s",
    "app_server=s",
    "hostname=s",
    "port=i",
    "user=s",
    "password=s",
    "application=s",
    "war_filepath=s",
    "config_filepath=s",
    "save_to_config_filepath=s") or die("Error in command line arguments\n");

manage_configs(\%args);
manage_app(%args);
