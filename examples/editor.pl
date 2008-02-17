#!/usr/bin/perl -w
use lib("lib");
use HTML::Template::LZE::Editor;
use HTML::LZE::BBCODE;
use CGI::LZE qw(:all);
init("/srv/www/cgi-bin/config/settings.pl");
print header;
print start_html(-title => 'Editor', -script => [{-type => 'text/javascript', -src => '/javascript/editor.js'}], -style => '/style/Crystal/editor.css',);
if(param('action') && param('action') eq 'add') {
        my $txt = param('message');
        if(param('submit') eq 'preview') {
                print a({href => "$ENV{SCRIPT_NAME}?txt=$txt"}, 'Edit it Again');
                BBCODE(\$txt);
                print br(), $txt;
        } else {
                print "You should save it ", br();
                print $txt;
                print br(), a({href => "$ENV{SCRIPT_NAME}?txt=$txt"}, 'Edit it Again');
        }
} else {
        my %parameter = (

                action => 'add',

                body => param('txt') ? param('txt') : 'body of the message',

                class => "min",

                attach => '1',

                maxlength => '100',

                path => "/srv/www/cgi-bin/templates/",

                reply => '',

                server => "http://localhost",

                style => 'Crystal',

                thread => 'news',

                headline => "New Message",
                title    => "title",
                catlist  => ' ',
                html     => 0,               # html enabled ? 0 for bbcode
        );
        my $editor = new HTML::Template::LZE::Editor(\%parameter);

        print $editor->show();
}

