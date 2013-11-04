#!/usr/local/bin/perl -w

use Env;
use File::Copy;
use lib "../../common";
require mesa_msgs;


# Generate HL7 messages for Case 1603

if (scalar(@ARGV) == 0) {
  copy("lincoln.var", "lincoln.txt");
} else {
# The file lincoln.txt would have been produced externally
}

  mesa_msgs::create_text_file_2_var_files (
	"1603.102.a04.txt",	# The output file
	"../templates/a04.tpl",	# Template for an A04
	"lincoln.txt",	# PID, PV1 data
	"1603.102.a04.var"	# A04 variables not in PID, PV1
  );
  mesa_msgs::create_hl7("1603.102.a04");

  mesa_msgs::create_text_file_2_var_files (
	"1603.104.a04.txt",	# The output file
	"../templates/a04.tpl",	# Template for an A04
	"lincoln.txt",	# PID, PV1 data
	"1603.104.a04.var"	# A04 variables not in PID, PV1
  );
  mesa_msgs::create_hl7("1603.104.a04");
