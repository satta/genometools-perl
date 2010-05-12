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

package GT::Core::Alphabet;
$gt_alphabet_new = GT->libgt->DeclareSub("gt_alphabet_new", "p",
                                         C::DynaLib::PTR_TYPE, "i", "i", );
$gt_alphabet_new_dna = GT->libgt->DeclareSub("gt_alphabet_new_dna",
                                             C::DynaLib::PTR_TYPE);
$gt_alphabet_new_protein = GT->libgt->DeclareSub("gt_alphabet_new_protein",
                                                 C::DynaLib::PTR_TYPE);
$gt_alphabet_new_empty = GT->libgt->DeclareSub("gt_alphabet_new_empty",
                                               C::DynaLib::PTR_TYPE);
$gt_alphabet_new_from_file = GT->libgt->DeclareSub("gt_alphabet_new_from_file",
                                                   C::DynaLib::PTR_TYPE,
                                                   C::DynaLib::PTR_TYPE,
                                                   C::DynaLib::PTR_TYPE);
$gt_alphabet_ref = GT->libgt->DeclareSub("gt_alphabet_ref", "p",
                                         C::DynaLib::PTR_TYPE,
                                         C::DynaLib::PTR_TYPE);
$gt_alphabet_delete = GT->libgt->DeclareSub("gt_alphabet_delete", "",
                                            C::DynaLib::PTR_TYPE);
$gt_alphabet_num_of_chars = GT->libgt->DeclareSub("gt_alphabet_num_of_chars",
                                                  "I", C::DynaLib::PTR_TYPE);
$gt_alphabet_size = GT->libgt->DeclareSub("gt_alphabet_size", "I",
                                          C::DynaLib::PTR_TYPE);
$gt_alphabet_characters = GT->libgt->DeclareSub("gt_alphabet_characters", "p",
                                                C::DynaLib::PTR_TYPE);
$gt_alphabet_is_protein = GT->libgt->DeclareSub("gt_alphabet_is_protein", "i",
                                                C::DynaLib::PTR_TYPE);
$gt_alphabet_is_dna = GT->libgt->DeclareSub("gt_alphabet_is_dna", "i",
                                            C::DynaLib::PTR_TYPE);
$gt_alphabet_valid_input = GT->libgt->DeclareSub("gt_alphabet_valid_input", "i",
                                                 C::DynaLib::PTR_TYPE, "c");
$gt_alphabet_encode = GT->libgt->DeclareSub("gt_alphabet_encode", "C",
                                            C::DynaLib::PTR_TYPE, "c");
$gt_alphabet_decode = GT->libgt->DeclareSub("gt_alphabet_decode", "c",
                                            C::DynaLib::PTR_TYPE, "C");
$gt_alphabet_decode_seq_to_str = GT->libgt->DeclareSub(
                                                "gt_alphabet_decode_seq_to_str",
                                                C::DynaLib::PTR_TYPE,
                                                C::DynaLib::PTR_TYPE, "p", "L");

sub new_from_ptr {
    my($class, $ptr) = @_;
    my $aptr = &{$gt_alphabet_ref}($ptr);
    my $self = { __PACKAGE__ . ".aptr" => $aptr };
    bless($self, $class);
    return $self;
}

sub new_dna {
    my($class) = @_;
    my $aptr = &{$gt_alphabet_new_dna}();
    my $self = { __PACKAGE__ . ".aptr" => $aptr };
    bless($self, $class);
    return $self;
}

sub new_protein {
    my($class) = @_;
    my $aptr = &{$gt_alphabet_new_protein}();
    my $self = { __PACKAGE__ . ".aptr" => $aptr };
    bless($self, $class);
    return $self;
}

sub new_empty {
    my($class) = @_;
    my $aptr = &{$gt_alphabet_new_empty}();
    my $self = { __PACKAGE__ . ".aptr" => $aptr };
    bless($self, $class);
    return $self;
}

sub num_of_chars {
    my($self) = @_;
    my $retval = &{$gt_alphabet_num_of_chars}($self->{__PACKAGE__ . ".aptr"});
    return $retval;
}

sub size {
    my($self) = @_;
    my $retval = &{$gt_alphabet_size}($self->{__PACKAGE__ . ".aptr"});
    return $retval;
}

sub characters {
    my($self) = @_;
    my $retval = &{$gt_alphabet_characters}($self->{__PACKAGE__ . ".aptr"});
    return $retval;
}

sub is_protein {
    my($self) = @_;
    my $retval = &{$gt_alphabet_is_protein}($self->{__PACKAGE__ . ".aptr"});
    return ($retval != 0);
}

sub is_dna {
    my($self) = @_;
    my $retval = &{$gt_alphabet_is_dna}($self->{__PACKAGE__ . ".aptr"});
    return ($retval != 0);
}

sub valid_input {
    my($self, $inchar) = @_;
    my $retval = &{$gt_alphabet_valid_input}($self->{__PACKAGE__ . ".aptr"},
                                             ord(substr($inchar, 0, 1)));
    return ($retval != 0);
}

sub decode {
    my($self, $inchar) = @_;
    my $val = &{$gt_alphabet_decode}($self->{__PACKAGE__ . ".aptr"}, $inchar);
    return chr($val);
}

sub encode {
    my($self, $inchar) = @_;
    return &{$gt_alphabet_encode}($self->{__PACKAGE__ . ".aptr"},
                                  ord(substr($inchar, 0, 1)));
}

sub decode_seq {
    my($self, $inseq) = @_;
    my $arrptr = pack("C*", @{$inseq});
    my $retval = &{$gt_alphabet_decode_seq_to_str}(
                                                 $self->{__PACKAGE__ . ".aptr"},
                                                 $arrptr, scalar(@{$inseq}));
    return GT::Core::Str->new_from_ptr($retval)->get();
}

sub DESTROY {
    my($self) = @_;
    &{$gt_alphabet_delete}($self->{__PACKAGE__ . ".aptr"});
}

sub to_ptr {
    my($self) = @_;
    return $self->{__PACKAGE__ . ".aptr"};
}
