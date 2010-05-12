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

package GT::Core::Error;
$gt_error_new = GT->libgt->DeclareSub("gt_error_new", C::DynaLib::PTR_TYPE);
$gt_error_ref = GT->libgt->DeclareSub("gt_error_ref", C::DynaLib::PTR_TYPE,
                                      C::DynaLib::PTR_TYPE);
$gt_error_get = GT->libgt->DeclareSub("gt_error_get", "p",
                                      C::DynaLib::PTR_TYPE);
$gt_error_is_set = GT->libgt->DeclareSub("gt_error_is_set", "i",
                                         C::DynaLib::PTR_TYPE);
$gt_error_set_nonvariadic = GT->libgt->DeclareSub("gt_error_set_nonvariadic",
                                                  "", C::DynaLib::PTR_TYPE,
                                                  "p");
$gt_error_get = GT->libgt->DeclareSub("gt_error_get", "p",
                                      C::DynaLib::PTR_TYPE);
$gt_error_unset = GT->libgt->DeclareSub("gt_error_unset", "",
                                        C::DynaLib::PTR_TYPE);
$gt_error_delete = GT->libgt->DeclareSub("gt_error_delete", "",
                                         C::DynaLib::PTR_TYPE);

sub new_from_ptr {
    my($class, $ptr) = @_;
    my $errptr = &{$gt_error_ref}($ptr);
    my $self = { __PACKAGE__ . ".errptr" => $errptr };
    bless($self, $class);
    return $self;
}

sub new {
    my($class, $str) = @_;
    my $errptr = &{$gt_error_new}($str);
    my $self = { __PACKAGE__ . ".errptr" => $errptr };
    bless($self, $class);
    return $self;
}

sub get {
    my($self) = @_;
    my $retval = &{$gt_error_get}($self->{__PACKAGE__ . ".errptr"});
    return $retval;
}

sub set {
    my($self, $errmsg) = @_;
    &{$gt_error_set_nonvariadic}($self->{__PACKAGE__ . ".errptr"}, $errmsg);
}

sub is_set {
    my($self) = @_;
    my $retval = &{$gt_error_is_set}($self->{__PACKAGE__ . ".errptr"});
    return ($retval != 0);
}

sub unset {
    my($self) = @_;
    &{$gt_error_unset}($self->{__PACKAGE__ . ".errptr"});
}

sub DESTROY {
    my($self) = @_;
    &{$gt_error_delete}($self->{__PACKAGE__ . ".errptr"});
}

sub to_ptr {
    my($self) = @_;
    return $self->{__PACKAGE__ . ".errptr"};
}
