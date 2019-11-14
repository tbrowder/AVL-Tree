[![Build Status](https://travis-ci.org/tbrowder/AVL-Tree.svg?branch=master)](https://travis-ci.org/tbrowder/AVL-Tree)

# AVL-Tree

This implementation of an AVL Tree has been uploaded
to [rosettacode.org](https://rosettacode.org).

It was initially a translation of the Java version on Rosetta Code.
In addition to the translated code, other public methods have been
added as shown by the asterisk in the following list of all public
methods:

+ insert node
+ delete node
+ show all node keys
+ show all node balances
+ *delete nodes by a list of node keys
+ *find and return node objects by key
+ *attach data per node
+ *return list of all node keys
+ *return list of all node objects


## Synopsis:

See the example in the Github repository and on Rosetta Code.

```
#!/usr/bin/env perl6

use AVL-Tree;
# ...create a tree and some nodes...
my $tree = AVL-Tree.new;
$tree.insert: 1;
$tree.insert: 2, :data\<some important tidbit of knowledge\>;
$my $n = $tree.find: 2;
say $n.data;
some importatant tidbit of knowledge
```

See the internal documentation in the terminal window
by entering:

```
$ p6doc AVL-Tree
```

CREDITS
=======

Thanks for help from IRC `#raku` friends:

+ `thundergnat` (for the idea and check of the initial version)

AUTHOR
======

Tom Browder, `<tom.browder@gmail.com>`

COPYRIGHT & LICENSE
===================

Copyright (c) 2019 Tom Browder, all rights reserved.

This program is free software; you can redistribute it or modify
it under the same terms as Perl 6 itself.

See that license [here](./LICENSE).
