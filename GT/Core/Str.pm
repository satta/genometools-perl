#!/usr/bin/perl -w
#
# Copyright (c) 2010 Sascha Steinbiss <steinbiss@zbh.uni-hamburg.de>
# Copyright (c) 2010 Center for Bioinformatics, University of Hamburg
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
#

use GT;
use C::DynaLib;
use sigtrap;

package GT::Core::Str;
$gt_str_get = GT->libgt->DeclareSub("gt_str_get", "p", C::DynaLib::PTR_TYPE);
$gt_str_ref = GT->libgt->DeclareSub("gt_str_ref", C::DynaLib::PTR_TYPE,
                                    C::DynaLib::PTR_TYPE);
$gt_str_delete = GT->libgt->DeclareSub("gt_str_delete", "",
                                       C::DynaLib::PTR_TYPE);
$gt_str_new = GT->libgt->DeclareSub("gt_str_new_cstr", C::DynaLib::PTR_TYPE,
                                    "p");

sub new_from_ptr {
    my($class, $ptr) = @_;
    my $strptr = &{$gt_str_ref}($ptr);
    my $self = { __PACKAGE__ . ".strptr" => $strptr };
    bless($self, $class);
    return $self;
}

sub new {
    my($class, $str) = @_;
    my $strptr = &{$gt_str_new}($str);
    my $self = { __PACKAGE__ . ".strptr" => $strptr };
    bless($self, $class);
    return $self;
}

sub get {
    my($self) = @_;
    my $retval = &{$gt_str_get}($self->{__PACKAGE__ . ".strptr"});
    return $retval;
}

sub DESTROY {
    my($self) = @_;
    &{$gt_str_delete}($self->{__PACKAGE__ . ".strptr"});;
}

sub to_ptr {
    my($self) = @_;
    return $self->{__PACKAGE__ . ".strptr"};
}
