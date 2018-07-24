mol new step3_pbcsetup.prmtop
mol addfile step3_pbcsetup.pdb

set all [atomselect top all]
#label heavy atoms
set sel [atomselect top "protein and noh"]
$all set beta 0
$sel set beta 1
$all writepdb conskfile.pdb

quit
