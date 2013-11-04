#!/usr/local/bin/perl -w

use Env;
use lib "../../../common/scripts";
require "mesa_get.pm";
require "mesa_evaluate.pm";

#require "../../../common/scripts/mesa_get.pm";
#require "../../../common/scripts/mesa_evaluate.pm";

use lib "../common/scripts";
require "evaluate_fusion.pm";

sub goodbye() {
  exit 1;
}

# BSPS object

sub x_3540_1 {
 print LOG "\n\nCTX: Evidence Creator 3540.1 \n";
 print LOG "CTX:  Evaluating BSPS object\n";
 my ($y, @storedSOPInstance) = mesa_get::getSOPInstanceFileNames($logLevel, "imgmgr");

 my $x = mesa_evaluate::eval_bsps_evd_creator(
	$logLevel,
	"$MESA_STORAGE/FUSION/3540/BSPS/bsps.dcm",
	$storedSOPInstance[0],
    "$MESA_STORAGE/FUSION/3540/CT",
    "$MESA_STORAGE/FUSION/3540/PT",
	);

 return $x;
}

# Examine Storage Commitment
sub x_3540_2 {
 print LOG "\n\nCTX: Evidence Creator 3540.2 \n";
 print LOG "CTX:  Evaluating Storage Commitment\n";

  my ($status, @commitFiles) = mesa_get::getOpenSCRequests($logLevel, $titleStorageCommit);

  if ($status != 0) {
    print LOG "ERR: Unable to get list of open Storage Commit requests\n";
    return 1;
  }
  if (scalar(@commitFiles) != 1) {
    my $x = scalar(@commitFiles);
    print LOG "ERR: Expected 1 open storage commitment request; found $x\n";
    return 1;
  }

  my $f = $commitFiles[0];
  print "Open commit request $f\n";
  my ($x, @referencedSOP) = mesa_get::getReferencedSOPSequence($logLevel, $f);
  my ($y, @storedSOPInstance) = mesa_get::getSOPInstancesFromDB($logLevel, "imgmgr");

  if ($logLevel >= 3) {
    print LOG "CTX: Storage Commit referenced SOP Instances\n";
    foreach $sop(@referencedSOP) {
      print LOG "CTX:  $sop\n";
    }
    print LOG "CTX: Image Manager DB stored SOP Instances\n";
    foreach $sop(@storedSOPInstance) {
      print LOG "CTX: $sop\n";
    }
  }

  $x = scalar(@referencedSOP);
  $y = scalar(@storedSOPInstance);
  if ($x != $y) {
    print LOG "ERR: Number of referenced SOP Instances in open SC request: $x\n";
    print LOG "ERR: Number of SOP Instances in MESA Image Manager DB:      $y\n";
    print LOG "ERR: The values should be equal for storage commitment success\n";
    return 1;
  }

  foreach $sop(@referencedSOP) {
    my @tokens = split /:/, $sop;
    $instance = $tokens[0];
    $class    = $tokens[1];
    $h{$instance} = $class;
  }

  my $rtnValue = 0;
  foreach $sop(@storedSOPInstance) {
    $class = $h{$sop};
    if (!$class) {
      $rtnValue = 1;
      print LOG "ERR: No matching Storage Commit request for SOP Ins $sop\n";
    } elsif ($class eq "") {
      $rtnValue = 1;
      print LOG "ERR: No matching Storage Commit request for SOP Ins $sop\n";
    }
  }

 return $rtnValue;
}

# Examine BSPS Object - check to see if the image count of the BSPS object is same as in db
sub x_3540_3 {
  print LOG "\n\nCTX: Evidence Creator 3540.3 \n";
  print LOG "CTX: Evaluating reference image SOP Instance ID in BSPS object generated by test Evidence Creator\n";

  ## Locate BSPS object generated by Evidence Creator
  my ($s2, $path) = evaluate_fusion::locateBSPS($logLevel, "imgmgr");
  return 1 if ($s2 != 0);
  print LOG "CTX: BSPS DICOM Object generated by Evidence Creator is located at ". $path."\n";

  ## Extract referenced images from BSPS object generated by Test Evidence Creator
  my $refTestImgRefHash = evaluate_fusion::getImgInstanceFromBSPS($logLevel, $path, 2, "test");
  #foreach my $key (sort keys %$refImgRefHash){print $key.": ".$refImgRefHash->{$key}."\n";}


  ## Extract referenced images from BSPS object generated by MESA
  my $refMESAImgRefHash = evaluate_fusion::getImgInstanceFromBSPS($logLevel, "$MESA_STORAGE/FUSION/3540/BSPS/bsps.dcm", 2, "mesa");
  #foreach my $key (sort keys %$refImgRefHash){print $key.": ".$refImgRefHash->{$key}."\n";}

  print LOG "CTX: Compare BSPS DICOM objects generated by test Evidence Creator and MESA to see if Ref Img SOP Instance IDs are the same\n";
  $rtnValue = evaluate_fusion::testHashEqual($logLevel, $refTestImgRefHash, $refMESAImgRefHash);
  return $rtnValue;
}

### Main starts here

die "Usage: <log level: 1-4> <AE Title Storage Commit SCU>" if (scalar(@ARGV) < 2);

$logLevel = $ARGV[0];
$titleStorageCommit = $ARGV[1];
open LOG, ">3540/grade_3540.txt" or die "?!";
$diff = 0;

$diff += x_3540_1;
$diff += x_3540_2;
$diff += x_3540_3;

print LOG "\nTotal Differences: $diff \n";
print "\nTotal Differences: $diff \n";

print "Logs stored in 3540/grade_3540.txt \n";

exit $diff;
