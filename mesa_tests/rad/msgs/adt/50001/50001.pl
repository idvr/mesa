#!/usr/local/bin/perl -w

use Env;
use File::Copy;

use lib "../../common";
require mesa_msgs;


# Generate HL7 messages for Case 50001

  if (scalar(@ARGV) == 0) {
    copy("richmond.var", "richmond.txt");
  } else {
  # The file richmond.txt would have been produced externally
  }

  mesa_msgs::create_text_file_2_var_files(
	"50001.110.a04.txt",      # The output file
	"../templates/a04.tpl", # Template for an A04
	"richmond.txt",              # PID, PV1 data
	"50001.110.a04.var"       # A04 variables not in PID, PV1
  );
  mesa_msgs::create_hl7("50001.110.a04");

  mesa_msgs::create_text_file_2_var_files(
	"50001.120.a04.txt",      # The output file
	"../templates/a04.tpl", # Template for an A04
	"richmond.txt",              # PID, PV1 data
	"50001.120.a04.var"       # A04 variables not in PID, PV1
  );
  mesa_msgs::create_hl7("50001.120.a04");

