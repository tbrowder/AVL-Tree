use v6;
use Test;

plan 16;

use AVL-Tree;

my @list = 1..10;
my $tree = AVL-Tree.new;
$tree.insert($_) for @list;

# show keys
my @keys = $tree.keys;
is-deeply @keys, @list, 'get list of keys';

# delete keys
my @odd = 1, 3, 5, 7, 9;
my @even = 2, 4, 6, 8, 10;
$tree.delete: @odd;
@keys = $tree.keys;
is-deeply @keys, @even, 'delete list of keys';

# show nodes
my @n = $tree.nodes;
for 0..3 {
    is @n[$_].key, @even[$_], 'test for key deletion';
}

# find specific keys
my $node = $tree.search: 2;
is $node.key, 2, 'find existing key';
$node = $tree.search: 10;
is $node.key, 10, 'find existing key';
# non-existent key
$node = $tree.search: 100;
nok $node, 'assure key was deleted';

# retrieve data
$tree.insert: 12, :data<a>;
$node = $tree.search: 12;
is $node.data, 'a', 'assure key data is valid';

# find minimum key
my $min = $tree.min;
is $min.key, 2, 'find minimum key';

# find maximum key
my $max = $tree.max;
is $max.key, 12, 'find maximum key';

# find successors
my $x = $tree.search: 10;
my $s = $tree.successor: $x;
is $s.key, 12, 'find successor';
$x = $tree.search: 12;
$s = $tree.successor: $x;
nok $s, 'find successor (nil) of max key';

# find predecessors
$x = $tree.search: 8;
$s = $tree.predecessor: $x;
is $s.key, 6, 'find predecessor';
$x = $tree.search: 2;
$s = $tree.predecessor: $x;
nok $s, 'find predecessor (nil) of min key';
