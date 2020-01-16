################################################################################
#
#            !!!!!   Do NOT edit this file directly!   !!!!!
#
#            Edit mktests.PL and/or parts/inc/misc instead.
#
#  This file was automatically generated from the definition files in the
#  parts/inc/ subdirectory by mktests.PL. To learn more about how all this
#  works, please read the F<HACKERS> file that came with this distribution.
#
################################################################################

BEGIN {
  if ($ENV{'PERL_CORE'}) {
    chdir 't' if -d 't';
    @INC = ('../lib', '../ext/Devel-PPPort/t') if -d '../lib' && -d '../ext';
    require Config; import Config;
    use vars '%Config';
    if (" $Config{'extensions'} " !~ m[ Devel/PPPort ]) {
      print "1..0 # Skip -- Perl configured without Devel::PPPort module\n";
      exit 0;
    }
  }
  else {
    unshift @INC, 't';
  }

  sub load {
    eval "use Test";
    require 'testutil.pl' if $@;
  }

  if (128) {
    load();
    plan(tests => 128);
  }
}

use Devel::PPPort;
use strict;
$^W = 1;

package Devel::PPPort;
use vars '@ISA';
require DynaLoader;
@ISA = qw(DynaLoader);
bootstrap Devel::PPPort;

package main;

use vars qw($my_sv @my_av %my_hv);

ok(&Devel::PPPort::boolSV(1));
ok(!&Devel::PPPort::boolSV(0));

$_ = "Fred";
ok(&Devel::PPPort::DEFSV(), "Fred");
ok(&Devel::PPPort::UNDERBAR(), "Fred");

if ("$]" >= 5.009002 && "$]" < 5.023 && "$]" < 5.023004) {
  eval q{
    no warnings "deprecated";
    no if $^V > v5.17.9, warnings => "experimental::lexical_topic";
    my $_ = "Tony";
    ok(&Devel::PPPort::DEFSV(), "Fred");
    ok(&Devel::PPPort::UNDERBAR(), "Tony");
  };
}
else {
  ok(1);
  ok(1);
}

my @r = &Devel::PPPort::DEFSV_modify();

ok(@r == 3);
ok($r[0], 'Fred');
ok($r[1], 'DEFSV');
ok($r[2], 'Fred');

ok(&Devel::PPPort::DEFSV(), "Fred");

eval { 1 };
ok(!&Devel::PPPort::ERRSV());
eval { cannot_call_this_one() };
ok(&Devel::PPPort::ERRSV());

ok(&Devel::PPPort::gv_stashpvn('Devel::PPPort', 0));
ok(!&Devel::PPPort::gv_stashpvn('does::not::exist', 0));
ok(&Devel::PPPort::gv_stashpvn('does::not::exist', 1));

$my_sv = 1;
ok(&Devel::PPPort::get_sv('my_sv', 0));
ok(!&Devel::PPPort::get_sv('not_my_sv', 0));
ok(&Devel::PPPort::get_sv('not_my_sv', 1));

@my_av = (1);
ok(&Devel::PPPort::get_av('my_av', 0));
ok(!&Devel::PPPort::get_av('not_my_av', 0));
ok(&Devel::PPPort::get_av('not_my_av', 1));

%my_hv = (a=>1);
ok(&Devel::PPPort::get_hv('my_hv', 0));
ok(!&Devel::PPPort::get_hv('not_my_hv', 0));
ok(&Devel::PPPort::get_hv('not_my_hv', 1));

sub my_cv { 1 };
ok(&Devel::PPPort::get_cv('my_cv', 0));
ok(!&Devel::PPPort::get_cv('not_my_cv', 0));
ok(&Devel::PPPort::get_cv('not_my_cv', 1));

ok(Devel::PPPort::dXSTARG(42), 43);
ok(Devel::PPPort::dAXMARK(4711), 4710);

ok(Devel::PPPort::prepush(), 42);

ok(join(':', Devel::PPPort::xsreturn(0)), 'test1');
ok(join(':', Devel::PPPort::xsreturn(1)), 'test1:test2');

ok(Devel::PPPort::PERL_ABS(42), 42);
ok(Devel::PPPort::PERL_ABS(-13), 13);

ok(Devel::PPPort::SVf(42), "$]" >= 5.004 ? '[42]' : '42');
ok(Devel::PPPort::SVf('abc'), "$]" >= 5.004 ? '[abc]' : 'abc');

ok(&Devel::PPPort::Perl_ppaddr_t("FOO"), "foo");

ok(&Devel::PPPort::ptrtests(), 63);

ok(&Devel::PPPort::OpSIBLING_tests(), 0);

if ("$]" >= 5.009000) {
  eval q{
    ok(&Devel::PPPort::check_HeUTF8("hello"), "norm");
    ok(&Devel::PPPort::check_HeUTF8("\N{U+263a}"), "utf8");
  };
} else {
  ok(1, 1);
  ok(1, 1);
}

@r = &Devel::PPPort::check_c_array();
ok($r[0], 4);
ok($r[1], "13");

ok(!Devel::PPPort::SvRXOK(""));
ok(!Devel::PPPort::SvRXOK(bless [], "Regexp"));

if ("$]" < 5.005) {
        skip 'no qr// objects in this perl', 0;
        skip 'no qr// objects in this perl', 0;
} else {
        my $qr = eval 'qr/./';
        ok(Devel::PPPort::SvRXOK($qr));
        ok(Devel::PPPort::SvRXOK(bless $qr, "Surprise"));
}

ok(  Devel::PPPort::test_isBLANK(ord(" ")));
ok(! Devel::PPPort::test_isBLANK(ord("\n")));

ok(  Devel::PPPort::test_isBLANK_A(ord("\t")));
ok(! Devel::PPPort::test_isBLANK_A(ord("\r")));

ok(  Devel::PPPort::test_isUPPER(ord("A")));
ok(! Devel::PPPort::test_isUPPER(ord("a")));

ok(  Devel::PPPort::test_isUPPER_A(ord("Z")));

# One of these two is uppercase in EBCDIC; the other in Latin1, but neither are
# ASCII uppercase.
ok(! Devel::PPPort::test_isUPPER_A(ord(0xDC)));
ok(! Devel::PPPort::test_isUPPER_A(ord(0xFC)));

ok(  Devel::PPPort::test_isLOWER(ord("b")));
ok(! Devel::PPPort::test_isLOWER(ord("B")));

ok(  Devel::PPPort::test_isLOWER_A(ord("y")));

# One of these two is lowercase in EBCDIC; the other in Latin1, but neither are
# ASCII lowercase.
ok(! Devel::PPPort::test_isLOWER_A(ord(0xDC)));
ok(! Devel::PPPort::test_isLOWER_A(ord(0xFC)));

ok(  Devel::PPPort::test_isALPHA(ord("C")));
ok(! Devel::PPPort::test_isALPHA(ord("1")));

ok(  Devel::PPPort::test_isALPHA_A(ord("x")));
ok(! Devel::PPPort::test_isALPHA_A(0xDC));

ok(  Devel::PPPort::test_isWORDCHAR(ord("_")));
ok(! Devel::PPPort::test_isWORDCHAR(ord("@")));

ok(  Devel::PPPort::test_isWORDCHAR_A(ord("2")));
ok(! Devel::PPPort::test_isWORDCHAR_A(0xFC));

ok(  Devel::PPPort::test_isALPHANUMERIC(ord("4")));
ok(! Devel::PPPort::test_isALPHANUMERIC(ord("_")));

ok(  Devel::PPPort::test_isALPHANUMERIC_A(ord("l")));
ok(! Devel::PPPort::test_isALPHANUMERIC_A(0xDC));

ok(  Devel::PPPort::test_isALNUM(ord("c")));
ok(! Devel::PPPort::test_isALNUM(ord("}")));

ok(  Devel::PPPort::test_isALNUM_A(ord("5")));
ok(! Devel::PPPort::test_isALNUM_A(0xFC));

ok(  Devel::PPPort::test_isDIGIT(ord("6")));
ok(! Devel::PPPort::test_isDIGIT(ord("_")));

ok(  Devel::PPPort::test_isDIGIT_A(ord("7")));
ok(! Devel::PPPort::test_isDIGIT_A(0xDC));

ok(  Devel::PPPort::test_isOCTAL(ord("7")));
ok(! Devel::PPPort::test_isOCTAL(ord("8")));

ok(  Devel::PPPort::test_isOCTAL_A(ord("0")));
ok(! Devel::PPPort::test_isOCTAL_A(ord("9")));

ok(  Devel::PPPort::test_isIDFIRST(ord("D")));
ok(! Devel::PPPort::test_isIDFIRST(ord("1")));

ok(  Devel::PPPort::test_isIDFIRST_A(ord("_")));
ok(! Devel::PPPort::test_isIDFIRST_A(0xFC));

ok(  Devel::PPPort::test_isIDCONT(ord("e")));
ok(! Devel::PPPort::test_isIDCONT(ord("@")));

ok(  Devel::PPPort::test_isIDCONT_A(ord("2")));
ok(! Devel::PPPort::test_isIDCONT_A(0xDC));

ok(  Devel::PPPort::test_isSPACE(ord(" ")));
ok(! Devel::PPPort::test_isSPACE(ord("_")));

ok(  Devel::PPPort::test_isSPACE_A(ord("\cK")));
ok(! Devel::PPPort::test_isSPACE_A(ord("F")));

# This stresses the edge for ASCII machines, but happens to work on EBCDIC as
# well
ok(  Devel::PPPort::test_isASCII(0x7F));
ok(! Devel::PPPort::test_isASCII(0x80));

ok(  Devel::PPPort::test_isASCII_A(ord("9")));

# B6 is the PARAGRAPH SIGN in ASCII and EBCDIC
ok(! Devel::PPPort::test_isASCII_A(0xB6));

ok(  Devel::PPPort::test_isCNTRL(ord("\e")));
ok(! Devel::PPPort::test_isCNTRL(ord(" ")));

ok(  Devel::PPPort::test_isCNTRL_A(ord("\a")));
ok(! Devel::PPPort::test_isCNTRL_A(0xB6));

ok(  Devel::PPPort::test_isPRINT(ord(" ")));
ok(! Devel::PPPort::test_isPRINT(ord("\n")));

ok(  Devel::PPPort::test_isPRINT_A(ord("G")));
ok(! Devel::PPPort::test_isPRINT_A(0xB6));

ok(  Devel::PPPort::test_isGRAPH(ord("h")));
ok(! Devel::PPPort::test_isGRAPH(ord(" ")));

ok(  Devel::PPPort::test_isGRAPH_A(ord("i")));
ok(! Devel::PPPort::test_isGRAPH_A(0xB6));

ok(  Devel::PPPort::test_isPUNCT(ord("#")));
ok(! Devel::PPPort::test_isPUNCT(ord(" ")));

ok(  Devel::PPPort::test_isPUNCT_A(ord("*")));
ok(! Devel::PPPort::test_isPUNCT_A(0xB6));

ok(  Devel::PPPort::test_isXDIGIT(ord("A")));
ok(! Devel::PPPort::test_isXDIGIT(ord("_")));

ok(  Devel::PPPort::test_isXDIGIT_A(ord("9")));
ok(! Devel::PPPort::test_isXDIGIT_A(0xDC));

ok(  Devel::PPPort::test_isPSXSPC(ord(" ")));
ok(! Devel::PPPort::test_isPSXSPC(ord("k")));

ok(  Devel::PPPort::test_isPSXSPC_A(ord("\cK")));
ok(! Devel::PPPort::test_isPSXSPC_A(0xFC));

ok(&Devel::PPPort::av_top_index([1,2,3]), 2);
ok(&Devel::PPPort::av_tindex([1,2,3,4]), 3);

