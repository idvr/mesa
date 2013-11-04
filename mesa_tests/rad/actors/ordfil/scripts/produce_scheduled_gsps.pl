#!/usr/local/bin/perl

use Env;
use lib "scripts";
require ordfil;

sub clear_directories {
  print "Removing previous results (if any) $outputDirectory\n";
  ordfil::delete_directory($outputDirectory);
  print "Creating output directory (if necessary) \n";
  ordfil::create_directory($outputDirectory);

  print "Clear the mwl/results directory \n";
  ordfil::delete_directory("mwl/results");
  ordfil::create_directory("mwl/results");
}

sub retrieve_mwl {
  print "Creating MWL query to retrieve worklist \n";
  if (! (-e "mwl/mwlquery.txt") ) {
    print "The file mwl/mwlquery.txt does not exist.  Installation error. \n";
    exit 1;
  }
  $x = "$MESA_TARGET/bin/dcm_create_object -i mwl/mwlquery.txt mwl/mwlquery.dcm";
  print "$x\n";
  `$x`;
  die "Unable to create mwl/mwlquery.dcm.  Permission or other problem. \n" if ($?);

  open PIDFILE, ">pid.txt" or die "Could not open pid.txt to write patient ID \n";
  print PIDFILE "0010 0020 $patientID \n";
  close PIDFILE;
  open MWLOUTPUT, ">mwlquery.out";

  $x = "$MESA_TARGET/bin/mwlquery -a $modalityAE -c $mwlAE -d pid.txt -f mwl/mwlquery.dcm " .
	" -o mwl/results $mwlHost $mwlPort";
  print "$x\n";
  print MWLOUTPUT `$x`;
  die "Unable to obtain MWL from $mwlHost at port $mwlPort with AE title $mwlAE \n" if ($?);
}

#===============
# Main starts here

# Generate GSPS and MPPS files for a set of Images
# Args:
#	MODALITY
#	AE TITle
#	Patient ID
#	Procedure Code
#	Directory name (might be close to procedure Code)
#	AE Title of MWL server
#	Host name for MWL query
#	Port number for MWL query
#	Scheduled Procedure Code
#	Performed Procedure Code
#	Input directory
#	Configuration File

$x = scalar(@ARGV);
if ($x != 12) {
  print "This script requires 11 arguments: \n" .
" Modality (MR, CT, ...) \n" .
" AE Title of Modality \n" .
" Patient ID \n" .
" Procedure Code \n" .
" Output directory \n" .
" AE Title of MWL Server \n" .
" Host name of MWL Server \n" .
" Port number of MWL Server \n" .
" Scheduled Procedure Code \n" .
" Performed Procedure Code \n" .
" Input directory \n" .
" Configuration file \n";

exit 1;
}

$modality = $ARGV[0];
$modalityAE = $ARGV[1];
$patientID = $ARGV[2];
$outputDirectory = "$MESA_STORAGE/modality/$ARGV[4]";
$mwlAE = $ARGV[5];
$mwlHost = $ARGV[6];
$mwlPort = $ARGV[7];
$scheduledCode = $ARGV[8];
$performedCode = $ARGV[9];
$inputDirectory = $ARGV[10];
$configurationFile = $ARGV[11];

die "Modality value should be PR, not $modality" if ($modality ne "PR");

clear_directories;

retrieve_mwl;

$xStatement = "$MESA_TARGET/bin/mod_generatestudy -m $modality -p $patientID " .
 " -o GSPS -f $configurationFile " .
 " -s $scheduledCode -c $performedCode " .
 " -i $MESA_STORAGE/modality/$inputDirectory " .
 " -t $outputDirectory " .
 " -y mwl/results " .
 " -z \"IHE Protocol 1\" ";

print "$xStatement \n";

open STUDYOUT, ">generatestudy.out";

print STUDYOUT "$xStatement \n";

print STUDYOUT `$xStatement`;

if ($?) {
  print "Unable to create images/PPS from MWL.  Look in generatestudy.out \n";
  exit 1;
}

exit 0;

