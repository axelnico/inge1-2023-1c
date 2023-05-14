!classDefinition: #MarsRoverTests category: 'MarsRoverClass'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverClass'!

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'am 5/13/2023 15:32:15'!
test01MarsRoverStartAtaPositionAndFacingAcardinalPoint
	|aMarsRover|
	
	aMarsRover:= MarsRover startAt: 0@0 facing: #North.
	
	self assert: (aMarsRover isAt: 0@0 facing: #North).! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'am 5/13/2023 15:33:27'!
test02MarsRoverWithEmptyCommandsMoveStayTheSame
	|aMarsRover|
	
	aMarsRover:= MarsRover startAt: 0@0 facing: #North.
	aMarsRover reciveComands: ''.
	aMarsRover move.
	self assert: (aMarsRover isAt: 0@0 facing: #North).! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'am 5/13/2023 15:34:24'!
test03MarsRoverAtAPositionWithFCommandMoveFowardOnce
	|aMarsRover|
	
	aMarsRover:= MarsRover startAt: 0@0 facing: #North.
	aMarsRover reciveComands: 'f'.
	aMarsRover move.
	self assert: (aMarsRover isAt: 1@0 facing: #North).! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'am 5/13/2023 15:34:59'!
test04MarsRoverAtAPositionWithBCommandMoveBackwardOnce
	|aMarsRover|
	
	aMarsRover:= MarsRover startAt: 0@0 facing: #North.
	aMarsRover reciveComands: 'b'.
	aMarsRover move.
	self assert: (aMarsRover isAt: -1@0 facing: #North).! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'am 5/13/2023 15:35:41'!
test05MarsRoverAtAnyPositionWithFCommandMoveFowardOnce
	|aMarsRover|
	
	aMarsRover:= MarsRover startAt: 1@0 facing: #North.
	aMarsRover reciveComands: 'f'.
	aMarsRover move.
	self assert: (aMarsRover isAt: 2@0 facing: #North).! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'am 5/13/2023 15:36:28'!
test06MarsRoverAtAnyPositionWithBCommandMoveBackwardOnce
	|aMarsRover|
	
	aMarsRover:= MarsRover startAt: 1@0 facing: #North.
	aMarsRover reciveComands: 'b'.
	aMarsRover move.
	self assert: (aMarsRover isAt: 0@0 facing: #North).! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'am 5/13/2023 15:38:09'!
test07MarsRoverAtAnyPositionWithTwoBCommandMoveBackwardTwice
	|aMarsRover|
	
	aMarsRover:= MarsRover startAt: 1@0 facing: #North.
	aMarsRover reciveComands: 'bb'.
	aMarsRover move.
	self assert: (aMarsRover isAt: -1@0 facing: #North).! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'am 5/13/2023 15:39:29'!
test08MarsRoverAtAnyPositionWithTwoBCommandMoveBackwardTwice
	|aMarsRover|
	
	aMarsRover:= MarsRover startAt: 1@0 facing: #North.
	aMarsRover reciveComands: 'bb'.
	aMarsRover move.
	self assert: (aMarsRover isAt: -1@0 facing: #North).! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'am 5/13/2023 16:07:44'!
test09MarsRoverAtAnyPositionWithManyBCommandMoveBackwardManyTimes
	|aMarsRover|
	
	aMarsRover:= MarsRover startAt: 1@0 facing: #North.
	aMarsRover reciveComands: 'bbb'.
	aMarsRover move.
	self assert: (aMarsRover isAt: -2@0 facing: #North).! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'am 5/13/2023 15:52:17'!
test10MarsRoverAtAnyPositionWithTwoFCommandMoveFowardTwice
	|aMarsRover|
	
	aMarsRover:= MarsRover startAt: 1@0 facing: #North.
	aMarsRover reciveComands: 'ff'.
	aMarsRover move.
	self assert: (aMarsRover isAt: 3@0 facing: #North).! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'am 5/13/2023 16:07:24'!
test11MarsRoverAtAnyPositionWithManyFCommandMoveFowardManyTimes
	|aMarsRover|
	
	aMarsRover:= MarsRover startAt: 1@0 facing: #North.
	aMarsRover reciveComands: 'fff'.
	aMarsRover move.
	self assert: (aMarsRover isAt: 4@0 facing: #North).! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'am 5/13/2023 16:17:05'!
test12MarsRoverAtAnyPositionWithFBCommandsMovesFrontAndBackManyTimes
	|aMarsRover|
	
	aMarsRover:= MarsRover startAt: 1@0 facing: #North.
	aMarsRover reciveComands: 'fbbffb'.
	aMarsRover move.
	self assert: (aMarsRover isAt: 1@0 facing: #North).! !


!classDefinition: #MarsRover category: 'MarsRoverClass'!
Object subclass: #MarsRover
	instanceVariableNames: 'xYPoint cardinalPoint xyPosition facing moves'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverClass'!

!MarsRover methodsFor: 'initilizacion' stamp: 'am 5/13/2023 15:02:04'!
initializeAt: aXYPoint facing: aCardinalPoint 
	xyPosition:=aXYPoint.
	facing:=aCardinalPoint.! !

!MarsRover methodsFor: 'initilizacion' stamp: 'am 5/13/2023 15:04:52'!
reciveComands: aPackageOfCommands 
	moves:=aPackageOfCommands. ! !


!MarsRover methodsFor: 'inspecting' stamp: 'am 5/13/2023 15:04:10'!
isAt: aXYPoint facing: aCardinalPoint
	^ xyPosition = aXYPoint and: facing = aCardinalPoint.! !


!MarsRover methodsFor: 'move' stamp: 'am 5/13/2023 16:16:11'!
move
	 | index aCommand |
	index:=1.
	moves size < 1 ifTrue:[^self].
	
	[index <= moves size] whileTrue:[
		aCommand := moves at: index.
		aCommand = $b  ifTrue:[
				xyPosition := xyPosition - (1@0).
			] 
			ifFalse: [
				xyPosition := xyPosition + (1@0).
			].
		index:= index + 1.
	]. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRoverClass'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'am 5/13/2023 14:40:24'!
startAt: aXYPoint facing: aCardinalPoint
	^self new initializeAt: aXYPoint facing: aCardinalPoint! !
