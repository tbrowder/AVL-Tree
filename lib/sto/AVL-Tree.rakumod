#|{{

This code has been translated from the Java version on
<https://rosettacode.org>. Consequently, it should have the same
license: GNU Free Document License 1.2.  In addition to the translated
code, other public methods have been added as shown by the asterisks
in the following list of all public methods:

+  insert node
+  delete node
+  show all node keys
+  show all node balances
+ *delete nodes by a list of node keys
+ *search and return node objects by key
+ *attach data per node
+ *return list of all node keys
+ *return list of all node objects
+ *return node with minimum key
+ *return node with maximum key

}}

# see some solutions at:
#    https://mitpress.mit.edu/algorithms
class AVL-Tree {
    has $.root is rw = 0;

    class Node {
        has $.key is rw = Nil;
        has $.parent is rw = 0;
        has $.data   is rw = 0;
        has $.left   is rw = 0;
        has $.right  is rw = 0;
        has Int $.balance is rw = 0;
        has Int $.height  is rw = 0;
    }

    #=====================================================
    # public methods
    #=====================================================

    #| return successor node of node x or 0
    #| if x has the largest key in the tree
    method successor($x is copy) {
        die "FAILURE: Called 'successor' on a nil node." if !$x;
        return min($x.right) if $x.right;
        my $y = $x.parent;
        while $y && $x === $y.right {
            $x = $y;
            $y = $y.parent;
        }
        $y
    }

    #| return predecessor node of node x or 0
    #| if x has the smallest key in the tree
    method predecessor($x is copy) {
        die "FAILURE: Called 'predecessor' on a nil node." if !$x;
        return max($x.left) if $x.left;
        my $y = $x.parent;
        while $y && $x === $y.left {
            $x = $y;
            $y = $y.parent;
        }
        $y
    }

    #| return node with minimum key in subtree of node x
    method min($x = $.root) {
        die "FATAL: Calling 'min' on a null node." if !$x;
        my $n = $x;
        while $n.left {
            $n = $n.left;
        }
        $n
    }

    #| return node with maximum key in subtree of node x
    method max($x = $.root) {
        die "FATAL: Calling 'max' on a null node." if !$x;
        my $n = $x;
        while $n.right {
            $n = $n.right;
        }
        $n
    }

    #| returns a node object or 0 if not found
    method search($key) {
        self!search: $key, $.root;
    }

    #| returns a list of tree keys
    method keys() {
        return () if !$.root;
        my @list;
        self!keys: $.root, @list;
        @list;
    }

    #| returns a list of tree nodes
    method nodes() {
        return () if !$.root;
        my @list;
        self!nodes: $.root, @list;
        @list;
    }

    #| insert a node key, optionally add data (the `parent` arg is for
    #| internal use only)
    method insert($key, :$data = 0, :$parent = 0) {
# TODO don't allow dup key (default behavior)
        return $.root = Node.new: :$key, :$parent, :$data if !$.root;
        my $n = $.root;
        while True {
            return False if $n.key eq $key;
            my $parent = $n;
            my $goLeft = $n.key gt $key;
            $n = $goLeft ?? $n.left !! $n.right;
            if !$n {
                if $goLeft {
                    $parent.left = Node.new: :$key, :$parent, :$data;
                }
                else {
                    $parent.right = Node.new: :$key, :$parent, :$data;
                }
                self!rebalance: $parent;
                last
            }
        }
        True
    }

    #| delete one or more nodes by key
    method delete(*@del-key) {
        return if !$.root;
        for @del-key -> $del-key {
            return if !$.root;
            for @del-key -> $del-key {
                my $child = $.root;
                while $child {
                    my $node = $child;
                    $child = $del-key ge $node.key ?? $node.right !! $node.left;
                    if $del-key eq $node.key {
                        self!delete: $node;
                        next;
                    }
                }
            }
        }
    }

    #| show a list of all nodes by key
    method show-keys {
        self!show-keys: $.root;
        say()
    }

    #| show a list of all nodes' balances (not normally needed)
    method show-balances {
        self!show-balances: $.root;
        say()
    }

    #=====================================================
    # private methods
    #=====================================================

    method !delete($node) {
        if !$node.left && !$node.right {
            if !$node.parent {
                $.root = 0;
            }
            else {
                my $parent = $node.parent;
                if $parent.left === $node {
                    $parent.left = 0;
                }
                else {
                    $parent.right = 0;
                }
                self!rebalance: $parent;
            }
            return
        }

        if $node.left {
            my $child = $node.left;
            while $child.right {
                $child = $child.right;
            }
            $node.key = $child.key;
            self!delete: $child;
        }
        else {
            my $child = $node.right;
            while $child.left {
                $child = $child.left;
            }
            $node.key = $child.key;
            self!delete: $child;
        }
    }

    method !rebalance($n is copy) {
        self!set-balance: $n;

        if $n.balance == -2 {
            if self!height($n.left.left) >= self!height($n.left.right) {
                $n = self!rotate-right: $n;
            }
            else {
                $n = self!rotate-left'right: $n;
            }
        }
        elsif $n.balance == 2 {
            if self!height($n.right.right) >= self!height($n.right.left) {
                $n = self!rotate-left: $n;
            }
            else {
                $n = self!rotate-right'left: $n;
            }
        }

        if $n.parent {
            self!rebalance: $n.parent;
        }
        else {
            $.root = $n;
        }
    }

    method !rotate-left($a) {
        my $b     = $a.right;
        $b.parent = $a.parent;

        $a.right = $b.left;

        if $a.right {
            $a.right.parent = $a;
        }

        $b.left   = $a;
        $a.parent = $b;

        if $b.parent {
            if $b.parent.right === $a {
                $b.parent.right = $b;
            }
            else {
                $b.parent.left = $b;
            }
        }

        self!set-balance: $a, $b;
        $b;
    }

    method !rotate-right($a) {
        my $b = $a.left;
        $b.parent = $a.parent;

        $a.left = $b.right;

        if $a.left {
            $a.left.parent = $a;
        }

        $b.right  = $a;
        $a.parent = $b;
        if $b.parent {
            if $b.parent.right === $a {
                $b.parent.right = $b;
            }
            else {
                $b.parent.left = $b;
            }
        }

        self!set-balance: $a, $b;
        $b;
    }

    method !rotate-left'right($n) {
        $n.left = self!rotate-left: $n.left;
        self!rotate-right: $n;
    }

    method !rotate-right'left($n) {
        $n.right = self!rotate-right: $n.right;
        self!rotate-left: $n;
    }

    method !height($n) {
        $n ?? $n.height !! -1;
    }

    method !set-balance(*@n) {
        for @n -> $n {
            self!reheight: $n;
            $n.balance = self!height($n.right) - self!height($n.left);
        }
    }

    method !show-balances($n) {
        if $n {
            self!show-balances: $n.left;
            printf "%s ", $n.balance;
            self!show-balances: $n.right;
        }
    }

    method !reheight($node) {
        if $node {
            $node.height = 1 + max self!height($node.left),
                                   self!height($node.right);
        }
    }

    method !show-keys($n) {
        if $n {
            self!show-keys: $n.left;
            printf "%s ", $n.key;
            self!show-keys: $n.right;
        }
    }

    method !nodes($n, @list) {
        return if !$n;
        self!nodes: $n.left, @list;
        @list.push: $n if $n;
        self!nodes: $n.right, @list;
    }

    method !keys($n, @list) {
        if $n {
            self!keys: $n.left, @list;
            @list.push: $n.key if $n;
            self!keys: $n.right, @list;
        }
    }

    method !search($key, $n is copy = $.root) {
        while $n && $key ne $n.key {
            if $key lt $n.key {
                $n = $n.left;
            }
            else {
                $n = $n.right;
            }
        }
        $n

        =begin comment
        if !$n || $key eq $n.key {
            return $n;
        }
        if $key lt $n.key {
            return self!search: $key, $n.left;
        }
        else {
            return self!search: $key, $n.right;
        }
        =end comment
    }
}
