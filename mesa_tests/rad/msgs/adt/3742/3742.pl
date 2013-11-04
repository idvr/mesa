#!/usr/local/bin/perl -w

use Env;
use File::Copy;

use lib "../../common";
require mesa_msgs;

# Generate HL7 messages for Case 3742

  if (scalar(@ARGV) == 0) {
    copy("ivory.var", "ivory.txt");
    copy("aquamarine.var", "aquamarine.txt");
  } else {
  # The file ivory.txt would have been produced externally
  }

  mesa_msgs::create_text_file_2_var_files(
	"3742.115.a04.txt",	# The output file
	"../templates/a04.tpl",	# Template for an A04
	"ivory.txt",		# PID, PV1 data
	"3742.115.a04.var"	# A04 variables not in PID, PV1
  );
  
  mesa_msgs::create_text_file_2_var_files(
	"3742.110.a04.txt",	# The output file
	"../templates/a04.tpl",	# Template for an A04
	"aquamarine.txt",		# PID, PV1 data
	"3742.110.a04.var"	# A04 variables not in PID, PV1
  );
  
  mesa_msgs::create_hl7("3742.110.a04");
  mesa_msgs::create_hl7("3742.115.a04");



