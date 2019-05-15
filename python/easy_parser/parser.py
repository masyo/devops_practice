#!/bin/python

from sys import exit

LOGFILE="access_log"
ERROR="404"
REDIRECTT=("303","301")
SUCCESS="200"

def parse_log(filename):
    '''Parse log file and count errors'''
    errors=redirects=oks=0
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

if __name__ == "__main__":
    print(parse_log(LOGFILE))
    exit(0)