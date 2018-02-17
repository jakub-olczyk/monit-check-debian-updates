#!/usr/bin/perl
# Copyright 2018 Jakub Olczyk <jakub.olczyk@openmailbox.org>
#
# Permission to use, copy, modify, and distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

use strict;
use warnings;

use Getopt::Long;

my %EXITCODES = (
    CRITICAL => 9000, # over9k - for critical problems with packages
    NORMAL => 0, # report normal number of packages for update
    ERROR => 1_000_000, # for problems with the script
);

my $CMD_APT = "/usr/bin/apt-get -s upgrade";

#-- main logic of the program --#
my $ret = check_for_updates();
print "APT: $ret\n";
exit $ret;

#-- subs for the logic --#

sub check_for_updates {
    my ($pkg,$ver,$release);

    my $pkg_count = 0;

    open APT, "$CMD_APT 2>&1|";
    while(<APT>){ 
        ($pkg,$ver,$release) = /Inst (.*?) .*\((.*?) (.*?)\)/;  
        if ($pkg){
            $pkg_count++;
        }
    }
    close APT;
    return $pkg_count;
}
