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
use Time::HiRes;

package GT::Core::Encseq;
$gt_encseq_ref = GT->libgt->DeclareSub("gt_encseq_ref", C::DynaLib::PTR_TYPE,
                                       C::DynaLib::PTR_TYPE);
$gt_encseq_total_length = GT->libgt->DeclareSub("gt_encseq_total_length", "L",
                                                C::DynaLib::PTR_TYPE);
$gt_encseq_num_of_sequences = GT->libgt->DeclareSub(
                                                   "gt_encseq_num_of_sequences",
                                                   "L", C::DynaLib::PTR_TYPE);
$gt_encseq_get_encoded_char = GT->libgt->DeclareSub(
                                                   "gt_encseq_get_encoded_char",
                                                   "C", C::DynaLib::PTR_TYPE,
                                                   "L", "i");
$gt_encseq_extract_substring = GT->libgt->DeclareSub(
                                                  "gt_encseq_extract_substring",
                                                  "", C::DynaLib::PTR_TYPE,
                                                  C::DynaLib::PTR_TYPE,
                                                  "L", "L");
$gt_encseq_extract_decoded = GT->libgt->DeclareSub(
                                                  "gt_encseq_extract_decoded",
                                                  "", C::DynaLib::PTR_TYPE,
                                                  "P",
                                                  "L", "L");
$gt_encseq_seqlength = GT->libgt->DeclareSub("gt_encseq_seqlength", "L",
                                             C::DynaLib::PTR_TYPE, "L");
$gt_encseq_seqstartpos = GT->libgt->DeclareSub("gt_encseq_seqstartpos", "L",
                                               C::DynaLib::PTR_TYPE, "L");
$gt_encseq_description = GT->libgt->DeclareSub("gt_encseq_description",
                                               C::DynaLib::PTR_TYPE,
                                               C::DynaLib::PTR_TYPE,
                                               C::DynaLib::PTR_TYPE, "L");
$gt_encseq_create_reader_with_readmode = GT->libgt->DeclareSub(
                                        "gt_encseq_create_reader_with_readmode",
                                        C::DynaLib::PTR_TYPE,
                                        C::DynaLib::PTR_TYPE, "i", "L");
$gt_encseq_create_reader_with_direction = GT->libgt->DeclareSub(
                                       "gt_encseq_create_reader_with_direction",
                                       C::DynaLib::PTR_TYPE,
                                       C::DynaLib::PTR_TYPE, "i", "L");
$gt_encseq_alphabet = GT->libgt->DeclareSub("gt_encseq_alphabet",
                                            C::DynaLib::PTR_TYPE,
                                            C::DynaLib::PTR_TYPE);
$gt_encseq_filenames = GT->libgt->DeclareSub("gt_encseq_filenames",
                                             C::DynaLib::PTR_TYPE,
                                             C::DynaLib::PTR_TYPE);
$gt_encseq_delete = GT->libgt->DeclareSub("gt_encseq_delete", "",
                                          C::DynaLib::PTR_TYPE);
$gt_malloc = GT->libgt->DeclareSub("gt_malloc_mem", C::DynaLib::PTR_TYPE,
                                   "L", "p", "i" );

$gt_free = GT->libgt->DeclareSub("gt_free_func", C::DynaLib::PTR_TYPE,
                                 C::DynaLib::PTR_TYPE );

sub new_from_ptr {
    my($class, $ptr) = @_;
    my $esptr = $ptr;
    my $self = { "esptr" => $esptr };
    bless($self, $class);
    return $self;
}

sub total_length {
    my($self) = @_;
    my $retval = &{$gt_encseq_total_length}($self->{"esptr"});
    return $retval;
}

sub num_of_sequences {
    my($self) = @_;
    my $retval = &{$gt_encseq_num_of_sequences}($self->{"esptr"});
    return $retval;
}

sub seq_startpos {
    my($self, $seqnum) = @_;
    my $retval = &{$gt_encseq_seqstartpos}($self->{"esptr"},
                                           $seqnum);
    return $retval;
}

sub description {
    # this code is hackish at best...
    my($self, $seqnum) = @_;
    my $length = "\x00" x 8;   # should be enough to hold a 64-bit ulong
    my $ptr = unpack('L!', pack('P', $length));
    my $str = &{$gt_encseq_description}($self->{"esptr"}, $ptr, $seqnum);
    my($a) = unpack("P".unpack("L!", $length), pack("L!", $str));
    return $a;
}

sub seq_length {
    my($self, $seqnum) = @_;
    my $retval = &{$gt_encseq_seqlength}($self->{"esptr"},
                                         $seqnum);
    return $retval;
}

sub get_encoded_char {
    my($self, $pos, $readmode) = @_;
    my $retval = &{$gt_encseq_get_encoded_char}($self->{"esptr"},
                                                $pos, $readmode);
    return $retval;
}

sub seq_encoded {
    my($self, $seqnum, $startpos, $endpos) = @_;
    my $memory = "\x00" x ($endpos-$startpos+1);
    my $ptr = unpack('L!', pack('P', $memory));
    $inseqstart = &{$gt_encseq_seqstartpos}($self->{"esptr"},
                                            $seqnum);
    $inseqlength = &{$gt_encseq_seqlength}($self->{"esptr"},
                                             $seqnum);
    &{$gt_encseq_extract_substring}($self->{"esptr"},
                                    $ptr,
                                    $inseqstart + $startpos,
                                    $inseqstart + $endpos);
    # the next line is a major performance bottleneck!
    my @retval = unpack("C".($endpos-$startpos+1), $memory);
    return \@retval;
}

sub seq_decoded {
    my($self, $seqnum, $startpos, $endpos) = @_;
    my $memory = "\x00" x ($endpos-$startpos+2);
    my $ptr = unpack('L!', pack('P', $memory));
    $inseqstart = &{$gt_encseq_seqstartpos}($self->{"esptr"},
                                            $seqnum);
    $inseqlength = &{$gt_encseq_seqstartpos}($self->{"esptr"},
                                             $seqnum);
    &{$gt_encseq_extract_decoded}($self->{"esptr"},
                                  $ptr,
                                  $inseqstart + $startpos,
                                  $inseqstart + $endpos);
    my ($str) = unpack("P".($endpos-$startpos+1), pack("L!", $ptr));
    return $str;#@retval;
}

sub create_reader_with_readmode {
    my($self, $readmode, $pos) = @_;
    my $retval = &{$gt_encseq_create_reader_with_readmode}(
                                                $self->{"esptr"},
                                                $readmode, $pos);
    return GT::Core::EncseqReader->new_from_ptr($retval);
}

sub create_reader_with_direction {
    my($self, $direction, $pos) = @_;
    if ($direction != 0) {
      $direction = 1;
    }
    my $retval = &{$gt_encseq_create_reader_with_direction}(
                                                $self->{"esptr"},
                                                $direction, $pos);
    return GT::Core::EncseqReader->new_from_ptr($retval);
}

sub DESTROY {
    my($self) = @_;
    &{$gt_encseq_delete}($self->{"esptr"});;
}

sub to_ptr {
    my($self) = @_;
    return $self->{"esptr"};
    return $self->{"esptr"};
}
