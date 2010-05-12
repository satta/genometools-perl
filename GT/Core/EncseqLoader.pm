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
use GT::Core::Str;
use sigtrap;

package GT::Core::EncseqLoader;
$gt_encseq_loader_new = GT->libgt->DeclareSub("gt_encseq_loader_new",
                                              C::DynaLib::PTR_TYPE);
$gt_encseq_loader_require_description_support = GT->libgt->DeclareSub(
                                 "gt_encseq_loader_require_description_support",
                                 "", C::DynaLib::PTR_TYPE);
$gt_encseq_loader_drop_description_support = GT->libgt->DeclareSub(
                                    "gt_encseq_loader_drop_description_support",
                                    "", C::DynaLib::PTR_TYPE);
$gt_encseq_loader_require_multiseq_support = GT->libgt->DeclareSub(
                                    "gt_encseq_loader_require_multiseq_support",
                                    "", C::DynaLib::PTR_TYPE);
$gt_encseq_loader_drop_multiseq_support = GT->libgt->DeclareSub(
                                       "gt_encseq_loader_drop_multiseq_support",
                                       "", C::DynaLib::PTR_TYPE);
$gt_encseq_loader_require_tis_tab = GT->libgt->DeclareSub(
                                             "gt_encseq_loader_require_tis_tab",
                                             "", C::DynaLib::PTR_TYPE);
$gt_encseq_loader_do_not_require_tis_tab = GT->libgt->DeclareSub(
                                      "gt_encseq_loader_do_not_require_tis_tab",
                                      "", C::DynaLib::PTR_TYPE);
$gt_encseq_loader_require_des_tab = GT->libgt->DeclareSub(
                                             "gt_encseq_loader_require_des_tab",
                                             "", C::DynaLib::PTR_TYPE);
$gt_encseq_loader_do_not_require_des_tab = GT->libgt->DeclareSub(
                                      "gt_encseq_loader_do_not_require_des_tab",
                                      "", C::DynaLib::PTR_TYPE);
$gt_encseq_loader_require_ssp_tab = GT->libgt->DeclareSub(
                                             "gt_encseq_loader_require_ssp_tab",
                                             "", C::DynaLib::PTR_TYPE);
$gt_encseq_loader_do_not_require_ssp_tab = GT->libgt->DeclareSub(
                                      "gt_encseq_loader_do_not_require_ssp_tab",
                                      "", C::DynaLib::PTR_TYPE);
$gt_encseq_loader_require_sds_tab = GT->libgt->DeclareSub(
                                             "gt_encseq_loader_require_sds_tab",
                                             "", C::DynaLib::PTR_TYPE);
$gt_encseq_loader_do_not_require_sds_tab = GT->libgt->DeclareSub(
                                      "gt_encseq_loader_do_not_require_sds_tab",
                                      "", C::DynaLib::PTR_TYPE);
$gt_encseq_loader_enable_range_iterator = GT->libgt->DeclareSub(
                                       "gt_encseq_loader_enable_range_iterator",
                                       "", C::DynaLib::PTR_TYPE);
$gt_encseq_loader_disable_range_iterator = GT->libgt->DeclareSub(
                                      "gt_encseq_loader_disable_range_iterator",
                                      "", C::DynaLib::PTR_TYPE);
$gt_encseq_loader_load = GT->libgt->DeclareSub("gt_encseq_loader_load",
                                               C::DynaLib::PTR_TYPE,
                                               C::DynaLib::PTR_TYPE,
                                               C::DynaLib::PTR_TYPE,
                                               C::DynaLib::PTR_TYPE);
$gt_encseq_loader_delete = GT->libgt->DeclareSub("gt_encseq_loader_delete", "",
                                                 C::DynaLib::PTR_TYPE);

sub new {
    my($class, $ptr) = @_;
    my $elptr = &{$gt_encseq_loader_new}($ptr);
    my $self = { __PACKAGE__ . ".elptr" => $elptr,
                 __PACKAGE__ . ".destab" => 1,
                 __PACKAGE__ . ".ssptab" => 1,
                 __PACKAGE__ . ".sdstab" => 1 };
    bless($self, $class);
    return $self;
}

sub require_description_support {
    my($self) = @_;
    &{$gt_encseq_loader_require_description_support}(
                                               $self->{__PACKAGE__ . ".elptr"});
}

sub do_not_require_description_support {
    my($self) = @_;
    &{$gt_encseq_loader_do_not_require_description_support}(
                                               $self->{__PACKAGE__ . ".elptr"});
}

sub require_multiseq_support {
    my($self) = @_;
    &{$gt_encseq_loader_require_multiseq_support}(
                                               $self->{__PACKAGE__ . ".elptr"});
}

sub do_not_require_multiseq_support {
    my($self) = @_;
    &{$gt_encseq_loader_do_not_require_multiseq_support}(
                                               $self->{__PACKAGE__ . ".elptr"});
}

sub require_tis_tab {
    my($self) = @_;
    &{$gt_encseq_loader_require_tis_tab}($self->{__PACKAGE__ . ".elptr"});
}

sub do_not_require_tis_tab {
    my($self) = @_;
    &{$gt_encseq_loader_do_not_require_tis_tab}(
                                               $self->{__PACKAGE__ . ".elptr"});
}

sub require_des_tab {
    my($self) = @_;
    &{$gt_encseq_loader_require_des_tab}($self->{__PACKAGE__ . ".elptr"});
}

sub do_not_require_des_tab {
    my($self) = @_;
    &{$gt_encseq_loader_do_not_require_des_tab}(
                                               $self->{__PACKAGE__ . ".elptr"});
}

sub require_ssp_tab {
    my($self) = @_;
    &{$gt_encseq_loader_require_ssp_tab}($self->{__PACKAGE__ . ".elptr"});
}

sub do_not_require_ssp_tab {
    my($self) = @_;
    &{$gt_encseq_loader_do_not_require_ssp_tab}(
                                               $self->{__PACKAGE__ . ".elptr"});
}

sub require_sds_tab {
    my($self) = @_;
    &{$gt_encseq_loader_require_sds_tab}($self->{__PACKAGE__ . ".elptr"});
}

sub do_not_require_sds_tab {
    my($self) = @_;
    &{$gt_encseq_loader_do_not_require_sds_tab}(
                                               $self->{__PACKAGE__ . ".elptr"});
}

sub enable_range_iterator {
    my($self) = @_;
    &{$gt_encseq_loader_enable_range_iterator}($self->{__PACKAGE__ . ".elptr"});
}

sub disable_range_iterator {
    my($self) = @_;
    &{$gt_encseq_loader_disable_range_iterator}($self->{__PACKAGE__ . ".elptr"});
}

sub load {
    # check for presence of required tables
    my($self, $indexname, $err) = @_;
    my $indexnamestr = GT::Core::Str->new($indexname);
    my $retval = &{$gt_encseq_loader_load}($self->{__PACKAGE__ . ".elptr"},
                                           $indexnamestr->to_ptr(),
                                           $err->to_ptr());
    if (!$retval) {
      return NULL;
    } else {
      return GT::Core::Encseq->new_from_ptr($retval);
    }
}

sub DESTROY {
    my($self) = @_;
    &{$gt_encseq_loader_delete}($self->{__PACKAGE__ . ".elptr"});
}
