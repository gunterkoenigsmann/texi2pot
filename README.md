texi2pot
========
i7n for texinfo

The problem
-----------
Translating a big TeXinfo document is easy: After all it is just text.
But keeping the translation in sync with the original document over
the time might be a challenging task.

One of the problems is that by default there are no markers that tell
what part of the original document has changed and which of the changes
already have been translated: Other than reading both the original and
the translated text there might not be any indicators that show where
work needs to be done. This is especially true if the whole document
cannot be updated in one go and/or if the maintainer changes and the
translation is in an unknown state.

A Standard for translations
---------------------------
For text embedded in program code there is a standard format that keeps
track which strings have already been translated, for which strings
the original text has changed and which strings are still awaiting
translation: .po files.

~~~~
# celine.texi
#: celine.texi:9
msgid ""
"Maxima implementation of Sister Celine's method. Barton Willis wrote this "
"code. It is released under the @uref{https://creativecommons.org/about/cc0,"
"Creative Commons CC0 license}.\n"
msgstr ""
"Eine Implementierung der Methode von Schwester Celine. Sie wurde von Barton "
"Willis\n"
"geschrieben und unter der\n"
"@uref{https://creativecommons.org/about/cc0,Creative Commons CC0 Lizenz} "
"verffentlicht."

# celine.texi
#: celine.texi:12
msgid ""
"Celine's method is described in Sections 4.1--4.4 of the book \"A=B\", by "
"Marko Petkovsek, Herbert S. Wilf, and Doron Zeilberger.\n"
"This book is available at @uref{http://www.math.rutgers.edu/~zeilberg/AeqB."
"pdf}\n"
msgstr ""
"Die Methode von Schwester Celine wird in den Kapiteln4.1--4.4 des Buches "
"\"A=B\" von\n"
"Marko Petkovsek, Herbert S. Wilf und Doron Zeilberger beschrieben. Das Buch "
"ist unter\n"
"@uref{http://www.math.rutgers.edu/~zeilberg/AeqB.pdf} erhltlich."
~~~~

.po files contain pairs of a string ("msgid") in the untranslated version and
a translated version ("msgstr"). If a translation has changed it is marked as
"fuzzy" and if the msgstr is empty any specialized editor that understands .po
files will highlight these places.

Also for .po files there is extensive support for adding changes from the list
of original strings (a .pot file) to a file with translations of an possibly
much older version (a .po file).

The solution
------------
This repository contains two tools: texi2pot.pl, a perl script that converts
a texinfo file into separate strings in the .po format msgmerge and the other
translation tools from gettext will recognize and po2texi.pl, that convert
the translation back into a texinfo file.

Currently both tools just convert one .texi file to one .pot file or one .po
file back to one .texi file. And they are lacking many features like a --help
switch. But - I wanted to upload them somewhere as a starting point for others
that face the problem of keeping a translation of a big piece of text current.