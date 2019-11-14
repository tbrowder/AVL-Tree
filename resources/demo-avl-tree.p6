#!/usr/bin/env perl6

# This code has been translated from the Java version on
# rosettacode.org. Consequently, it should have the same license: GNU
# Free Document License 1.2.  In addition to the translated code,
# other public methods have been added as shown by the asterisk in the
# following list of all public methods:
#
# +  insert node
# +  delete node
# +  show all node keys
# +  show all node balances
# + *delete nodes by a list of node keys
# + *find and return node objects by key
# + *attach data per node
# + *return list of all node keys
# + *return list of all node objects

use AVL-Tree;

my $tree = AVL-Tree.new;
my @keys = 4, 2, -1, 4, 5, 9, 6, 14, 11, 20, 10;
say "Keys to be inserted in the order shown (notice the two 4's):";
print " $_" for @keys; say "";
for @keys {
    $tree.insert: $_;
}
say "Keys shown in tree-in-order listing (notice no duplicates):";
$tree.show-keys; say "";

@keys = -1, 5, 9;
say "Deleting odd keys:";
print " $_" for @keys; say "";
$tree.delete: @keys;
$tree.delete: 11;

say "Keys shown in tree-in-order listing (notice no odd keys):";
$tree.show-keys; say "";

# new stuff
$tree.insert: 100, :data<some data>;
$tree.show-keys;

for 9, 10, 100 -> $key {
    my $n = $tree.find: $key;
    if $n {
        say "Found node with key '$key'";
        say "Its data: '{$n.data}'";
    }
    else {
        say "Found no node with key '$key'";
    }
}

my @k = $tree.keys;
say "Find all keys...";
print " $_" for @k;
say();

my @n = $tree.nodes;
say "Find all ...";
for @n -> $n {
    say "=== node key: {$n.key}";
    say "    data: {$n.data}";
}
