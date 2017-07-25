package AppManager::Services::CoreServicesImpl::StopAppServiceTomcat;

use strict;
use warnings FATAL => 'all';

use Moose;
use MooseX::StrictConstructor;
use namespace::autoclean;
use Params::Validate qw(:all);
use LWP::UserAgent;
use HTTP::Request;
use Data::Dumper;

use AppManager::Models::Status;

with 'AppManager::Services::CoreServicesInterfaces::StopAppServiceInterface';

sub stop_app {
    my $this = shift;
    my %args = validate(
        @_, {
            app_server_manager_model =>
            { isa => 'AppManager::Models::AppServerManagerModelTomcat' },
            application => 1
        }
    );
    my $app_server_manager_model = $args{app_server_manager_model};
    my $application = $args{application};

    my $status = AppManager::Models::Status->new();

    my $action_url = $app_server_manager_model->get_url_for_stop_app( application => $application );

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(GET => $action_url);
    my $response = $ua->request($request);

    if ($response->is_success) {
        if ($response->decoded_content =~ "OK ") {
            $status->add_info_message($response->decoded_content);
        }
        else {
            $status->add_warning_message($response->decoded_content);
        }
    }
    else {
        $status->add_error_message($response->status_line);
    }

    return $status;
}

__PACKAGE__->meta->make_immutable;

1;