use lib <./lib>;
use AVL-Tree;

my $tree = AVL-Tree.new;
for 1..10 {
    $tree.insert: $_;
}
$tree.show-keys;

my $n = $tree.find: 2;
$n ?? say $n.key !! say 'not found';

