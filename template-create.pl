#!/usr/bin/perl
package MT::Tool::TemplateCreate;
use Encode;
use strict;
use warnings;
use File::Spec;
use FindBin;
use lib map File::Spec->catdir( $FindBin::Bin, File::Spec->updir, $_ ), qw/lib extlib/;
use base qw( MT::Tool );

binmode(STDOUT, ":utf8");

sub usage { '--debug 1' }

sub help {
    return q {
        Description Foo.
        --debug 1
    };
}

my ( $debug, $blog_id, $name, $outfile, $linked_file );

sub options {
    return (
        'debug=s'   => \$debug,
        'blog_id=s' => \$blog_id,
        'name=s' => \$name,
        'outfile=s' => \$outfile,
        'linked_file=s' => \$linked_file,
    );
}

sub main {
    my $class = shift;
    my ( $verbose ) = $class->SUPER::main( @_ );

    if ( $blog_id && $name && $outfile && $linked_file ) {
        my $tmpl = MT::Template->load({ blog_id => $blog_id });
        $tmpl->name($name);
        $tmpl->type("index");
        $tmpl->outfile($outfile);
        $tmpl->linked_file($linked_file);
        $tmpl->save
            or die $tmpl->errstr;
    }

    if ( $debug ) {
        print 'Some debug message.' ."\n";
    }

    1;
}

__PACKAGE__->main() unless caller;
