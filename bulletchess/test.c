#define square(x) \
  ({ typedef xtype = (x); \
     xtype xval = (x); \
     xval*xval; })


int main() {
	square(2);
	return 0;
}
