#include "driver.hh"
#include "parser.hh"
#include "scanner.hh"

namespace parse
{
    Driver::Driver()
        : scanner_(new Scanner()),
          parser_(new Parser(*this)),
          error_(0)
    {
    }

    Driver::~Driver()
    {
        delete parser_;
        delete scanner_;
    }

    void Driver::reset()
    {
        error_ = 0;
    }

    int Driver::parse()
    {
        scanner_->switch_streams(&std::cin, &std::cerr);
        parser_->parse();
        return error_;
    }

    int Driver::parse_file(std::string &path)
    {
        std::ifstream s(path.c_str(), std::ifstream::in);
        scanner_->switch_streams(&s, &std::cerr);

        parser_->parse();

        s.close();

        return error_;
    }
}
