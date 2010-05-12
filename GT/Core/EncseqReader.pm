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
use GT::Core::Readmode;
use sigtrap;

package GT::Core::EncseqReader;
$gt_encseq_reader_reinit_with_readmode = GT->libgt->DeclareSub(
                                        "gt_encseq_reader_reinit_with_readmode",
                                        "",
                                        C::DynaLib::PTR_TYPE,
                                        C::DynaLib::PTR_TYPE,
                                        "i", "L");
$gt_encseq_reader_reinit_with_direction = GT->libgt->DeclareSub(
                                       "gt_encseq_reader_reinit_with_direction",
                                       "",
                                       C::DynaLib::PTR_TYPE,
                                       C::DynaLib::PTR_TYPE,
                                       "i", "L");
$gt_encseq_reader_next_encoded_char = GT->libgt->DeclareSub(
                                           "gt_encseq_reader_next_encoded_char",
                                           "C",
                                           C::DynaLib::PTR_TYPE);
$gt_encseq_reader_delete = GT->libgt->DeclareSub("gt_encseq_reader_delete",
                                                  "",
                                                  C::DynaLib::PTR_TYPE);

sub new_from_ptr {
    my($class, $ptr) = @_;
    my $self = { "erptr" => $ptr };
    bless($self, $class);
    return $self;
}

sub reinit_with_direction {
   my($self, $es, $direction, $startpos) = @_;
   if ($direction != 0) {
     $direction = 1;
   }
   &{$gt_encseq_reader_reinit_with_direction}($self->{"erptr"},
                                              $es->to_ptr(),
                                              $direction,
                                              $startpos);
}

sub reinit_with_readmode {
   my($self, $es, $readmode, $startpos) = @_;
   &{$gt_encseq_reader_reinit_with_direction}($self->{"erptr"},
                                              $es->to_ptr(),
                                              $readmode,
                                              $startpos);
}

sub next_encoded_char {
  return &{$gt_encseq_reader_next_encoded_char}(@_[0]->{"erptr"});
}

sub DESTROY {
    &{$gt_encseq_reader_delete}(@_[0]->{"erptr"});
}
