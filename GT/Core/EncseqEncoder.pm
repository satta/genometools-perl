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
use GT::Core::StrArray;
use sigtrap;

package GT::Core::EncseqEncoder;
$gt_encseq_encoder_new = GT->libgt->DeclareSub("gt_encseq_encoder_new",
                                              C::DynaLib::PTR_TYPE);
$gt_encseq_encoder_enable_description_support = GT->libgt->DeclareSub(
                                 "gt_encseq_encoder_enable_description_support",
                                 "", C::DynaLib::PTR_TYPE);
$gt_encseq_encoder_drop_description_support = GT->libgt->DeclareSub(
                                    "gt_encseq_encoder_drop_description_support",
                                    "", C::DynaLib::PTR_TYPE);
$gt_encseq_encoder_enable_multiseq_support = GT->libgt->DeclareSub(
                                    "gt_encseq_encoder_enable_multiseq_support",
                                    "", C::DynaLib::PTR_TYPE);
$gt_encseq_encoder_drop_multiseq_support = GT->libgt->DeclareSub(
                                       "gt_encseq_encoder_drop_multiseq_support",
                                       "", C::DynaLib::PTR_TYPE);
$gt_encseq_encoder_enable_tis_tab = GT->libgt->DeclareSub(
                                             "gt_encseq_encoder_enable_tis_tab",
                                             "", C::DynaLib::PTR_TYPE);
$gt_encseq_encoder_disable_tis_tab = GT->libgt->DeclareSub(
                                      "gt_encseq_encoder_disable_tis_tab",
                                      "", C::DynaLib::PTR_TYPE);
$gt_encseq_encoder_enable_des_tab = GT->libgt->DeclareSub(
                                             "gt_encseq_encoder_enable_des_tab",
                                             "", C::DynaLib::PTR_TYPE);
$gt_encseq_encoder_disable_des_tab = GT->libgt->DeclareSub(
                                      "gt_encseq_encoder_disable_des_tab",
                                      "", C::DynaLib::PTR_TYPE);
$gt_encseq_encoder_enable_ssp_tab = GT->libgt->DeclareSub(
                                             "gt_encseq_encoder_enable_ssp_tab",
                                             "", C::DynaLib::PTR_TYPE);
$gt_encseq_encoder_disable_ssp_tab = GT->libgt->DeclareSub(
                                      "gt_encseq_encoder_disable_ssp_tab",
                                      "", C::DynaLib::PTR_TYPE);
$gt_encseq_encoder_enable_sds_tab = GT->libgt->DeclareSub(
                                             "gt_encseq_encoder_enable_sds_tab",
                                             "", C::DynaLib::PTR_TYPE);
$gt_encseq_encoder_disable_sds_tab = GT->libgt->DeclareSub(
                                      "gt_encseq_encoder_disable_sds_tab",
                                      "", C::DynaLib::PTR_TYPE);
$gt_encseq_encoder_use_representation = GT->libgt->DeclareSub(
                                         "gt_encseq_encoder_use_representation",
                                         "i", C::DynaLib::PTR_TYPE,
                                         C::DynaLib::PTR_TYPE,
                                         C::DynaLib::PTR_TYPE);
$gt_encseq_encoder_use_symbolmap_file = GT->libgt->DeclareSub(
                                         "gt_encseq_encoder_use_symbolmap_file",
                                         "i", C::DynaLib::PTR_TYPE,
                                         C::DynaLib::PTR_TYPE,
                                         C::DynaLib::PTR_TYPE);
$gt_encseq_encoder_encode = GT->libgt->DeclareSub("gt_encseq_encoder_encode", "i",
                                               C::DynaLib::PTR_TYPE,
                                               C::DynaLib::PTR_TYPE,
                                               C::DynaLib::PTR_TYPE,
                                               C::DynaLib::PTR_TYPE);
$gt_encseq_encoder_delete = GT->libgt->DeclareSub("gt_encseq_encoder_delete", "",
                                                 C::DynaLib::PTR_TYPE);

sub new {
    my($class, $ptr) = @_;
    my $eeptr = &{$gt_encseq_encoder_new}($ptr);
    my $self = { __PACKAGE__ . ".eeptr" => $eeptr };
    bless($self, $class);
    return $self;
}

sub enable_description_support {
    my($self) = @_;
    &{$gt_encseq_encoder_enable_description_support}(
                                               $self->{__PACKAGE__ . ".eeptr"});
}

sub disable_description_support {
    my($self) = @_;
    &{$gt_encseq_encoder_disable_description_support}(
                                               $self->{__PACKAGE__ . ".eeptr"});
}

sub enable_multiseq_support {
    my($self) = @_;
    &{$gt_encseq_encoder_enable_multiseq_support}(
                                               $self->{__PACKAGE__ . ".eeptr"});
}

sub disable_multiseq_support {
    my($self) = @_;
    &{$gt_encseq_encoder_disable_multiseq_support}(
                                               $self->{__PACKAGE__ . ".eeptr"});
}

sub create_tis_tab {
    my($self) = @_;
    &{$gt_encseq_encoder_create_tis_tab}($self->{__PACKAGE__ . ".eeptr"});
}

sub do_not_create_tis_tab {
    my($self) = @_;
    &{$gt_encseq_encoder_do_not_create_tis_tab}(
                                               $self->{__PACKAGE__ . ".eeptr"});
}

sub create_des_tab {
    my($self) = @_;
    &{$gt_encseq_encoder_create_des_tab}($self->{__PACKAGE__ . ".eeptr"});
}

sub do_not_create_des_tab {
    my($self) = @_;
    &{$gt_encseq_encoder_do_not_create_des_tab}(
                                               $self->{__PACKAGE__ . ".eeptr"});
}

sub create_ssp_tab {
    my($self) = @_;
    &{$gt_encseq_encoder_create_ssp_tab}($self->{__PACKAGE__ . ".eeptr"});
}

sub do_not_create_ssp_tab {
    my($self) = @_;
    &{$gt_encseq_encoder_do_not_create_ssp_tab}(
                                               $self->{__PACKAGE__ . ".eeptr"});
}

sub create_sds_tab {
    my($self) = @_;
    &{$gt_encseq_encoder_create_sds_tab}($self->{__PACKAGE__ . ".eeptr"});
}

sub do_not_create_sds_tab {
    my($self) = @_;
    &{$gt_encseq_encoder_do_not_create_sds_tab}(
                                               $self->{__PACKAGE__ . ".eeptr"});
}

sub encode {
    my($self, $files, $indexname, $err) = @_;
    my $indexnamestr = GT::Core::Str->new($indexname);
    my $filessa = GT::Core::StrArray->new();
    foreach (@{$files}) {
      $filessa->add($_);
    }
    my $retval = &{$gt_encseq_encoder_encode}($self->{__PACKAGE__ . ".eeptr"},
                                              $filessa->to_ptr(),
                                              $indexnamestr->to_ptr(),
                                              $err->to_ptr());
    return $retval;
}

sub DESTROY {
    my($self) = @_;
    &{$gt_encseq_encoder_delete}($self->{__PACKAGE__ . ".eeptr"});
}
