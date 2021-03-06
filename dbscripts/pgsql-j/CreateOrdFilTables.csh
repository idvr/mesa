#!/bin/csh
#
# CreateOrdFilTables
#
if ($1 == "") then
  echo " "
  echo Usage: "$0 <Database Name>"
  echo " "
  exit 1
endif

foreach x (createpatient createvisit \
 createplacerorder createfillerorder createordr \
 createmwl createactionitem createschedule \
 createidentifiers createppwf load_id_of load_codes_of )
  echo $x
  psql $1 < $x.sql
  if ($status != 0) exit 1
end

#foreach x (createvisit createplacerorder createfillerorder \
#  createordr createmwl createactionitem createschedule createidentifiers \
#  createppwf load_id_of load_codes_of )
#  echo $x
#  psql $1 < $x.pgsql
#  if ($status != 0) exit 1
#end

exit 0
