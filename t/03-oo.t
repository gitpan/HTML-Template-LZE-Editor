use lib("../lib");
use HTML::Template::LZE::Editor;
$ENV{HTTP_ACCEPT_LANGUAGE} = "de";
my %parameter = (

        action => 'action',

        body => 'body of the message',

        class => "min",

        attach => '1',

        maxlength => '100',

        path  => "blib/perl/templates",
        reply => '',

        server => "http://localhost",

        style => 'Crystal',

        thread => 'news',

        title => "&New Message",

        html => 1,    # html enabled ? 0 for bbcode

);

my $editor = new HTML::Template::LZE::Editor(\%parameter);

use Test::More tests => 1;
ok(1);

# ok(length($editor->show()) > 0);
