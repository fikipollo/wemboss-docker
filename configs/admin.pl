#!/usr/bin/perl

use strict;
use warnings;
use CGI;
use CGI::Carp qw(fatalsToBrowser); # Remove this in production

my $ADMIN_USER="admin";

my $q = new CGI;

print $q->header();

# Output stylesheet, heading etc
output_top($q);

if ($ENV{'REMOTE_USER'} ne $ADMIN_USER){
    print "<h1 style='color:#fff;'>Not allowed</h1>";
}else{
    print "<h1 style='color:#fff;'>Welcome to wEMBOSS admin site</h1>";
    if ($q->param()) {
        # Parameters are defined, therefore the form has been submitted
        create_accounts($q, $ADMIN_USER);
        output_form($q);
    } else {
        # We're here for the first time, display the form
        output_form($q);
    }
}

# Output footer and end html
output_end($q);

exit 0;

#-------------------------------------------------------------

# Outputs the start html tag, stylesheet and heading
sub output_top {
    my ($q) = @_;
    print $q->start_html(
    -title => 'wEMBOSS Admin site',
    -bgcolor => 'white',
    -script => '
    function closeSession(){
        var dest = document.location.href.replace("//","//log:out@");
        var xhr = new XMLHttpRequest();
        xhr.open("POST", dest, true);
        xhr.setRequestHeader("Content-Type", "application/json");
        xhr.send();
        location.reload();
    }
    ',
    -style => {
        -src=>['//netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css', 'https://opensource.keycdn.com/fontawesome/4.7.0/font-awesome.min.css'],
        -code => '
        body {max-width: 1024px; margin: auto;background-color:#333;}
        '
    },
    );
    print "<a class='btn btn-danger pull-right' onclick='javascript:closeSession()'> <i class='fa fa-sign-out' aria-hidden='true'></i> Logout</a>";
}

# Outputs a footer line and end html tags
sub output_end {
    my ($q) = @_;
    print $q->end_html;
}

# Displays the results of the form
sub create_accounts {
    my ($q, $ADMIN_USER) = @_;

    my $which_one = $q->param('action');

    print "<div class='well well-sm'>";
    print $which_one;
    if($which_one eq "Log out"){
        $ENV{'REMOTE_USER'}="";
    }elsif($which_one eq "Create new user"){
        my $user_name = $q->param('user_name');
        my $user_password = $q->param('user_password');
        my $output = `htpasswd -b /usr/local/wEMBOSS/.htpasswd $user_name $user_password`;
        print $output;
        print $q->h4("New user " . $user_name . " created");
        my $output = `mkdir /data/$user_name`;
        print $output;
    }elsif($which_one eq "Create new accounts"){
        my $accounts_count = $q->param('accounts_count') + 0;
        my $password_prefix = $q->param('password_prefix');

        if ( $accounts_count =~ /^[0-9]+$/ ) {
            for (my $i=0; $i < $accounts_count; $i++) {
                my $user_name = "student" . $i;
                my $user_password = $password_prefix . $i;
                my $output = `htpasswd -b /usr/local/wEMBOSS/.htpasswd $user_name $user_password`;
                print $output;
                my $output = `mkdir /data/$user_name`;
                print $output;
            }
        }
        print $q->h4("New accounts created successfully.");
    }elsif($which_one eq "Delete selected users"){
        my @users = $q->param('delete_users');
        for my $user_name (@users) {
            if ($user_name ne $ADMIN_USER){
                my $output = `rm -r /data/$user_name`;
                print $output;
                my $output = `htpasswd -D /usr/local/wEMBOSS/.htpasswd $user_name`;
                print $output;
            }
        }
    }elsif($which_one eq "Delete all student accounts"){
        my $output = `cat /usr/local/wEMBOSS/.htpasswd | grep student | awk -F":" '{print \$1}' | sort`;
        my @users = split(' ', $output);
        for my $user_name (@users) {
            my $output = `rm -r /data/$user_name`;
            print $output;
            my $output = `htpasswd -D /usr/local/wEMBOSS/.htpasswd $user_name`;
            print $output;
        }
    }
    print "</div>";

    $q->delete_all();
}

# Outputs a web form
sub output_form {
    print '<div style="background-color:#fff;padding: 80px 60px;" class="row">';
    print "<div class='col-sm-6' style='margin-bottom:20px;'>";

    my ($q) = @_;
    print $q->start_form(
    -name => 'newuser',
    -method => 'POST',
    );

    print $q->h2("Create new user");
    print "<p class='text-info'><i class='fa fa-info-circle'></i> Please type the name for the new user and the password for wEMBOSS</p>";
    print $q->start_table;
    print $q->Tr(
    $q->td('Name:'),
    $q->td(
    $q->textfield(-name => "user_name", -size => 50, -maxlength=>80)
    )
    );
    print $q->Tr(
    $q->td('Password:'),
    $q->td(
    $q->password_field(-name => "user_password", -size => 50, -maxlength=>80)
    )
    );
    print $q->Tr(
    $q->td('&nbsp;'),
    $q->td($q->submit(-name => "action", -value => 'Create new user', -class=> 'btn btn-success pull-right'))
    );
    print $q->end_table;
    print $q->end_form;

    print $q->start_form(
    -name => 'newstudentusers',
    -method => 'POST',
    );

    print $q->h2("Create new student accounts");
    print "<p class='text-info'><i class='fa fa-info-circle'></i> Please type the total number of accounts to be created, and the prefix for the password for student accounts.</p>";
    print $q->start_table;
    print $q->Tr(
    $q->td('Total student accounts:'),
    $q->td(
    $q->textfield(-name => "accounts_count", -size => 50, -maxlength=>3, -type=>"number")
    )
    );
    print $q->Tr(
    $q->td('Password:'),
    $q->td(
    $q->password_field(-name => "password_prefix", -size => 50, -maxlength=>80)
    )
    );
    print $q->Tr(
    $q->td('&nbsp;'),
    $q->td($q->submit(-name => "action", -value => 'Create new accounts', -class=> 'btn btn-success pull-right'))
    );

    print $q->end_table;
    print $q->end_form;
    print $q->end_div;

    print "<div class='col-sm-6'>";

    my $output = `cat /usr/local/wEMBOSS/.htpasswd | awk -F":" '{print \$1}' | sort`;
    my @users = split(' ', $output);

    print $q->start_form(
    -name => 'deleteusers',
    -method => 'POST',
    );

    print $q->h2("Delete users");
    print "<p class='text-info'><i class='fa fa-info-circle'></i> Please choose the accounts that you want to remove.</p>";

    print $q->start_table;
    print $q->Tr(
    $q->td($q->submit(-name => "action", -value => 'Delete selected users', -class=> 'btn btn-danger')),
    $q->td($q->submit(-name => "action", -value => 'Delete all student accounts', -class=> 'btn btn-warning'))
    );
    print $q->end_table;

    print '<div style="margin-top: 5px; padding: 20px; border: 1px solid #bbb; ">';
    print $q->checkbox_group(-name=>'delete_users',
    -values=>\@users,
    -linebreak=>'true');
    print $q->end_div;

    print $q->end_form;

    print $q->end_div;
    print $q->end_div;
}
