#!/usr/local/bin/perl -w

# This script evaluates RSP^K23 messages sent by a
# PIX Cross Reference Manager for test 10506.

use Env;
use lib "scripts";
use lib "../../../common/scripts";
require xref_mgr;
require mesa_common;
require mesa_evaluate;

sub dummy {}


sub x_10506_1 {
  print LOG "CTX: XREF 10506.1\n";
  print LOG "CTX: Evaluate RSP K23 response to query 10506.106.\n";

  print LOG "CTX: Evaluate baseline response.\n";
  $diff += mesa::evaluate_RSP_K23_baseline (
	$logLevel,
	"10506/106/mesa/1000.hl7",
	"10506/106/test/1000.hl7");
  print LOG "\n";
}

sub x_10506_2 {
  print LOG "CTX: XREF 10506.2\n";
  print LOG "CTX: Evaluate RSP K23 response to query 10506.110.\n";
  print LOG "CTX: Evaluate baseline response.\n";
  $diff += mesa::evaluate_RSP_K23_baseline (
	$logLevel,
	"10506/110/mesa/1000.hl7",
	"10506/110/test/1000.hl7");
  print LOG "\n";

  print LOG "CTX: Evaluate PID segment.\n";
  $diff += mesa::evaluate_RSP_K23_PID (
	$logLevel,
	"10506/110/mesa/1000.hl7",
	"10506/110/test/1000.hl7");
  print LOG "\n";
}


### Main starts here

# Compare input RSP K23 messages with expected values.
die "Usage: perl 10506/eval_10506.pl <log level (1-4)>\n" if (scalar(@ARGV) < 1);

open LOG, ">10506/grade_10506.txt" or die "Cout not open output file 10506/grade_10506.txt";
my $version = mesa_get::getMESANumericVersion();
my $numericVersion = mesa_get::getMESANumericVersion();
($x, $date, $timeMin, $timeToSec) = mesa_get::getDateTime(0);
dummy($x); dummy($timeMin); dummy($timeToSec);

print LOG "CTX: Test:    10506\n";
print LOG "CTX: Actor:   PAT_IDENTITY_X_REF_MGR\n";
print LOG "CTX: Version: $numericVersion\n";
print LOG "CTX: Date:    $date\n";


$diff = 0;
$logLevel = $ARGV[0];

x_10506_1;
x_10506_2;

if ($logLevel != 4) {
  $diff += 1;
  print LOG "ERR: Log level for submission should be 4, not $logLevel. For results submission, this is considered a failure. Please rerun at log level 4.\n";
}

close LOG;

mesa_evaluate::copyLogWithXML("10506/grade_10506.txt", "10506/mir_mesa_10506.xml",
        $logLevel, "10506", "PAT_IDENTITY_X_REF_MGR", $numericVersion, $date, $diff);

if ($diff == 0) {
  print "\nThis test completed with zero errors; that means successful test\n";
} else {
  print "Test detected $diff errors; this implies a failure\n";
  print " Please consult 10506/grade_10506.txt and 10506/mir_mesa_10506.xml\n";
}

print "If you are submitting a result file to Kudu, submit 10506/mir_mesa_10506.xml\n\n";

