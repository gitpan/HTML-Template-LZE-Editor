use Test::More;
eval 'use Test::Pod::Coverage 0.55';
plan skip_all => 'Test::Pod::Coverage 0.55 is required to run this test' if $@;
plan tests => 1;
pod_coverage_ok("HTML::Template::LZE::Editor", "HTML::Template::LZE::Editor is covered");
