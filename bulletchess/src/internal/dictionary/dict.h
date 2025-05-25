#include <stdlib.h>
#include <stdio.h>
#include <stdarg.h>
#include <string.h>
#include <stdbool.h>
#ifndef DICTLIBHEAD
#define DICTLIBHEAD

typedef struct {
	char *key;
	void *value;
	size_t hash_val;
} table_entry_t;

typedef struct {
		bool *is_occupied;
		size_t length;
		table_entry_t *entries;
		size_t capacity;
		// Initialized to 0, points to the last retrieved value
		void *retrieved;
} dict_t;



#define new_dict_with(capacity, ...) new_dict_with_func(capacity, __VA_ARGS__, 0)

// Construct a dict with preset key value pairs. Call with `dict_with` macro
dict_t *new_dict_with_func(size_t capacity, ...);

// Allocates a new dictionary
dict_t *new_dict(size_t capacity);


// Frees a dictionary and its keys.
void dict_free(dict_t *dict);


// Performs a lookup of the given key on the dictionary. Returns 0 if not found. 
void *dict_lookup(dict_t *dict, char *key);

// Returns true if adding the given key value pair was succseful
bool dict_add(dict_t *dict, char *key, void *value);

// Returns the removed value if the given key was succesful. 0 if the key was not present.
void *dict_remove(dict_t *dict, char *key); 

// Returns an array of pointers to the values in this dictionary. The length of this array is the same as dict_t.length
void **dict_values(dict_t *dict);

// Returns an array of pointers to the keys in this dictionary. The length of this array is the same as dict_t.length
char **dict_keys(dict_t *dict);

/* A note about memory management:
 * Dict keys are copied into the dictionary's own allocated char *, but values
 * are not copied and left as references. Don't free a value in a diciontary 
 * if you want to retrieve it later.
 */


#endif
