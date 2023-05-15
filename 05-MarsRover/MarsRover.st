!classDefinition: #MarsRoverTests category: 'MarsRover'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: 'north east south west'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTests methodsFor: 'test' stamp: 'NB 5/14/2023 22:00:53'!
setUp

	north:= North new.
	east:= East new.
	south:= South new.
	west:= West new.! !

!MarsRoverTests methodsFor: 'test' stamp: 'NB 5/15/2023 00:09:10'!
test01MarsRoverStartsAtAPositionAndFacingACardinalPoint
	|aMarsRover|
	
	aMarsRover:= self marsRoverAt00FacingNorth.
	
	self assert: (aMarsRover isAt: 0@0 facing: north).! !

!MarsRoverTests methodsFor: 'test' stamp: 'NB 5/15/2023 00:09:58'!
test02MarsRoverWithEmptyCommandsDoesNotMove
	|aMarsRover|
	
	aMarsRover:= self marsRoverAt00FacingNorth.
	aMarsRover receiveCommands: ''.
	
	self assert: (aMarsRover isAt: 0@0 facing: north).! !

!MarsRoverTests methodsFor: 'test' stamp: 'NB 5/15/2023 00:14:15'!
test03MarsRoverAtAPositionWithFCommandMovesForwardOncePointingNorth
	|aMarsRover|
	
	aMarsRover:= self marsRoverAt00FacingNorth.
	aMarsRover receiveCommands: 'f'.
	
	self assert: (aMarsRover isAt: 0@1 facing: north).! !

!MarsRoverTests methodsFor: 'test' stamp: 'NB 5/15/2023 00:14:26'!
test04MarsRoverAtAPositionWithBCommandMovesBackwardOncePointingNorth
	|aMarsRover|
	
	aMarsRover:= self marsRoverAt00FacingNorth.
	aMarsRover receiveCommands: 'b'.
	
	self assert: (aMarsRover isAt: 0@-1 facing: north).! !

!MarsRoverTests methodsFor: 'test' stamp: 'NB 5/15/2023 00:14:35'!
test05MarsRoverAtAnyPositionWithFCommandMovesForwardOncePointingNorth
	|aMarsRover|
	
	aMarsRover:= self marsRoverAt10FacingNorth.
	aMarsRover receiveCommands: 'f'.
	
	self assert: (aMarsRover isAt: 1@1 facing: north).! !

!MarsRoverTests methodsFor: 'test' stamp: 'NB 5/15/2023 00:14:45'!
test06MarsRoverAtAnyPositionWithBCommandMovesBackwardOncePointingNorth
	|aMarsRover|
	
	aMarsRover:= self marsRoverAt10FacingNorth.
	aMarsRover receiveCommands: 'b'.
	
	self assert: (aMarsRover isAt: 1@-1 facing: north).! !

!MarsRoverTests methodsFor: 'test' stamp: 'NB 5/15/2023 00:14:52'!
test07MarsRoverAtAnyPositionWithTwoBCommandsMovesBackwardTwicePointingNorth
	|aMarsRover|
	
	aMarsRover:= self marsRoverAt10FacingNorth.
	aMarsRover receiveCommands: 'bb'.
	
	self assert: (aMarsRover isAt: 1@-2 facing: north).! !

!MarsRoverTests methodsFor: 'test' stamp: 'NB 5/15/2023 00:15:03'!
test08MarsRoverAtAnyPositionWithManyBCommandsMovesBackwardManyTimesPointingNorth
	|aMarsRover|
	
	aMarsRover:= self marsRoverAt10FacingNorth.
	aMarsRover receiveCommands: 'bbb'.
	
	self assert: (aMarsRover isAt: 1@-3 facing: north).! !

!MarsRoverTests methodsFor: 'test' stamp: 'NB 5/15/2023 00:15:12'!
test09MarsRoverAtAnyPositionWithTwoFCommandsMovesForwardTwicePointingNorth
	|aMarsRover|
	
	aMarsRover:= self marsRoverAt10FacingNorth.
	aMarsRover receiveCommands: 'ff'.
	
	self assert: (aMarsRover isAt: 1@2 facing: north).! !

!MarsRoverTests methodsFor: 'test' stamp: 'NB 5/15/2023 00:15:20'!
test10MarsRoverAtAnyPositionWithManyFCommandsMovesForwardManyTimesPointingNorth
	|aMarsRover|
	
	aMarsRover:= self marsRoverAt10FacingNorth.
	aMarsRover receiveCommands: 'fff'.
	
	self assert: (aMarsRover isAt: 1@3 facing: north).! !

!MarsRoverTests methodsFor: 'test' stamp: 'NB 5/15/2023 00:15:27'!
test11MarsRoverAtAnyPositionWithFBCommandsMovesFrontAndBackManyTimesPointingNorth
	|aMarsRover|
	
	aMarsRover:= self marsRoverAt10FacingNorth.
	aMarsRover receiveCommands: 'fbbffb'.
	
	self assert: (aMarsRover isAt: 1@0 facing: north).! !

!MarsRoverTests methodsFor: 'test' stamp: 'NB 5/15/2023 00:06:57'!
test12MarsRoverReceivesInvalidCommandRaisesErrorAndStopsProcessingRemainingCommands
	|aMarsRover|
	
	aMarsRover:= self marsRoverAt10FacingNorth.
	
	
	self   should: [aMarsRover receiveCommands: 'fxfff'] 
		raise: Error 
		withExceptionDo: [:error | self assert: (aMarsRover isAt: 1@1 facing: north)]
		description: MarsRover invalidCommandDescription .! !

!MarsRoverTests methodsFor: 'test' stamp: 'NB 5/15/2023 00:18:44'!
test13MarsRoverAtAnyPositionWithFCommandMovesForwardOncePointingSouth
	|aMarsRover|
	
	aMarsRover:= MarsRover startAt: 0@0 facing: south.
	aMarsRover receiveCommands: 'f'.
	
	self assert: (aMarsRover isAt: 0@-1 facing: south).! !

!MarsRoverTests methodsFor: 'test' stamp: 'NB 5/15/2023 00:18:52'!
test14MarsRoverAtAnyPositionWithFCommandMovesBackwardsOncePointingSouth
	|aMarsRover|
	
	aMarsRover:= MarsRover startAt: 0@0 facing: south.
	aMarsRover receiveCommands: 'b'.
	
	self assert: (aMarsRover isAt: 0@1 facing: south).! !

!MarsRoverTests methodsFor: 'test' stamp: 'NB 5/15/2023 00:18:58'!
test15MarsRoverAtAnyPositionWithFCommandMovesForwardOncePointingEast
	|aMarsRover|
	
	aMarsRover:= MarsRover startAt: 0@0 facing: east.
	aMarsRover receiveCommands: 'f'.
	
	self assert: (aMarsRover isAt: 1@0 facing: east).! !

!MarsRoverTests methodsFor: 'test' stamp: 'NB 5/15/2023 00:19:04'!
test16MarsRoverAtAnyPositionWithFCommandMovesBackwardsOncePointingEast
	|aMarsRover|
	
	aMarsRover:= MarsRover startAt: 0@0 facing: east.
	aMarsRover receiveCommands: 'b'.
	
	self assert: (aMarsRover isAt: -1@0 facing: east).! !

!MarsRoverTests methodsFor: 'test' stamp: 'NB 5/15/2023 00:19:14'!
test17MarsRoverAtAnyPositionWithFCommandMovesForwardOncePointingWest
	|aMarsRover|
	
	aMarsRover:= MarsRover startAt: 0@0 facing: west.
	aMarsRover receiveCommands: 'f'.
	
	self assert: (aMarsRover isAt: -1@0 facing: west).! !

!MarsRoverTests methodsFor: 'test' stamp: 'NB 5/15/2023 00:19:22'!
test18MarsRoverAtAnyPositionWithlCommandRotatesLeftToWestWhenPointingNorth
	|aMarsRover|
	
	aMarsRover:= self marsRoverAt00FacingNorth.
	aMarsRover receiveCommands: 'l'.
	
	self assert: (aMarsRover isAt: 0@0 facing: west).! !

!MarsRoverTests methodsFor: 'test' stamp: 'NB 5/15/2023 00:19:28'!
test19MarsRoverAtAnyPositionWithlCommandRotatesLeftToSouthWhenPointingWest
	|aMarsRover|
	
	aMarsRover:= MarsRover startAt: 0@0 facing: west.
	aMarsRover receiveCommands: 'l'.
	
	self assert: (aMarsRover isAt: 0@0 facing: south).! !

!MarsRoverTests methodsFor: 'test' stamp: 'NB 5/15/2023 00:19:35'!
test20MarsRoverAtAnyPositionWithlCommandRotatesLeftToEastWhenPointingSouth
	|aMarsRover|
	
	aMarsRover:= MarsRover startAt: 0@0 facing: south.
	aMarsRover receiveCommands: 'l'.
	
	self assert: (aMarsRover isAt: 0@0 facing: east).! !

!MarsRoverTests methodsFor: 'test' stamp: 'NB 5/15/2023 00:19:42'!
test21MarsRoverAtAnyPositionWithlCommandRotatesLeftToNorthWhenPointingEast
	|aMarsRover|
	
	aMarsRover:= MarsRover startAt: 0@0 facing: east.
	aMarsRover receiveCommands: 'l'.
	
	self assert: (aMarsRover isAt: 0@0 facing: north).! !

!MarsRoverTests methodsFor: 'test' stamp: 'NB 5/15/2023 00:19:49'!
test22MarsRoverAtAnyPositionWithlCommandRotatesRightToEastWhenPointingNorth
	|aMarsRover|
	
	aMarsRover:= self marsRoverAt00FacingNorth.
	aMarsRover receiveCommands: 'r'.
	
	self assert: (aMarsRover isAt: 0@0 facing: east).! !

!MarsRoverTests methodsFor: 'test' stamp: 'NB 5/15/2023 00:19:56'!
test23MarsRoverAtAnyPositionWithlCommandRotatesRightToSouthWhenPointingEast
	|aMarsRover|
	
	aMarsRover:= MarsRover startAt: 0@0 facing: east.
	aMarsRover receiveCommands: 'r'.
	
	self assert: (aMarsRover isAt: 0@0 facing: south).! !

!MarsRoverTests methodsFor: 'test' stamp: 'NB 5/15/2023 00:20:02'!
test24MarsRoverAtAnyPositionWithlCommandRotatesRightToWestWhenPointingSouth
	|aMarsRover|
	
	aMarsRover:= MarsRover startAt: 0@0 facing: south.
	aMarsRover receiveCommands: 'r'.
	
	self assert: (aMarsRover isAt: 0@0 facing: west).! !

!MarsRoverTests methodsFor: 'test' stamp: 'NB 5/15/2023 00:20:09'!
test25MarsRoverAtAnyPositionWithlCommandRotatesRightToNorthWhenPointingWest
	|aMarsRover|
	
	aMarsRover:= MarsRover startAt: 0@0 facing: west.
	aMarsRover receiveCommands: 'r'.
	
	self assert: (aMarsRover isAt: 0@0 facing: north).! !


!MarsRoverTests methodsFor: 'mars rover' stamp: 'NB 5/15/2023 00:05:50'!
marsRoverAt00FacingNorth

	^ MarsRover startAt: 0@0 facing: north! !

!MarsRoverTests methodsFor: 'mars rover' stamp: 'NB 5/15/2023 00:06:57'!
marsRoverAt10FacingNorth

	^ MarsRover startAt: 1@0 facing: north! !


!classDefinition: #CardinalPoint category: 'MarsRover'!
Object subclass: #CardinalPoint
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CardinalPoint methodsFor: 'direction' stamp: 'NB 5/14/2023 21:20:09'!
point

	self subclassResponsibility ! !


!CardinalPoint methodsFor: 'comparing' stamp: 'NB 5/14/2023 22:41:35'!
= anObject

	^self class = anObject class.! !


!CardinalPoint methodsFor: 'rotation' stamp: 'NB 5/14/2023 22:53:35'!
rotate90DegreesToLeft

	self subclassResponsibility ! !

!CardinalPoint methodsFor: 'rotation' stamp: 'NB 5/14/2023 23:14:04'!
rotate90DegreesToRight

	self subclassResponsibility ! !


!classDefinition: #East category: 'MarsRover'!
CardinalPoint subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'direction' stamp: 'NB 5/14/2023 21:20:09'!
point

	^1@0! !


!East methodsFor: 'rotation' stamp: 'NB 5/14/2023 22:57:23'!
rotate90DegreesToLeft
	
	^North new.! !

!East methodsFor: 'rotation' stamp: 'NB 5/14/2023 23:16:04'!
rotate90DegreesToRight

	^South new.! !


!classDefinition: #North category: 'MarsRover'!
CardinalPoint subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'direction' stamp: 'NB 5/14/2023 21:20:10'!
point

	^0@1! !


!North methodsFor: 'rotation' stamp: 'NB 5/14/2023 22:54:07'!
rotate90DegreesToLeft

	^West new! !

!North methodsFor: 'rotation' stamp: 'NB 5/14/2023 23:14:33'!
rotate90DegreesToRight

	^East new! !


!classDefinition: #South category: 'MarsRover'!
CardinalPoint subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'direction' stamp: 'NB 5/14/2023 21:20:10'!
point

	^0@-1! !


!South methodsFor: 'rotation' stamp: 'NB 5/14/2023 22:56:37'!
rotate90DegreesToLeft
	
	^East new.! !

!South methodsFor: 'rotation' stamp: 'NB 5/14/2023 23:16:17'!
rotate90DegreesToRight

	^West new! !


!classDefinition: #West category: 'MarsRover'!
CardinalPoint subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'rotation' stamp: 'NB 5/14/2023 22:54:29'!
rotate90DegreesToLeft

	^South new.! !

!West methodsFor: 'rotation' stamp: 'NB 5/14/2023 23:17:33'!
rotate90DegreesToRight
	
	^North new.! !


!West methodsFor: 'direction' stamp: 'NB 5/14/2023 22:01:34'!
point
	^-1@0! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'xyPosition facing commands'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'moving - private' stamp: 'NB 5/15/2023 00:24:50'!
processCommand: aCommand

	(commands at: aCommand) value! !


!MarsRover methodsFor: 'commands' stamp: 'NB 5/14/2023 23:20:24'!
receiveCommands: aSequenceOfCommands 

	
	aSequenceOfCommands do: [:aCommand | 
			
		self assertCommandIsValid: aCommand.
		self processCommand: aCommand  
	]. ! !


!MarsRover methodsFor: 'initilization' stamp: 'NB 5/15/2023 00:26:21'!
initializeAt: aXYPoint facing: aCardinalPoint 
	
	xyPosition:=aXYPoint.
	facing:=aCardinalPoint.
	
	commands:= Dictionary new.
	commands at: $f put: [xyPosition := xyPosition + facing point.].
	commands at: $b put: [xyPosition := xyPosition - facing point].
	commands at: $l put: [facing:= facing rotate90DegreesToLeft].
	commands at: $r put: [facing:= facing rotate90DegreesToRight].! !


!MarsRover methodsFor: 'inspecting' stamp: 'am 5/13/2023 15:04:10'!
isAt: aXYPoint facing: aCardinalPoint
	^ xyPosition = aXYPoint and: facing = aCardinalPoint.! !


!MarsRover methodsFor: 'assertions' stamp: 'NB 5/15/2023 00:24:15'!
assertCommandIsValid: aCommand

	^(commands includesKey: aCommand) ifFalse: [self error: self class invalidCommandDescription]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'error description' stamp: 'NB 5/14/2023 20:57:52'!
invalidCommandDescription
	
	^'Comando invalido'.! !


!MarsRover class methodsFor: 'instance creation' stamp: 'am 5/13/2023 14:40:24'!
startAt: aXYPoint facing: aCardinalPoint
	^self new initializeAt: aXYPoint facing: aCardinalPoint! !
