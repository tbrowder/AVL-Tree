[![Actions Status](https://github.com/tbrowder/AVL-Tree/actions/workflows/linux.yml/badge.svg)](https://github.com/tbrowder/AVL-Tree/actions) [![Actions Status](https://github.com/tbrowder/AVL-Tree/actions/workflows/macos.yml/badge.svg)](https://github.com/tbrowder/AVL-Tree/actions) [![Actions Status](https://github.com/tbrowder/AVL-Tree/actions/workflows/windows.yml/badge.svg)](https://github.com/tbrowder/AVL-Tree/actions)

AVL-Tree
========

This implementation of an AVL Tree has been uploaded to [rosettacode.org](https://rosettacode.org).

It was initially a translation of the Java version on Rosetta Code. In addition to the translated code, other public methods have been added as shown by the leading asterisk in the following list of all public methods:

  * insert node

  * delete node

  * show all node keys

  * show all node balances

  * *delete nodes by a list of node keys

  * *find and return node objects by key

  * *attach data per node

  * *return list of all node keys

  * *return list of all node objects

Synopsis
--------

See the example in the Github repository and on Rosetta Code.

    #!/usr/bin/env raku

    use AVL-Tree;
    # ...create a tree and some nodes...
    my $tree = AVL-Tree.new;
    $tree.insert: 1;
    $tree.insert: 2, :data<some important tidbit of knowledge>;
    my $n = $tree.find: 2;
    say $n.data;
    some important tidbit of knowledge

CREDITS
=======

Thanks for help from IRC '#raku' friends:

  * 'thundergnat' (for the idea and check of the initial version)

AUTHOR
======



Tom Browder, (tbrowder@acm.org)

COPYRIGHT
=========

& LICENSE

Copyright (c) 2019-2022 Tom Browder, all rights reserved.

This program is free software; you can redistribute it or modify it under the same terms as Raku itself with the following exception:

The code for the methods **without a leading asterisk** in the list above are covered by the GNU Free Document License 1.2.

