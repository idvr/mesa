#!/usr/local/bin/perl -w

use Env;

# Generate ADT HL7 messages for Case 1411

sub create_text_file_2_var_files {
  `perl $MESA_TARGET/bin/text_var_sub.pl $_[0] $_[1] $_[2] $_[3]`;
}

sub create_hl7 {
  `$MESA_TARGET/bin/txt_to_hl7 -d ihe -b $MESA_TARGET/runtime < $_[0].txt > $_[0].hl7`;
}

create_text_file_2_var_files("1411.102.a04.txt", "../templates/a04.tpl",
	"../../adt/1411/connecticut.var", "1411.102.a04.var");
create_hl7("1411.102.a04");

# Repeat for 1411.104; use the same input files. This is not an error.
create_text_file_2_var_files("1411.104.a04.txt", "../templates/a04.tpl",
	"../../adt/1411/connecticut.var", "1411.102.a04.var");
create_hl7("1411.104.a04");
