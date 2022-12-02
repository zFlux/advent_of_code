<?php
    
    $inputFile = fopen("input.txt", "r") or die("Unable to open file!");
    $inputArray = array_map('intval', str_split(trim(fgets($inputFile))));
    $mapLength = count($inputArray);
    $globalMap = [];
    $basinSums = [];

    while(!feof($inputFile)) {
        $inputArray = array_merge($inputArray, array_map('intval', str_split(trim(fgets($inputFile)))));
    }
    fclose($inputFile);

    for ($i = 0; $i < count($inputArray); $i++)  {
        if(isLocalMinimum($i, $inputArray, $mapLength) && !array_key_exists($i, $globalMap)) {
            array_push($basinSums, sumBasinPositions($i, $inputArray, $mapLength));
        } 
    }

    rsort($basinSums);
    print_r("Three largest basin's multiplied: ");
    print_r($basinSums[0] * $basinSums[1] * $basinSums[2]);
    print_r("\n");

    function sumBasinPositions($position, $inputArray, $mapLength) {

        global $globalMap;

        $up = $position - $mapLength;
        $right = $position + 1;
        $down = $position + $mapLength;
        $left = $position - 1;
        $sum = 0;

        $canGoLeft = ($position % $mapLength == 0) ? false : true;
        $canGoRight = (($position + 1) % $mapLength == 0) ? false : true;
        $canGoUp = ($position - $mapLength < 0) ? false : true;
        $canGoDown = ($position + $mapLength > count($inputArray)) ? false : true;

        $globalMap[$position] = true;
        $sum = 1;
        if ($canGoUp && lookupPosition($up, $inputArray) < 9 && !array_key_exists($up, $globalMap)) {
            $sumUp = sumBasinPositions($up, $inputArray, $mapLength);
            $sum += $sumUp; 
        } 
        if ($canGoDown && lookupPosition($down, $inputArray) < 9 && !array_key_exists($down, $globalMap)) {
            $sumDown = sumBasinPositions($down, $inputArray, $mapLength); 
            $sum += $sumDown;
        } 
        if ($canGoLeft && lookupPosition($left, $inputArray) < 9 && !array_key_exists($left, $globalMap)) {
            $sumLeft = sumBasinPositions($left, $inputArray, $mapLength); 
            $sum += $sumLeft;
        } 
        if ($canGoRight && lookupPosition($right, $inputArray) < 9 && !array_key_exists($right, $globalMap)) {
            $sumRight = sumBasinPositions($right, $inputArray, $mapLength); 
            $sum += $sumRight;
        } 

        return $sum ;
    }

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