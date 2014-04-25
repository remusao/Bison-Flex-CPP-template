Bison Flex C++ Template
=====================

Usage
-----

First check that the project is compiling without any error on your system before proceeding to any further customization.

```sh
$ git clone https://github.com/remusao/Bison-Flex-C---template.git bison-flex-template
$ cd bison-flex-template
$ ./configure
$ make
```

This should produce an executable `parser` at the root of your `bison-flex-template` directory. By default it read its input from `stdin`:

```sh
$ echo "foo" | ./parser
# 1.1 Unexpected token : t
# 1.2 Unexpected token : o
# 1.3 Unexpected token : t
# 1.4 Unexpected token : o
# 1.5-2.1: syntax error, unexpected TOK_EOF, expecting $end
```

By default, the scanner don't recognize any token except `eof` (end of file, or end of input), and every character read is considered an unknown token, that's why every letter is reported as an error.
We see that location is updated as each line starts with a couple `l.c` where `l` is the line and `c` is the column of the token. The four first lines are Lexer errors (unrecognised tokens), but the
last is a Parser error (since our grammar don't have any rule).

Customization
-------------

I won't write a complete explanation on how Bison and Flex work but once you get a program structure that run well (which can be quite difficult... that's why I decided to create this repository), we proceed as follows to customize our lexer and parser:

* Write lexing rules into `src/parse/scan.ll`
* Write grammar in `src/parse/parse.yy`
* Interact with parser through the driver, as is shown in `main.cc`
    * Include `driver.hh`
    * Create a Driver object
    * Use one of `parse()` or `parse_file()` functions (read from `stdin` and a file respectively)


Dependencies
------------

* Bison
* Flex
* CMake
* a recent C++ compiler (`g++` or `clang++`)

Acknowledgement
---------------

The repository is born after a spent some time working my way to integrate Bison and Flex into my project. I thought this work could be useful in the futur, when a scanner or parser is needed.
