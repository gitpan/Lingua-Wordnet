use ExtUtils::MakeMaker;

if (shift(@ARGV) =~ /WNLIB_DIR=(.*)/ ) {
    $WNLIB_DIR = $1;
} else {
    die "You need to specify the WNLIB_DIR and WNINC_DIR directories--read README\n";
}
if (shift(@ARGV) =~ /WNINC_DIR=(.*)/ ) {
    $WNINC_DIR = $1;
} else {
    die "You need to specify the WNLIB_DIR and WNINC_DIR directories--read README\n";
} 


print "Examining archive file $WNLIB_DIR/libwn.a...\n";
chomp(@contents = `ar t $WNLIB_DIR/libwn.a`);
@objects = grep(/\.o$/, @contents);
print "Extracting object files from archive: ", join(", ", @objects), "\n";
system("ar", "x", "$WNLIB_DIR/libwn.a", @objects);
my $err = $? >> 8;
if ($err) {
    print "Extraction failed: ar returned exit code $err\n",
          "Please extract them manually into the current directory\n",
          "edit Makefile.PL to remove this section of code and then rerun\n",
          "    perl Makefile.PL\n";
    exit 1;
}
print "Extraction was apparently successful\n";

if (! -r "$WNLIB_DIR/libwn.a") {
    die "WNLIB_DIR $WNLIB_DIR does not contain libwn.a\n";
}

WriteMakefile(
    'NAME'	=> 'Lingua::Wordnet',
    'VERSION_FROM'   => 'Wordnet.pm',
    'INC'       => "-I$WNINC_DIR/ -I./",
    'OBJECT'    => "Wordnet.o @objects"
);
