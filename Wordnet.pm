package Lingua::Wordnet;

use strict;
use Carp;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK $AUTOLOAD);

require Exporter;
require DynaLoader;
require AutoLoader;

@ISA = qw(Exporter DynaLoader);
@EXPORT = qw(
);
@EXPORT_OK = qw(do_findtheinfo);

$VERSION = '0.01';

sub AUTOLOAD {
    my $constname;
    ($constname = $AUTOLOAD) =~ s/.*:://;
    croak "& not defined" if $constname eq 'constant';
    my $val = constant($constname, @_ ? $_[0] : 0);
    if ($! != 0) {
	if ($! =~ /Invalid/) {
	    $AutoLoader::AUTOLOAD = $AUTOLOAD;
	    goto &AutoLoader::AUTOLOAD;
	}
	else {
		croak "Your vendor has not defined Wordnet macro $constname";
	}
    }
    no strict 'refs';
    *$AUTOLOAD = sub () { $val };
    goto &$AUTOLOAD;
}

bootstrap Lingua::Wordnet $VERSION;

# Preloaded methods go here.

# Autoload methods go after =cut, and are processed by the autosplit program.

1;
__END__

=head1 NAME

Lingua::Wordnet - Perl extension for access to Wordnet lexical databases.

=head1 SYNOPSIS

  use Lingua::Wordnet qw(do_findtheinfo);
  $text = do_findtheinfo($word, $pos, $ptr_type, $sense_num);

=head1 DESCRIPTION

Lingua::Wordnet gives perl developers the ability to retrieve information from 
the Wordnet 1.6 databases. To quote from the distribution, "WordNet® is an on-line lexical reference system whose design is
inspired by current psycholinguistic theories of human lexical memory.
English nouns, verbs, adjectives and adverbs are organized into synonym
sets, each representing one underlying lexical concept. Different relations
link the synonym sets." For more information on Wordnet, see 
http://www.cogsci.princeton.edu/~wn/ .

At present the only Wordnet API function provided is findtheinfo(), which 
provides the same information as the Wordnet browser executable. To use 
this information you must then parse the returned text (an easy feat with 
perl). The other API search functions (findtheinfo_ds(), index_lookup(), etc.) 
will be added in the future (or not), and given an OO interface (or not). The Wordnet utility functions won't be duplicated, as perl generally provides a better interface for those tasks.

As an example, Lingua::Wordnet can take a term, for example, "canary":

    print do_findtheinfo("canary",1,29,0);

This will print out all (overview, 29) synsets of the noun (1) "canary":

    The noun canary has 4 senses (no senses from tagged texts):
    1. fink, snitch, stoolpigeon, stoolie, sneak, canary -- (someone 
       acting as an informer or decoy for the police)
    2. canary -- ((informal) a female singer)
    3. canary yellow, canary -- (a moderate yellow with a greenish tinge)
    4. canary, canary bird -- (any of several small Old World finches)

To lookup the holonyms of "canary" sense #4 (above):

    print do_findtheinfo("canary",1,13,4);

This will print the holonyms ("canary is a part of .."):

    MEMBER OF: Serinus, genus Serinus -- (Old World finches: e.g. 
    canaries and serins)

As a last example, to print out the hypernyms ("a __ is a type of canary"):

    print do_findtheinfo("canary",1,2,4);

Will result in:

    => finch -- (any of numerous small songbirds with short stout 
       bills adapted for crushing seeds)

=over 4 

=head2 Usage

=item $text = do_findtheinfo($word, $pos, $ptr_type, $sense_num);

This performs exactly like the API routine findtheinfo(). Refer to the 
Wordnet API documentation for more details. It searches the Wordnet database for $word. $pos is an integer value with the following key:

    1    NOUN
    2    VERB
    3    ADJECTIVE
    4    ADVERB

$ptr_type is an integer that determines what type of data is returned, and can take the following values:

    1    Antonyms
    2    Hypernyms
    3    Hyponyms
    4    Entailment
    5    Similar
    6    Member meronym
    7    Substance meronym
    8    Part meronym
    9    Member holonym
    10   Substance holonym
    11   Part holonym
    12   All meronyms
    13   All holonyms
    14   Cause
    15   Participle of verb
    16   Also see
    17   Pertains to noun or derived from adjective
    18   Attribute
    19   Verb group
    20   Find synonyms
    21   Polysemy
    22   Verb example sentences and generic frames
    23   Noun coordinates
    24   Group related senses
    25   Hierarchical meronym search
    26   Hierarchical holonym search
    27   Not used
    28   Find keywords by substring
    29   Show all synsets for word

$sense_num is also an integer which determines which sense number of $word is looked up.

=back

=head1 NOTES

Please let me know if you use this module, or could use additional 
functionality. Although I may not be able to add functionality immediately, 
it will help to motivate knowing that the module is being used.

=head1 COPYRIGHT

Copyright 1999 Dan Brian. All rights reserved.

This module is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

D. Brian, dbrian@clockwork.net

=head1 SEE ALSO

perl(1).

=cut
