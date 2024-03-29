PackageManifest subclass: #ManifestAdventOfCode
	instanceVariableNames: ''
	classVariableNames: ''
	package: 'AdventOfCode-Manifest'!
!ManifestAdventOfCode commentStamp: 'DanielChristo 12/8/2021 22:58' prior: 0!
This package contains all my code related to the Day 8 challenge I'm writing in Smalltalk!
Object subclass: #Challenges
	instanceVariableNames: ''
	classVariableNames: 'ListOfOutputs ListOfSignalPatterns'
	package: 'AdventOfCode-Day8'!
!Challenges commentStamp: 'DanielChristo 12/8/2021 23:30' prior: 0!
I represent the Code Challenge itself.

My job is to load the challenge input, parse it into appropriate lists of objects and then process that input.

- loadInput  
- findSolution
 
challengeOne := ChallengeOne new.!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Challenges class
	instanceVariableNames: 'signalsAndOutputs'!

!Challenges class methodsFor: 'accessing' stamp: 'DanielChristo 12/9/2021 00:56'!
signalsAndOutputs

	^ signalsAndOutputs! !

!Challenges class methodsFor: 'accessing' stamp: 'DanielChristo 12/9/2021 00:56'!
signalsAndOutputs: anObject

	signalsAndOutputs := anObject! !


!Challenges class methodsFor: 'setting' stamp: 'DanielChristo 12/9/2021 01:11'!
loadInputs: fileName
	"load the parsed problem input into the a class variable"
	|input lines signalAndOutput signals outputs signalAndOutputDictionary |
			
input := fileName asFileReference readStreamDo: [ :stream | stream upToEnd ]. 
lines := input splitOn: String lf.

signalsAndOutputs := lines collect: [:line | 
		signalAndOutput := line splitOn: ' | '.
		signals := (signalAndOutput at: 1) splitOn: ' '.
		outputs := (signalAndOutput at: 2) splitOn: ' '.
		signalAndOutputDictionary := Dictionary new
			at: 'signals' put: signals;
			at: 'output' put: outputs;
			yourself.
		signalAndOutputDictionary.
	].
! !


!Challenges class methodsFor: 'class modifications' stamp: 'DanielChristo 12/9/2021 09:29'!
findSolutionOne
	"This loads the input values for the first challenge, processes them and returns a result"	
			
	| uniqueLengths matchingOutputs outputVals identifiableOutputs |

	Challenges loadInputs: './advent_of_code/day8/input.txt'.
	signalsAndOutputs := Challenges signalsAndOutputs.
	uniqueLengths := #( 2 3 4 7 ) asSet.
	matchingOutputs := signalsAndOutputs inject: 0 into: [ :identifiableOutputSize :signalAndOutput  | 
		outputVals := signalAndOutput at: 'output'.			
		identifiableOutputs := outputVals select: [ :anOutput | (uniqueLengths includes: (anOutput size)).].
		identifiableOutputSize + (identifiableOutputs size).	
	].
	
	^ matchingOutputs.! !

!Challenges class methodsFor: 'class modifications' stamp: 'DanielChristo 12/9/2021 16:47'!
findSolutionTwo
	"This loads the input values for the second challenge, processes them and returns a result"	
			
	| sumOfReadings matchingOutputs outputVals signals signalMap reverseMap lengthFiveSignals lengthSixSignals signalCharSet positionA positionE bottomLeftCorner potentialNine topLeftCorner signalThree positionG signalSix outputNumberStr outputCharSet outputNumber|

Challenges loadInputs: './advent_of_code/day8/input.txt'.
	signalsAndOutputs := Challenges signalsAndOutputs.
	sumOfReadings := 0.
	matchingOutputs := signalsAndOutputs inject: 0 into: [ :identifiableOutputSize :signalAndOutput  | 
		outputVals := signalAndOutput at: 'output'.
		signals := signalAndOutput at: 'signals'.
		signalMap := Dictionary new.
		reverseMap := Dictionary new.
		lengthFiveSignals := OrderedCollection new.
		lengthSixSignals := OrderedCollection new. 
		signals do: [ :signal |
			signalCharSet := Set new.
			signal do: [ :aChar | signalCharSet add: aChar ].
			((signal size) = 2) ifTrue: [ signalMap at: signal put: 1. reverseMap at: 1 put: signalCharSet ].
			((signal size) = 3) ifTrue: [ signalMap at: signal put: 7. reverseMap at: 7 put: signalCharSet ].
			((signal size) = 4) ifTrue: [ signalMap at: signal put: 4. reverseMap at: 4 put: signalCharSet ].
			((signal size) = 5) ifTrue: [ lengthFiveSignals add: signalCharSet ].
			((signal size) = 6) ifTrue: [ lengthSixSignals add: signalCharSet ].
			((signal size) = 7) ifTrue: [ signalMap at: signal put: 8. reverseMap at: 8 put: signalCharSet ].    
	 	].			

		"Top signal is in 7 but not in 4"
		positionA := (reverseMap at: 7) difference: (reverseMap at: 4).
		"If I remove 7 and 4 from 8 I get the bottom left corner"
		bottomLeftCorner := ((reverseMap at: 8) difference: (reverseMap at: 7)) difference: (reverseMap at: 4). 
		"If I remove 1 from 4 I get the top left corner"
		topLeftCorner := (reverseMap at: 4) difference: (reverseMap at: 1).
		"If I add 4 to all of 2 3 and 5 - any that are not equal to 8 are equal to 9"
		lengthFiveSignals do: [ :signalSet |
					potentialNine := signalSet union: (reverseMap at: 4).
					((potentialNine size) = 6) ifTrue: [ reverseMap at: 9 put: potentialNine ].
				 ].
		"If I subtract 9 from 8 I get position 'e' in the problem diagram"
		positionE := (reverseMap at: 8) difference: (reverseMap at: 9).
		"If I subtract position 'e' from the bottom corner I get position g"
		positionG := bottomLeftCorner difference: positionE.
		"If one of 2 3 5 contains position 'e' then this is 2"
		lengthFiveSignals do: [ :signalSet |
				(signalSet includesAll: positionE) ifTrue: [ reverseMap at: 2 put: signalSet ]].
		"2 union 1 minus position e is 3"
		signalThree := ((reverseMap at: 2) union: (reverseMap at: 1)) difference: positionE. 
		reverseMap at: 3 put: signalThree. 
		"if I subtract 1 and position e from 0 6,9 - the value with 3 will be 0"
		lengthSixSignals do: [ :signalSet |
			(((signalSet difference: (reverseMap at: 1)) difference: positionE) size = 3) ifTrue: [ reverseMap at: 0 put: signalSet ]].
		"If I subtract 3 and position e from 2 3 5, 5 will be 1"
		lengthFiveSignals do: [ :signalSet |
				(((signalSet difference: (reverseMap at: 3)) difference: positionE) size = 1) ifTrue: [ reverseMap at: 5 put: signalSet ]].
		"6 is five with position e added"
		signalSix := (reverseMap at: 5) union: positionE.
		reverseMap at: 6 put: signalSix.
		
		signals do: [ :signal |
			signalCharSet := Set new.
			signal do: [ :aChar | signalCharSet add: aChar ].
			((signal size) = 5) ifTrue: [ ((signalCharSet difference: (reverseMap at: 2)) size = 0) ifTrue: [ signalMap at: signal put: 2 ] ].
			((signal size) = 5) ifTrue: [ ((signalCharSet difference: (reverseMap at: 3)) size = 0) ifTrue: [ signalMap at: signal put: 3 ] ].
			((signal size) = 5) ifTrue: [ ((signalCharSet difference: (reverseMap at: 5)) size = 0) ifTrue: [ signalMap at: signal put: 5 ] ].
			((signal size) = 6) ifTrue: [ ((signalCharSet difference: (reverseMap at: 0)) size = 0) ifTrue: [ signalMap at: signal put: 0 ] ].
			((signal size) = 6) ifTrue: [ ((signalCharSet difference: (reverseMap at: 6)) size = 0) ifTrue: [ signalMap at: signal put: 6 ] ].
			((signal size) = 6) ifTrue: [ ((signalCharSet difference: (reverseMap at: 9)) size = 0) ifTrue: [ signalMap at: signal put: 9 ] ].
			].	
		
		outputNumberStr := '' writeStream.
		outputVals do: [ :outputVal | 
		   outputCharSet := Set new.
			outputVal do: [ :aChar | outputCharSet add: aChar ].	
			((outputCharSet size = (reverseMap at: 0) size) & (outputCharSet difference: (reverseMap at: 0)) size = 0) ifTrue: [  outputNumberStr nextPut: $0.].
			((outputCharSet size = (reverseMap at: 1) size) & (outputCharSet difference: (reverseMap at: 1)) size = 0) ifTrue: [  outputNumberStr nextPut: $1.].	
			((outputCharSet size = (reverseMap at: 2) size) & (outputCharSet difference: (reverseMap at: 2)) size = 0) ifTrue: [  outputNumberStr nextPut: $2.].	
			((outputCharSet size = (reverseMap at: 3) size) & (outputCharSet difference: (reverseMap at: 3)) size = 0) ifTrue: [  outputNumberStr nextPut: $3.].	
			((outputCharSet size = (reverseMap at: 4) size) & (outputCharSet difference: (reverseMap at: 4)) size = 0) ifTrue: [  outputNumberStr nextPut: $4.].
			((outputCharSet size = (reverseMap at: 5) size) & (outputCharSet difference: (reverseMap at: 5)) size = 0) ifTrue: [  outputNumberStr nextPut: $5.].
			((outputCharSet size = (reverseMap at: 6) size) & (outputCharSet difference: (reverseMap at: 6)) size = 0) ifTrue: [  outputNumberStr nextPut: $6.].	
			((outputCharSet size = (reverseMap at: 7) size) & (outputCharSet difference: (reverseMap at: 7)) size = 0) ifTrue: [  outputNumberStr nextPut: $7.].	
			((outputCharSet size = (reverseMap at: 8) size) & (outputCharSet difference: (reverseMap at: 8)) size = 0) ifTrue: [  outputNumberStr nextPut: $8.].	
			((outputCharSet size = (reverseMap at: 9) size) & (outputCharSet difference: (reverseMap at: 9)) size = 0) ifTrue: [  outputNumberStr nextPut: $9.].		
		].
	
		outputNumber := (outputNumberStr contents) asNumber.
		sumOfReadings := sumOfReadings + outputNumber.
	].	
	
	^ sumOfReadings.

! !
