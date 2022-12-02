<?php
    
    $inputFile = fopen("input.txt", "r") or die("Unable to open file!");
    $inputArray = array_map('intval', str_split(trim(fgets($inputFile))));
    $mapLength = count($inputArray);
    $riskLevel = 0;

    while(!feof($inputFile)) {
        $inputArray = array_merge($inputArray, array_map('intval', str_split(trim(fgets($inputFile)))));
    }
    fclose($inputFile);

    for ($i = 0; $i < count($inputArray); $i++)  {
        if(isLocalMinimum($i, $inputArray, $mapLength)) {
            $riskLevel = $riskLevel + $inputArray[$i] + 1;
        } 
    }

    print "\nRisk level: " . $riskLevel . "\n";

    function isLocalMinimum($position, $inputArray, $mapLength) {

        $up = $position - $mapLength;
        $right = $position + 1;
        $down = $position + $mapLength;
        $left = $position - 1;

        return $inputArray[$position] < lookupPosition($up, $inputArray) &&
        $inputArray[$position] < lookupPosition($right, $inputArray) &&
        $inputArray[$position] < lookupPosition($down, $inputArray) && 
        $inputArray[$position] < lookupPosition($left, $inputArray);
    }

    function lookupPosition($position, $inputArray) {
        $val = ($position < 0 || $position >= count($inputArray)) ? 9 : $inputArray[$position];
        return $val;
    }

?>