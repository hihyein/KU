
# coding: utf-8

# In[ ]:

class RB_Node:
    def __init__(self, newkey):
        self.key = newkey
        self.left = None
        self.right = None
        self.p = None
        self.color = None


# In[ ]:

class RBT:
    
    def __init__(self):
        self.nil = RB_Node(None)
        self.root = self.nil
        

    def rb_insert(self, z):
        y = self.nil
        x = self.root
        while x != self.nil:
            y = x
            if z.key < x.key:
                x = x.left
            else:
                x = x.right
        z.p = y
        if y == self.nil:
            self.root = z
        elif z.key < y.key:
            y.left = z
        else:
            y.right = z
        z.left = self.nil
        z.right = self.nil
        z.color = "RED"
        self.rb_insert_fixup(z)
        
    
    def rb_insert_fixup(self, z):
        while z.p.color == "RED":
            if z.p == z.p.p.left:
                y = z.p.p.right
                if y.color == "RED":
                    z.p.color = "BLACK"
                    y.color = "BLACK"
                    z.p.p.color = "RED"
                    z = z.p.p
                elif z == z.p.right:
                    z = z.p
                    self.left_rotate(z)
                else :
                    z.p.color = "BLACK"
                    z.p.p.color = "RED"
                    self.right_rotate(z.p.p)
            else:
                y = z.p.p.left
                if y.color == "RED":
                    z.p.color = "BLACK"
                    y.color = "BLACK"
                    z.p.p.color = "RED"
                    z = z.p.p
                elif z == z.p.left:
                    z = z.p
                    self.right_rotate(z)
                else:
                    z.p.color = "BLACK"
                    z.p.p.color = "RED"
                    self.left_rotate(z.p.p)
        self.root.color = "BLACK"
        
        
    def left_rotate(self, x):
        y = x.right
        x.right = y.left
        if y.left != self.nil:
            y.left.p = x
        y.p = x.p
        if x.p == self.nil:
            self.root = y
        elif x == x.p.left:
            x.p.left = y
        else :
            x.p.right = y
        y.left = x
        x.p = y
        
        
    def right_rotate(self, x):
        y = x.left
        x.left = y.right
        if y.right != self.nil:
            y.right.p = x
        y.p = x.p
        if x.p == self.nil:
            self.root = y
        elif x == x.p.right:
            x.p.right = y
        else :
            x.p.left = y
        y.right = x
        x.p = y
       
    
    def rb_delete(self, z):
        y = z
        y_original_color = y.color
        if z.left == self.nil:
            x = z.right
            self.rb_transplant(z, z.right)
        elif z.right == self.nil:
            x = z.left
            self.rb_transplant(z, z.left)
        else:
            y = self.rb_minimum(z.right)
            y_original_color = y.color
            x = y.right
            if y.p == z:
                x.p = y
            else:
                self.rb_transplant(y, y.right)
                y.right = z.right
                y.right.p = y
            self.rb_transplant(z, y)
            y.left = z.left
            y.left.p = y
            y.color = z.color
        if y_original_color == "BLACK":
            self.rb_delete_fixup(x)
                
    def rb_transplant(self, u, v):
        if u.p == self.nil:
            self.root = v
        elif u == u.p.left:
            u.p.left = v
        else:
            u.p.right = v
        v.p = u.p
        
        
    def rb_delete_fixup(self, x):
        while x != self.root and x.color == "BLACK":
            if x == x.p.left:
                w = x.p.right
                if w.color == "RED":
                    w.color == "BLACK"
                    x.p.color = "RED"
                    self.left_rotate(x.p)
                    w = x.p.right
                if w.left.color == "BLACK" and w.right.color == "BLACK":
                    w.color = "RED"
                    x = x.p
                else:
                    if w.right.color == "BLACK":
                        w.left.color = "BLACK"
                        w.color = "RED"
                        self.right_rotate(w)
                        w = x.p.right
                    w.color = x.p.color
                    x.p.color = "BLACK"
                    w.right.color = "BLACK"
                    self.left_rotate(x.p)
                    x = self.root
            else:
                w = x.p.left
                if w.color == "RED":
                    w.color == "BLACK"
                    x.p.color = "RED"
                    self.right_rotate(x.p)
                    w = x.p.left
                if w.right.color == "BLACK" and w.left.color == "BLACK":
                    w.color = "RED"
                    x = x.p
                else:
                    if w.left.color == "BLACK":
                        w.right.color = "BLACK"
                        w.color = "RED"
                        self.left_rotate(w)
                        w = x.p.left
                    w.color = x.p.color
                    x.p.color = "BLACK"
                    w.left.color = "BLACK"
                    self.right_rotate(x.p)
                    x = self.root
        x.color = "BLACK"
                
            
    def rb_minimum(self, x):
        while x.left != self.nil:
            x = x.left
        return x
        
        
    def rb_search(self, x, k):
        if x == self.nil or k == x.key:
            return x
        if k < x.key:
            return self.rb_search(x.left, k)
        else:
            return self.rb_search(x.right, k)
        
        
    def rb_print(self, tree, level):
        if tree.right is not self.nil:
            self.rb_print(tree.right, level + 1)
        for i in range(level):
            print('   ', end='')
        print(tree.key)
        if tree.left is not self.nil:
            self.rb_print(tree.left, level + 1)
            
            
    def rb_inorder(self, tree):
        if tree is self.nil:
            return
        else:
            self.rb_inorder(tree.left)
            print(tree.key)
            self.rb_inorder(tree.right)
            
            
    def rb_inorder_node_list(self, tree, list_1, list_2):
        if tree is self.nil:
            return
        else:
            self.rb_inorder_node_list(tree.left, list_1, list_2)
            list_1.append(tree)
            list_2.append(tree.color)
            self.rb_inorder_node_list(tree.right, list_1, list_2)
    
    
    def rb_rightmost_height(self, tree, list):
        if tree is self.nil:
            return
        else:
            list.append(tree)
            self.rb_rightmost_height(tree.right, list)


# In[ ]:

import os

filename = []
filenames = os.listdir('C:/Users/Hyein/Desktop/KU/3-1/자료구조/HW/hw5_rbtest/rbtest')
for i in filenames:
    filename.append(i)


# In[ ]:

for i in range(0, len(filename)):
    f = open(filename[i], 'r')
    test = f.readlines()
    
    rbt = RBT()
    
    insert = 0
    delete = 0
    miss = 0
    for k in range(0, len(test)):
            num = int(test[k])
            
            if num == 0:
                print("filename = " + filename[i])
                
                nodes = []
                color = []
                rbt.rb_inorder_node_list(rbt.root, nodes, color)
                print("total = " + str(len(nodes)))
                
                print("insert = " + str(insert))
                
                print("deleted = " + str(delete))
                
                print("miss = " + str(miss))
                
                nb = 0
                for m in range(0, len(nodes)):
                    if nodes[m].color == "BLACK":
                        nb += 1
                print("nb = " + str(nb))
                
                rightmost = []
                rbt.rb_rightmost_height(rbt.root, rightmost)
                bh = 0
                for n in range(0, len(rightmost)):
                    if rightmost[n].color == "BLACK":
                        bh += 1
                print("bh = " + str(bh))
                
                for s in range(0, len(nodes)):
                    if color[s] == "RED":
                        print(str(nodes[s].key) + " R")
                    else:
                        print(str(nodes[s].key) + " B")
                
                print("\n")
                break
                
            elif num > 0:
                rbt.rb_insert(RB_Node(num))
                insert += 1
                
            else:
                k = rbt.rb_search(rbt.root, abs(num))
                
                if k == rbt.nil:
                    miss += 1
                else :
                    rbt.rb_delete(k)
                    delete += 1

