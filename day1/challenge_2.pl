#!/usr/bin/perl

$numberOfIncreases = 0;
$previousCompletedWindowSum = "inf";

# Initial state of my rolling window sums array
@rollingWindowSums = ();
@rollingWindowSums[0] = ($line = <>);
@rollingWindowSums[1] = ($line = <>);
@rollingWindowSums[0]+= @rollingWindowSums[1];

while(<>){
  @rollingWindowSums[0]+= $_;
  @rollingWindowSums[1]+= $_;
  @rollingWindowSums[2] = $_;
  $numberOfIncreases++ if(@rollingWindowSums[0] > $previousCompletedWindowSum);
  $previousCompletedWindowSum = shift @rollingWindowSums;
}
print($numberOfIncreases);