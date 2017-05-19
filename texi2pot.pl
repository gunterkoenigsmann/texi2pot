#!/usr/bin/perl

    # texi2pot: Split a .texi file into strings accessible to msgmerge
    # Copyright (C) {2017}  {Gunter Königsmann}

    # This program is free software: you can redistribute it and/or modify
    # it under the terms of the GNU General Public License as published by
    # the Free Software Foundation, either version 3 of the License, or
    # (at your option) any later version.

    # This program is distributed in the hope that it will be useful,
    # but WITHOUT ANY WARRANTY; without even the implied warranty of
    # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    # GNU General Public License for more details.

    # You should have received a copy of the GNU General Public License
    # along with this program.  If not, see <http://www.gnu.org/licenses/>.

print "# This file contains all translatable strings from a .texi file.\n";
print "# Copyright (C) YEAR THE PACKAGE'S COPYRIGHT HOLDER\n";
print "# This file is distributed under the same license as the PACKAGE package.\n";
print "# FIRST AUTHOR <EMAIL@ADDRESS>, YEAR.\n";
print "#\n";
print "#, fuzzy\n";
print "msgid \"\"\n";
print "msgstr \"\"\n";
print "\"Project-Id-Version: PACKAGE VERSION\\n\"\n";
print "\"Report-Msgid-Bugs-To: \\n\"\n";
print "\"POT-Creation-Date: 2017-05-06 22:01+0200\\n\"\n";
print "\"PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE\\n\"\n";
print "\"Last-Translator: FULL NAME <EMAIL@ADDRESS>\\n\"\n";
print "\"Language-Team: LANGUAGE <LL@li.org>\\n\"\n";
print "\"Language: \\n\"\n";
print "\"MIME-Version: 1.0\\n\"\n";
print "\"Content-Type: text/plain; charset=UTF-8\\n\"\n";
print "\"Content-Transfer-Encoding: 8bit\\n\"\n";

$lastline = "";
$paragraph = "";

%knownParagraphs = ();

# Read the file line by line
while (my $line = <>) {

    # Skip duplicate blank lines
    if (($line ne "\n") || ($line ne $lastline))
    {
	# Is this the last line of a paragraph?
	if($line eq "\n")
	{
	    if ($paragraph ne "\n")
	    {
		$message = "\n#: ";
		$message .= $ARGV;
		$message .=":";
		$message .= $.;
		$message .= "\nmsgid \"\"\n";
		$message .= $paragraph;
		# msgmerge doesn't like 2 paragraphs to be exactly identical =>
		# if we detect several occurrences of an identical paragraph we
		# equip all but the 1st one with comments that cause them to be
		# different from each other.
		if( exists $knownParagraphs{$paragraph} )
		{
		    $knownParagraphs{$paragraph} = $knownParagraphs{$paragraph} + 1;
		    $message .= "\@c Occurrences of paragraphs with this contents up to now: ";
		    $message .= $knownParagraphs{$paragraph} - 1;
		    $message .= "\n";
		}
		else
		{
		    $knownParagraphs{$paragraph} = '1';
		}
		$message .= "msgstr \"\"\n";

		print $message;
	    }
	    $paragraph = "";
	}
	else
	{
	    # Escape quotation marks
	    $line =~ s/\"/\\"/g;
	    # Add a c-style newline marker to the line
	    $line =~ s/(..*)/\"\1\\n\"/g;
	    $paragraph .= $line;
	}
    }
    $lastline = $line;
}
