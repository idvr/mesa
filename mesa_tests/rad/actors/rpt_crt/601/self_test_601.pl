#!/usr/local/bin/perl -w

# Self test for Report Creator test 601.

use Env;
use Cwd;
use lib "scripts";
use lib "../../../common/scripts";
require rpt_crt;
require mesa_common;

if ($MESA_OS eq "WINDOWS_NT") {
  $storageDirectory = "$MESA_STORAGE\\rpt_manager\\instances";
} else {
  $storageDirectory = "$MESA_STORAGE/rpt_manager/instances";
}

mesa_utility::delete_directory(4, $storageDirectory);
mesa_utility::create_directory(4, $storageDirectory);

$dir = cwd();
chdir ("$MESA_TARGET/db");
print "Clearing Report Manager database \n";
print `perl ClearImgMgrTables.pl rpt_manager`;
chdir ($dir);

rpt_crt::cstore("../../msgs/sr/601/sr_601cr.dcm", "", "MESA_RPT_MGR", "localhost", "2700");
rpt_crt::cstore("../../msgs/sr/601/sr_601ct.dcm", "", "MESA_RPT_MGR", "localhost", "2700");
rpt_crt::cstore("../../msgs/sr/601/sr_601mr.dcm", "", "MESA_RPT_MGR", "localhost", "2700");
