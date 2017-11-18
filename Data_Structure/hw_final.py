
# coding: utf-8

# In[1]:

class RB_Node:
    def __init__(self, newkey):
        self.key = newkey
        self.left = None
        self.right = None
        self.p = None
        self.color = None


# In[2]:

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


# In[3]:

f = open("test01.txt", 'r')
input = f.readlines()


# In[4]:

rbt = RBT()

for i in range(0, len(input)):
    
    num = int(input[i])
    
    if num == 0:
        break
    
    elif num > 0:
        rbt.rb_insert(RB_Node(num))
    
    else:
        
        k = rbt.rb_search(rbt.root, abs(num))
        
        if k != rbt.nil:
            rbt.rb_delete(k)


# In[5]:

node = []
node_color = []
rbt.rb_inorder_node_list(rbt.root, node, node_color)

nodekey = []
for i in range(0, len(node)):
    nodekey.append(node[i].key)


# In[6]:

f = open("search01.txt", 'r')
search = f.readlines()


# In[7]:

s = ""

for i in range(0, len(search)):
    
    num = int(search[i])
    
    if num == 0:
        break
        
    elif num in nodekey:
        idx = nodekey.index(num)
        if idx == 0 and idx == len(node)-1:
            print("NIL", num, "NIL")
            s = s + "NIL " + str(num) + " NIL "
        elif idx == 0:
            print("NIL", num, nodekey[idx+1])
            s = s + "NIL " + str(num) + " " + str(nodekey[idx+1]) + " "
        elif idx == len(node)-1:
            print(nodekey[idx-1], num, "NIL")
            s = s + str(nodekey[idx-1]) + " " + str(num) + " NIL "
        else:
            print(nodekey[idx-1], num, nodekey[idx+1])
            s = s + str(nodekey[idx-1]) + " " + str(num) + " " + str(nodekey[idx+1]) + " "
        
    else:
        if num < nodekey[0]:
            print("NIL NIL", nodekey[0])
            s = s + "NIL NIL " + str(nodekey[0]) + " "
        elif num > nodekey[len(nodekey)-1]:
            print(nodekey[len(nodekey)-1],"NIL NIL")
            s = s + str(nodekey[len(nodekey)-1]) + " NIL NIL "
        else:
            for k in range(0, len(nodekey)):
                if nodekey[k] < num and num < nodekey[k+1]:
                    print(nodekey[k], "NIL", nodekey[k+1])
                    s = s + str(nodekey[k]) + " NIL " + str(nodekey[k+1]) + " "


# In[8]:

f = open("output.txt", 'w')
f.write(s)
f.close()


# In[ ]:



