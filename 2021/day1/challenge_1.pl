#!/usr/bin/perl

$numberOfIncreases = 0, $previous = "inf";
while(<>){
  $numberOfIncreases++ if($_ > $previous);
  $previous = $_;   
}
print($numberOfIncreases);
