use Test;

use AVL-Tree;

plan 1;

my $tree = AVL-Tree.new;
my @keys = 4, 2, -1, 4, 5, 9, 6, 14, 11, 20, 10;
for @keys {
    $tree.insert: $_;
}

# new stuff
$tree.insert: 100, :data<some data>;

my $h1 = 0;
my $h2 = 0;

for 9, 10, 100 -> $key {
    my $n = $tree.find: $key;
    if $n {
        $h1 = $n if $key == 100;
        #say "Found node with key '$key'";
        #say "Its data: '{$n.data}'";
    }
    else {
        #say "Found no node with key '$key'";
    }
}
for 9, 10, 100 -> $key {
    my $n = $tree.find: $key;
    if $n {
        $h2 = $n if $key == 100;
        #say "Found node with key '$key'";
        #say "Its data: '{$n.data}'";
    }
    else {
        #say "Found no node with key '$key'";
    }
}

is $h1 === $h2, True, "nodes are the same object";

