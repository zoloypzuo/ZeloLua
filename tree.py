'''
general tree data structure, supports:
2. init tree with a text file that use tabs to show the tree structure

'''


class Node:

    def __init__(self, title='', id=0):
        self.id = id
        self.title = title
        self.childs = []
    def add_node(self,title):
        new_node=Node(title)
        self.childs.append(new_node)
        return new_node

class Tree:
    def __init__(self):
        self.root = Node("root", 0)
        self._id_counter = 1  # allocate id when manually add nodes

    def __getitem__(self, id):
        def _find(root, id):
            if root == None:
                return None
            if root.id == id:
                return root
            for i in root.childs:
                x = _find(i, id)
                if x != None:
                    return x

        return _find(self.root, id)

    def add_node(self, title, parent_id):
        '''
        add node, using node id to specify a parent obj, return a new node directly
        :param title:
        :param parent:
        :param parent_id:
        :return: new_node
        '''
        parent = self[parent_id]
        new_node = Node(title, self._id_counter)
        self._id_counter += 1
        parent.childs.append(new_node)
        return new_node

def test():
    t=Tree()
    n1=t.root.add_node('1')
    n2=t.root.add_node('2')
    n3=n1.add_node('3')

if __name__ == '__main__':
    test()
