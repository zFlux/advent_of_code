PackageManifest subclass: #ManifestAdventOfCode
	instanceVariableNames: ''
	classVariableNames: ''
	package: 'AdventOfCode-Manifest'!
!ManifestAdventOfCode commentStamp: 'DanielChristo 12/8/2021 22:58' prior: 0!
This package contains all my code related to the Day 8 challenge I'm writing in Smalltalk!
Object subclass: #ChallengeOne
	instanceVariableNames: ''
	classVariableNames: 'ListOfOutputs ListOfSignalPatterns'
	package: 'AdventOfCode-Day8'!
!ChallengeOne commentStamp: 'DanielChristo 12/8/2021 23:30' prior: 0!
I represent the Code Challenge itself.

My job is to load the challenge input, parse it into appropriate lists of objects and then process that input.

- loadInput  
- findSolution
 
challengeOne := ChallengeOne new.!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

ChallengeOne class
	instanceVariableNames: 'signalsAndOutputs'!

!ChallengeOne class methodsFor: 'accessing' stamp: 'DanielChristo 12/9/2021 00:56'!
signalsAndOutputs

	^ signalsAndOutputs! !

!ChallengeOne class methodsFor: 'accessing' stamp: 'DanielChristo 12/9/2021 00:56'!
signalsAndOutputs: anObject

	signalsAndOutputs := anObject! !


!ChallengeOne class methodsFor: 'setting' stamp: 'DanielChristo 12/9/2021 01:11'!
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

!ChallengeOne class methodsFor: 'class modifications' stamp: 'DanielChristo 12/9/2021 09:09'!
findSolution
	"This loads the input values for the first challenge, processes them and returns a result"	
			
	| uniqueLengths matchingOutputs outputVals identifiableOutputs |

	ChallengeOne loadInputs: './advent_of_code/day8/input.txt'.
	signalsAndOutputs := ChallengeOne signalsAndOutputs.
	uniqueLengths := #( 2 3 4 7 ) asSet.
	matchingOutputs := signalsAndOutputs inject: 0 into: [ :identifiableOutputSize :signalAndOutput  | 
		outputVals := signalAndOutput at: 'output'.			
		identifiableOutputs := outputVals select: [ :anOutput | (uniqueLengths includes: (anOutput size)).].
		identifiableOutputSize + (identifiableOutputs size).	
	].
	
	^ matchingOutputs.! !