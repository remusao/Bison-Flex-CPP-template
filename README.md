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

This should produce an executable `parser` at the root of your `bison-flex-template` directory. By default it reads its input from `stdin`:

```sh
$ echo "foo" | ./parser
# 1.1 Unexpected token : f
# 1.2 Unexpected token : o
# 1.3 Unexpected token : o
```

By default, the scanner doesn't recognize any token except `eol` (end of line), and every character read is considered an unknown token, that's why every letter is reported as an error.
We see that location is updated as each line starts with a couple `line.column` to indicate where the current token begins. The three lines are Lexer errors (unrecognised tokens).

Customization
-------------

I won't write a complete explanation on how Bison and Flex work but once you get a program structure that runs well (which can be quite difficult... that's why I decided to create this repository), we proceed as follows to customize our lexer and parser:

* Write scanner `src/parse/scan.ll`, you can declare:
    * Named regex (follow the example of `blank` and `eol`
    * Flex options
    * Stacks to simulate contexts (useful for comments for example)
    * Tokens and associated code, one by line `{blank}  { /* C++ code goes here */ return TOKEN; }` (`TOKEN` will be caught by Bison that will try to match it with the grammar)
* Write parser `src/parse/parse.yy`, you can declare:
    * Tokens (names and types, they will be used both in scan.ll and parse.yy)
    * Bison options
    * Precedance rules
    * Grammar
    * Customize error reporting using the `error()` function
* Interact with parser through the driver, as is shown in `main.cc`
    * Include `driver.hh`
    * Create a `Driver` object
    * Use one of `parse()` or `parse_file()` functions (read from `stdin` and a file respectively)

For more information on how to customize scanner, parser:

* [Flex documentation](http://flex.sourceforge.net/manual/)
* [Bison documentation](http://www.gnu.org/software/bison/manual/)
* [CPP coding style checker written with flex](https://github.com/remusao/CPP_Coding_Style_Checker/)

Dependencies
------------

* Bison
* Flex
* CMake
* a recent C++ compiler (`g++` or `clang++`)

Acknowledgement
---------------

The repository is born after I spent some time working my way to integrate Bison and Flex into my project. I thought this work could be useful in the futur, when a scanner or parser is needed.

As Bison and Flex can be complicated to use, there may be easier alternatives such as Boost spirit that better integrates in `C++` code.
