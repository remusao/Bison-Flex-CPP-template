%{                                                            /* -*- C++ -*- */

#include "parser.hh"
#include "scanpit.hh"
#include "driver.hh"

/*  Defines some macros to update locations */


#define STEP()                                      \
  do {                                              \
    driver.location_->step ();                      \
  } while (0)

#define COL(Col)				    \
  driver.location_->columns (Col)

#define LINE(Line)				    \
  do{						    \
    driver.location_->lines (Line);		    \
 } while (0)

#define YY_USER_ACTION				    \
  COL(yyleng);


typedef parse::Parser::token token;
typedef parse::Parser::token_type token_type;

#define yyterminate() return token::TOK_EOF

%}

%option debug
%option c++
%option noyywrap
%option never-interactive
%option yylineno
%option nounput
%option batch
%option prefix="parse"

/*
%option stack
*/

/* Abbreviations.  */

blank   [ \t]+
eol     [\n\r]+

%%

 /* The rules.  */
%{
  STEP();
%}


{blank}       STEP();

{eol}         LINE(yyleng);

.             {
                std::cerr << *driver.location_ << " Unexpected token : "
                                              << *yytext << std::endl;
                driver.error_ = (driver.error_ == 127 ? 127
                                : driver.error_ + 1);
                STEP ();
              }

%%


/*

   CUSTOM C++ CODE

*/

namespace parse
{

  Scanner::Scanner ()
    : parseFlexLexer ()
  {
  }

  Scanner::~Scanner ()
  {
  }

  void Scanner::set_debug (bool b)
  {
    yy_flex_debug = b;
  }
}

#ifdef yylex
# undef yylex
#endif

int parseFlexLexer::yylex ()
{
  std::cerr << "call parsepitFlexLexer::yylex()!" << std::endl;
  return 0;
}
