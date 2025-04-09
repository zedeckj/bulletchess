import random





class Foo:

    _

    def __init__(self, x : int):
        """
        Bar!
        """
        self.__x = x

    def __str__(self) -> str:
        return "im foo"

    def __new__(cls, x : int):
        """
        Foo!
        """
        obj = foo_table[x]
        return obj
    

def init_foo(x : int):
    foo = object.__new__(Foo)
    foo.x = x
    return foo

foo_table = {
    1: Foo.__init__(object.__new__(Foo), 1),
    2: Foo.__init__(object.__new__(Foo), 2)
}

f1 = Foo(1)

f2 = Foo(2)

print(f1 == f2)