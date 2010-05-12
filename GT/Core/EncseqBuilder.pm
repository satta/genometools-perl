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
use GT::Core::Encseq;
use GT::Core::Error;
use GT::Core::Readmode;
use sigtrap;

package GT::Core::EncseqBuilder;
$gt_encseq_builder_new = GT->libgt->DeclareSub("gt_encseq_builder_new",
                                               C::DynaLib::PTR_TYPE,
                                               C::DynaLib::PTR_TYPE);
$gt_encseq_builder_enable_description_support = GT->libgt->DeclareSub(
                                 "gt_encseq_builder_enable_description_support",
                                 "", C::DynaLib::PTR_TYPE);
$gt_encseq_builder_drop_description_support = GT->libgt->DeclareSub(
                                   "gt_encseq_builder_drop_description_support",
                                   "", C::DynaLib::PTR_TYPE);
$gt_encseq_builder_enable_multiseq_support = GT->libgt->DeclareSub(
                                    "gt_encseq_builder_enable_multiseq_support",
                                    "", C::DynaLib::PTR_TYPE);
$gt_encseq_builder_drop_multiseq_support = GT->libgt->DeclareSub(
                                      "gt_encseq_builder_drop_multiseq_support",
                                      "", C::DynaLib::PTR_TYPE);
$gt_encseq_builder_enable_tis_tab = GT->libgt->DeclareSub(
                                             "gt_encseq_builder_enable_tis_tab",
                                             "", C::DynaLib::PTR_TYPE);
$gt_encseq_builder_disable_tis_tab = GT->libgt->DeclareSub(
                                            "gt_encseq_builder_disable_tis_tab",
                                            "", C::DynaLib::PTR_TYPE);
$gt_encseq_builder_enable_des_tab = GT->libgt->DeclareSub(
                                             "gt_encseq_builder_enable_des_tab",
                                             "", C::DynaLib::PTR_TYPE);
$gt_encseq_builder_disable_des_tab = GT->libgt->DeclareSub(
                                            "gt_encseq_builder_disable_des_tab",
                                            "", C::DynaLib::PTR_TYPE);
$gt_encseq_builder_enable_ssp_tab = GT->libgt->DeclareSub(
                                             "gt_encseq_builder_enable_ssp_tab",
                                             "", C::DynaLib::PTR_TYPE);
$gt_encseq_builder_disable_ssp_tab = GT->libgt->DeclareSub(
                                            "gt_encseq_builder_disable_ssp_tab",
                                            "", C::DynaLib::PTR_TYPE);
$gt_encseq_builder_enable_sds_tab = GT->libgt->DeclareSub(
                                             "gt_encseq_builder_enable_sds_tab",
                                             "", C::DynaLib::PTR_TYPE);
$gt_encseq_builder_disable_sds_tab = GT->libgt->DeclareSub(
                                            "gt_encseq_builder_disable_sds_tab",
                                            "", C::DynaLib::PTR_TYPE);
$gt_encseq_builder_build = GT->libgt->DeclareSub("gt_encseq_builder_build", "i",
                                                 C::DynaLib::PTR_TYPE,
                                                 C::DynaLib::PTR_TYPE);
$gt_encseq_builder_add_cstr = GT->libgt->DeclareSub(
                                                   "gt_encseq_builder_add_cstr",
                                                   "",
                                                   C::DynaLib::PTR_TYPE,
                                                   "P",
                                                   "L", "P");
$gt_encseq_builder_add_encoded = GT->libgt->DeclareSub(
                                                "gt_encseq_builder_add_encoded",
                                                "",
                                                C::DynaLib::PTR_TYPE,
                                                C::DynaLib::PTR_TYPE,
                                                "L", "p");
$gt_encseq_builder_delete = GT->libgt->DeclareSub("gt_encseq_builder_delete",
                                                  "",
                                                  C::DynaLib::PTR_TYPE);                                                 

sub new {
    my($class, $alpha) = @_;
    my $ebptr = &{$gt_encseq_builder_new}($alpha->to_ptr());
    my $self = { __PACKAGE__ . ".ebptr" => $ebptr };
    bless($self, $class);
    return $self;
}

sub enable_description_support {
    my($self) = @_;
    &{$gt_encseq_builder_enable_description_support}(
                                               $self->{__PACKAGE__ . ".ebptr"});
}

sub disable_description_support {
    my($self) = @_;
    &{$gt_encseq_builder_disable_description_support}(
                                               $self->{__PACKAGE__ . ".ebptr"});
}

sub enable_multiseq_support {
    my($self) = @_;
    &{$gt_encseq_builder_enable_multiseq_support}(
                                               $self->{__PACKAGE__ . ".ebptr"});
}

sub disable_multiseq_support {
    my($self) = @_;
    &{$gt_encseq_builder_disable_multiseq_support}(
                                               $self->{__PACKAGE__ . ".ebptr"});
}

sub create_tis_tab {
    my($self) = @_;
    &{$gt_encseq_builder_create_tis_tab}($self->{__PACKAGE__ . ".ebptr"});
}

sub do_not_create_tis_tab {
    my($self) = @_;
    &{$gt_encseq_builder_do_not_create_tis_tab}(
                                               $self->{__PACKAGE__ . ".ebptr"});
}

sub create_des_tab {
    my($self) = @_;
    &{$gt_encseq_builder_create_des_tab}($self->{__PACKAGE__ . ".ebptr"});
}

sub do_not_create_des_tab {
    my($self) = @_;
    &{$gt_encseq_builder_do_not_create_des_tab}(
                                               $self->{__PACKAGE__ . ".ebptr"});
}

sub create_ssp_tab {
    my($self) = @_;
    &{$gt_encseq_builder_create_ssp_tab}($self->{__PACKAGE__ . ".ebptr"});
}

sub do_not_create_ssp_tab {
    my($self) = @_;
    &{$gt_encseq_builder_do_not_create_ssp_tab}(
                                               $self->{__PACKAGE__ . ".ebptr"});
}

sub create_sds_tab {
    my($self) = @_;
    &{$gt_encseq_builder_create_sds_tab}($self->{__PACKAGE__ . ".ebptr"});
}

sub do_not_create_sds_tab {
    my($self) = @_;
    &{$gt_encseq_builder_do_not_create_sds_tab}(
                                               $self->{__PACKAGE__ . ".ebptr"});
}

sub add_str {
    my($self, $str, $desc) = @_;
    &{$gt_encseq_builder_add_cstr}($self->{__PACKAGE__ . ".ebptr"},
                                   $str,
                                   length($str),
                                   $desc);
}

sub build {
    my($self, $err) = @_;
    my $retval = &{$gt_encseq_builder_build}($self->{__PACKAGE__ . ".ebptr"},
                                             $err->to_ptr());
    if (!$retval) {
      return NULL;
    } else {
      return GT::Core::Encseq->new_from_ptr($retval);
    }
}

sub reset {
    my($self) = @_;
    &{$gt_encseq_builder_reset}($self->{__PACKAGE__ . ".ebptr"});
}

sub DESTROY {
    my($self) = @_;
    &{$gt_encseq_builder_delete}($self->{__PACKAGE__ . ".ebptr"});
}
