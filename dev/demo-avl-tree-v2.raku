# This code tracks the tests.

use AVL-Tree:api<2>;

my $tree = AVL-Tree.new;
my @list = 1..10, 4;
say "Keys to be inserted in the order shown (notice the two 4's):";
print " $_" for @list; say "";
$tree.insert($_) for @list;

say "Keys shown in tree-in-order listing (notice no duplicates):";
$tree.show-keys; say "";

my @odd = 1, 3, 5, 7, 9;
my @even = 2, 4, 6, 8, 10;
say "Deleting odd keys:";
my @keys = $tree.keys;
print " $_" for @keys; say "";
$tree.delete: @odd;

say "Keys shown in tree-in-order listing (notice no odd keys):";
$tree.show-keys;
say "";

# new stuff
say "Entering new node with key '100' and data 'some data'";
$tree.insert: 100, :data<some data>;

my @k = $tree.keys;
say "Find all keys...";
print " $_" for @k;
say();

my @n = $tree.nodes;
say "Find all data...";
for @n -> $n {
    next if !$n.data;
    say "=== node key: {$n.key}";
    say "    data: '{$n.data}'";
}

say "Find non-existent key 200:";
my $x = $tree.search: 200;
say "Found key 200? {$x ?? $x.key !! 'not found'}";

say "Find existing key 10:";
$x = $tree.search: 10;
say "Found key 200? {$x ?? $x.key !! 'not found' }";

say "Find min key:";
$x = $tree.min;
say "Result: {$x ?? $x.key !! $x}";

say "Find max key:";
$x = $tree.max;
say "Result: {$x ?? $x.key !! $x}";

