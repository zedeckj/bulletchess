### dict.h

An implementation of string to void* dictionaries which uses the djb2 hashing algorithm.

```C
dict_t *dict = new_dict(100); // initialize with capacity of 100
dict_add(dict, "foo", "bar"); // adds "bar" with the key "foo"
dict_lookup(dict, "foo"); // retrieves "bar" 
dict_remove(dict, "foo"); // removes the entry under "foo"
dict_free(dict); // free the dictionary


```
