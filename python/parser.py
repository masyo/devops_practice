# !/bin/python

from sys import exit
from optparse import OptionParser
from texttable import Texttable

LOGFILE = "access_log"
ERROR = "404"
REDIRECT = ("303", "301")
SUCCESS = "200"


class ParserException(Exception):
    """Exception handling."""
    pass


class LogParser():
    """Parse log file and count errors."""

    @staticmethod
    def parse_log(filename):
        """Parse log file and count errors."""
        errors = redirects = oks = 0
        with open(filename) as file:
            for line in file:
                code = line.split()[-4]
                if code == ERROR:
                    errors += 1
                elif code in REDIRECT:
                    redirects += 1
                elif code == SUCCESS:
                    oks += 1
        return errors, redirects, oks

    def render_table(self, filename=LOGFILE):
        """Render summary table."""
        table = Texttable(max_width=0)
        table.set_cols_align(["c", "c", "c"])
        table.set_cols_valign(["m", "m", "m"])
        table.set_chars(['-', '|', '+', '-'])
        table.set_deco(Texttable.VLINES | Texttable.HLINES | Texttable.HEADER)
        table.add_rows([["SUCCESS", "REDIRECTS", "ERRORS"],
                        [str(e) for e in self.parse_log(filename)]])
        return table.draw()

    @staticmethod
    def parse_args():
        """Parse CLI arguments."""
        parser = OptionParser()
        parser.add_option("-f", "--file", dest="filename",
                          help="Target File Name")
        parser.add_option("-t", "--table",
                          dest="table", default=False,
                          action="store_true",
                          help="Format output into ASCII Table")
        return parser.parse_args()


if __name__ == "__main__":
    lprs = LogParser()
    options, args = lprs.parse_args()
    if options.table:
        print(lprs.render_table(options.filename))
    else:
        for event, count in zip(("SUCCESS", "REDIRECTS", "ERRORS"),
                                lprs.parse_log(options.filename)):
            print("{event}: {count}".format(event=event, count=count))
    exit(0)
