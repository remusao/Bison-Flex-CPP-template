%{     /* PARSER */

#include "parser.hh"
#include "scanner.hh"

#define yylex driver.scanner_->yylex
%}

%code requires
{
  #include <iostream>
  #include "driver.hh"
  #include "location.hh"
  #include "position.hh"
}

%code provides
{
  namespace parse
  {
    // Forward declaration of the Driver class
    class Driver;

    inline void
    yyerror (const char* msg)
    {
      std::cerr << msg << std::endl;
    }
  }
}



%require "2.4"
%language "C++"
%locations
%defines
%debug
%define api.namespace {parse}
%define api.parser.class {Parser}
%parse-param {Driver &driver}
%lex-param {Driver &driver}
%define parse.error verbose

%union
{
 /* YYLTYPE */
}

/* Tokens */
%token TOK_EOF 0

/* Entry point of grammar */
%start start

%%

start:
     /* empty */
;



%%

namespace parse
{
    void Parser::error(const location& l, const std::string& m)
    {
        std::cerr << l << ": " << m << std::endl;
        driver.error_ = (driver.error_ == 127 ? 127 : driver.error_ + 1);
    }
}
