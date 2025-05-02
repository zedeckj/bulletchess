#include "tokenizer.h"

int tests = 0;

void test_str(token_t *tok, char *string) {
	if (!tok) {
		fprintf(stderr, "Expected %s but got an empty token\n", string);
		exit(1);
	}
	else if (strcmp(tok->string, string)){
		fprintf(stderr, "Token has string %s but expected %s\n", tok->string, string);
		exit(1);
	}
	free_token(tok);
	tests++;
}


void test_full(token_t *tok, char * str, char *location) {
	if (!tok) {
		fprintf(stderr, "Expected the token %s but got null\n", str);
		exit(1);
	}
	char buffer[100];
	if (!write_loc(tok->location, buffer)) {
		fprintf(stderr, "Could not format location of token\n");
		exit(1);
	}
	if (strcmp(buffer, location)){
		test_str(tok, str);
		fprintf(stderr, "Token %s has location `%s` but expected `%s`\n", tok->string, buffer, location);
		exit(1);
	}
	test_str(tok, str);
}




void test_null(token_t *tok) {
	if (tok) {
		fprintf(stderr, "Expected empty token but got %s\n", tok->string);
		exit(1);
	}
	tests++;
}

void test_basic() {
	char *str = "1+10 * 100+x";
	tok_context_t *ctx = start_op_ctx("test_basic", "+*");	
	test_str(stoken(str, ctx), "1");	
	test_str(stoken(str, ctx), "+");		
	test_str(stoken(str, ctx), "10");		
	test_str(stoken(str, ctx), "*");		
	test_str(stoken(str, ctx), "100");		
	test_str(stoken(str, ctx), "+");		
	test_str(stoken(str, ctx), "x");
	test_null(stoken(str, ctx));	
	end_context(ctx);	
}

void test1() {
	char *str = "(*(+ 10 20)2)";	
	tok_context_t *ctx = start_op_ctx("test1", "+*()");
	test_full(stoken(str, ctx), "(", "test1:1:1");
	test_full(stoken(str, ctx), "*", "test1:1:2");
	test_full(stoken(str, ctx), "(", "test1:1:3");
	test_full(stoken(str, ctx), "+", "test1:1:4");
	test_full(stoken(str, ctx), "10", "test1:1:6");
	test_full(stoken(str, ctx), "20", "test1:1:9");
	test_full(stoken(str, ctx), ")", "test1:1:11");
	test_full(stoken(str, ctx), "2", "test1:1:12");
	test_full(stoken(str, ctx), ")", "test1:1:13");
	test_null(stoken(str, ctx));
	end_context(ctx);
}

void test2() {
	char *part1 = "[/ 1";
	char *part2 = "2 3]";
	tok_context_t *ctx = start_op_ctx("test2", "/[]");
	test_full(stoken(part1, ctx), "[", "test2:1:1");
	test_full(stoken(part1, ctx), "/", "test2:1:2");
	test_full(stoken(part1, ctx), "1", "test2:1:4");
	test_null(stoken(part1, ctx));
	test_full(stoken(part2, ctx), "2", "test2:1:5");
	test_full(stoken(part2, ctx), "3", "test2:1:7");
	test_full(stoken(part2, ctx), "]", "test2:1:8");
	test_null(stoken(part2, ctx));
	end_context(ctx);
}

void test3() {
	char *text = "12345 +\n1";
	tok_context_t *ctx = start_op_ctx("test3", "+");
	test_full(stoken(text, ctx), "12345", "test3:1:1");
	test_full(stoken(text, ctx), "+", "test3:1:7");
	test_full(stoken(text, ctx), "1", "test3:2:1");
	test_null(stoken(text, ctx));
	end_context(ctx);
}

void test4() {
	char *text = "one two \"three \\\" four\" more";
	tok_context_t *ctx = start_delim_ctx("test4", "\"\"", '\\');
	test_full(stoken(text, ctx), "one", "test4:1:1");
	test_full(stoken(text, ctx), "two", "test4:1:5");
	test_full(stoken(text, ctx), "\"three \" four\"", "test4:1:9");
	test_full(stoken(text, ctx), "more", "test4:1:25");
	test_null(stoken(text, ctx));
	end_context(ctx);
}

void test5() {
	char *text = "^single\ntoken^";
	tok_context_t *ctx = start_delim_ctx("test5", "^^", 0);
	test_full(stoken(text, ctx), "^single\ntoken^", "test5:1:1");
	end_context(ctx);	
}


void test6() {
	char *text = "^single\\^\ntoken^";
	tok_context_t *ctx = start_delim_ctx("test6", "^^", '\\');
	test_full(stoken(text, ctx), "^single^\ntoken^", "test6:1:1");
	end_context(ctx);	
}

void test7() {
	char *text = "1 .2 ^3^ 4. ^5 6^ 7";
	tok_context_t *ctx = start_delim_ctx("test7", "^^..", 0);
	test_str(stoken(text, ctx), "1");	
	test_str(stoken(text, ctx), ".2 ^3^ 4.");	
	test_str(stoken(text, ctx), "^5 6^");	
	test_str(stoken(text, ctx), "7");	
	end_context(ctx);
}

void test8() {
	FILE *file = fopen("Makefile", "r");
	tok_context_t *ctx = start_context("Makefile", ":", "\"\"", 0);
	test_full(ftoken(file, ctx), "all", "Makefile:1:1");
	test_full(ftoken(file, ctx), ":", "Makefile:1:4");
	test_full(ftoken(file, ctx), "#", "Makefile:2:2");
	test_full(ftoken(file, ctx), "\"Compile for testing\"", "Makefile:2:4");
	test_full(ftoken(file, ctx), "cc", "Makefile:3:2");
	test_full(ftoken(file, ctx), "-W", "Makefile:3:5");
	test_full(ftoken(file, ctx), "*.c", "Makefile:3:8");
	test_full(ftoken(file, ctx), "-o", "Makefile:3:12");
	test_full(ftoken(file, ctx), "test", "Makefile:3:15");
	test_null(ftoken(file, ctx));
	end_context(ctx);
}

void test9() {
	char *str = "foo bar baz";
	tok_context_t *ctx = start_def_ctx("test9");
	test_null(stoken(str, 0));
	token_t *tok = stoken(str, ctx);
	untoken(tok, ctx);
	test_full(stoken(str,ctx), "foo", "test9:1:1");
	test_full(stoken(str,ctx), "bar", "test9:1:5");
	end_context(ctx);
}

int main() {
	test_basic();
	test1();
	test2();
	test3();
	test4();
	test5();
	test6();
	test7();
	test8();
	test9();
	printf("All %d tests passed\n", tests);
}
