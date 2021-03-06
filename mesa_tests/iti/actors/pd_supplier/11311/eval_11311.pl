#!/usr/local/bin/perl -w

# This script evaluates RSP^K22 messages sent by a
# PD Supplier for test 11311.

use Env;
use lib "scripts";
use lib "../../../common/scripts";
require pd_supplier;
require mesa_common;
require mesa_evaluate;

sub dummy {}

sub x_11311_1 {
  print LOG "\nCTX: PD Supplier 11311.1\n";
  print LOG "CTX: Count response messages to query: MOORE^CHIP\n";
  print LOG "CTX: There should be one response\n";
  my @filesMESA = mesa_get::getDirectoryList($logLevel, "11311/mesa");
  my $countMESA = scalar(@filesMESA);

  my @filesTest = mesa_get::getDirectoryList($logLevel, "11311/test");
  my $countTest = scalar(@filesTest);

  my $rtnValue = 0;
  if ($countMESA != 1) {
   print LOG "ERR: Found $countMESA responses to 11311 query; there should be 1\n";
   print LOG "ERR: Please log a bug report.\n";
   $rtnValue = 1;
  }

  if ($countTest != 1) {
   print LOG "ERR: Found $countTest responses to 11311 query; there should be 1\n";
   print LOG "ERR: Look at your responses in 11311/test\n";
   $rtnValue = 1;
  }

  print LOG "\n";
  return $rtnValue;
}

sub x_11311_2 {
  print LOG "CTX: PD Supplier 11311.2\n";
  print LOG "CTX: Evaluate RSP K22 response to query 11311.\n";
  print LOG "CTX: Evaluate baseline response.\n";
  my $x = mesa::evaluate_PDQ_RSP_K22_baseline(
	$logLevel,
	"11311/mesa/1000.hl7",
	"11311/test/1000.hl7");
  print LOG "\n";
  return $x;
}


### Main starts here

# Compare input RSP K22 messages with expected values.
die "Usage: perl 11311/eval_11311.pl <log level (1-4)>\n" if (scalar(@ARGV) < 1);
$logLevel = $ARGV[0];

open LOG, ">11311/grade_11311.txt" or die "Cout not open output file 11311/grade_11311.txt";
my $version = mesa_get::getMESANumericVersion();
my $numericVersion = mesa_get::getMESANumericVersion();
($x, $date, $timeMin, $timeToSec) = mesa_get::getDateTime(0);
dummy($x); dummy($timeMin); dummy($timeToSec);

print LOG "CTX: Test:    11311\n";
print LOG "CTX: Actor:   PDS\n";
print LOG "CTX: Version: $numericVersion\n";
print LOG "CTX: Date:    $date\n";

$diff = 0;

$diff += x_11311_1;
$diff += x_11311_2;

if ($logLevel != 4) {
  $diff += 1;
  print LOG "ERR: Log level for submission should be 4, not $logLevel. For results submission, this is considered a failure. Please rerun at log level 4.\n";
}

close LOG;

mesa_evaluate::copyLogWithXML("11311/grade_11311.txt", "11311/mir_mesa_11311.xml",
        $logLevel, "11311", "PDS", $numericVersion, $date, $diff);

if ($diff == 0) {
  print "\nThis test completed with zero errors; that means successful test\n";
} else {
  print "Test detected $diff errors; this implies a failure\n";
  print " Please consult 11311/grade_11311.txt and 11311/mir_mesa_11311.xml\n";
}

print "If you are submitting a result file to Kudu, submit 11311/mir_mesa_11311.xml\n\n";
