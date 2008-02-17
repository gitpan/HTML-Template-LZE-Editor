use strict;
use Module::Build;
my $class = Module::Build->subclass(class => "Module::Build::Custom", code => <<'SUBCLASS' );
my $release = 'blib/html/';
my $dir     = 'htdocs/';
my $path = '.';
sub ACTION_build {
my $self = shift;
&change($dir);
$release = 'blib/perl/';
$dir     = 'cgi-bin/';
&change($dir);
$dir     = '../window/cgi-bin/';
&change($dir);
$release = 'blib/lib/';
$dir     = '../window/lib/';
&change($dir);
$self->SUPER::ACTION_build;
}
sub change {
my $d = shift;
chomp($d);
opendir(IN, $d) or warn "cant open $d $!:$/";
my @files = readdir(IN);
closedir(IN);
for(my $i = 0 ; $i <= $#files ; $i++) {
unless ($files[$i] =~ /^\./) {
my $c = $d . $files[$i];
my $e = $c;
$e =~ s/^$dir(.*)/$1/;
unless (-d $d . $files[$i]) {
system(" cp " . $c . " $release/$e") unless (-e $release . "/" . $e && $files[$i] =~ /\~$/);
} else {
system("mkdir -p $release/$e") unless (-e $release . "/" . $e);
&change($d . $files[$i] . "/");
}
}
}
}
SUBCLASS
my $htd = "/srv/www/htdocs";
my $cv  = "/srv/www/cgi-bin";
my $prefix;
use vars qw( $settings );
eval 'use CGI::LZE::Settings qw($settings loadSettings saveSettings)';
unless ($@) {
        loadSettings();
        *settings    = \$CGI::LZE::Settings::settings;
        $htd         = $settings->{cgi}{DocumentRoot} if -e $settings->{cgi}{DocumentRoot};
        $cv         = $settings->{cgi}{bin} if -e $settings->{cgi}{bin};
}
my $skip= 0;
$prefix = $1 if "@ARGV" =~ /--prefix (\S+)/;
if( "@ARGV" =~ /--htdocs (\S+) --cgi (\S+)/){
        $htd = $1;
        $cv  = $2;
        $skip = 1;
}
unless ($skip){
$htd = Module::Build->prompt("Where is your Document root ?",     $htd);
$cv  = Module::Build->prompt("Where is your cgi-bin Directory ?", $cv);
}
$class->new(
module_name => 'HTML::Template::LZE::Editor',
requires => {
            'Test::More' => 0.7,
            'Test::Signature' => 1.10,
            'Module::Build' => 0.2808,
            'Test::Pod' =>  1.26,
            'Test::Pod::Coverage' =>  0.55,
            'CGI::LZE' => 0.24,
            'HTML::Template::LZE::Template'  => 0.24,
            'HTML::Template::LZE::Window'  => 0.24,
            'HTML::Entities' => 1.35,
            'Syntax::Highlight::Perl' => 1.00,
},
($] >= 5.005 ? (AUTHOR => 'Dirk Lindner <lindnerei@o2online.de>') : ()),
dist_abstract => 'BBCode editor',
license => 'lgpl',
install_path => { html => $prefix.$htd , perl => $prefix . $cv},
create_makefile_pl => 'passthrough',
)->create_build_script;
