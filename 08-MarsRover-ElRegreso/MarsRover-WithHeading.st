!classDefinition: #MarsRoverObserverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverObserverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverObserverTest methodsFor: 'tests' stamp: 'NB 6/3/2023 17:53:46'!
test01MarsRoverLogPositionObservingWithOneMove
	
	|marsRover logTracer|
	marsRover:= MarsRover at: 1@1 heading: MarsRoverHeadingNorth .
	logTracer:= MarsRoverPositionLogObserver for: marsRover.
	marsRover process: 'f'.
	self assert: (OrderedCollection with: 1@2) equals: logTracer show.! !

!MarsRoverObserverTest methodsFor: 'tests' stamp: 'NB 6/3/2023 17:54:16'!
test02MarsRoverWindowPositionObservingWithOneMove
	
	|marsRover windowTracer|
	marsRover:= MarsRover at: 1@1 heading: MarsRoverHeadingNorth .
	windowTracer:= MarsRoverWindowPositionObserver for: marsRover.
	marsRover process: 'f'.
	self assert: 1@2 equals: windowTracer show.! !

!MarsRoverObserverTest methodsFor: 'tests' stamp: 'NB 6/3/2023 17:53:46'!
test03MarsRoverLogPositionObservingManyMoves
	
	|marsRover logTracer|
	marsRover:= MarsRover at: 1@1 heading: MarsRoverHeadingNorth .
	logTracer:= MarsRoverPositionLogObserver for: marsRover.
	marsRover process: 'ff'.
	self assert: (OrderedCollection with: 1@2 with: 1@3) equals: logTracer show.! !

!MarsRoverObserverTest methodsFor: 'tests' stamp: 'NB 6/3/2023 17:53:46'!
test04MarsRoverLogPositionObservingManyMovesWithDifferentMove
	
	|marsRover logTracer|
	marsRover:= MarsRover at: 1@1 heading: MarsRoverHeadingNorth .
	logTracer:= MarsRoverPositionLogObserver for: marsRover.
	marsRover process: 'bb'.
	self assert: (OrderedCollection with: 1@0 with: 1@-1) equals: logTracer show.! !

!MarsRoverObserverTest methodsFor: 'tests' stamp: 'NB 6/3/2023 17:54:16'!
test05MarsRoverWindowPositionObservingManyMoves
	
	|marsRover windowTracer|
	marsRover:= MarsRover at: 1@1 heading: MarsRoverHeadingNorth .
	windowTracer:= MarsRoverWindowPositionObserver for: marsRover.
	marsRover process: 'ff'.
	self assert: 1@3 equals: windowTracer show.! !

!MarsRoverObserverTest methodsFor: 'tests' stamp: 'NB 6/3/2023 17:53:36'!
test06MarsRoverLogHeadingObservingManyHeadsChanges
	
	|marsRover logTracer|
	marsRover:= MarsRover at: 1@1 heading: MarsRoverHeadingNorth .
	logTracer:= MarsRoverHeadingLogObserver for: marsRover.
	marsRover process: 'rlll'.
	self assert: (OrderedCollection 
				with: MarsRoverHeadingEast 
				with: MarsRoverHeadingNorth 
				with: MarsRoverHeadingWest 
				with: MarsRoverHeadingSouth) 
	    equals: logTracer show.! !

!MarsRoverObserverTest methodsFor: 'tests' stamp: 'NB 6/3/2023 17:53:25'!
test07MarsRoverHeadingAndLogObservingManyMoves
	
	|marsRover logTracer|
	marsRover:= MarsRover at: 1@1 heading: MarsRoverHeadingNorth .
	logTracer:= MarsRoverHeadingAndMovingLogObserver for: marsRover.
	marsRover process: 'fr'.
	self assert: (OrderedCollection 
				with: 1@2
				with: MarsRoverHeadingEast)
	    equals: logTracer show.! !

!MarsRoverObserverTest methodsFor: 'tests' stamp: 'NB 6/3/2023 17:54:05'!
test08MarsRoverWindowHeadingObservingManyMoves
	
	|marsRover windowTracer|
	marsRover:= MarsRover at: 1@1 heading: MarsRoverHeadingNorth .
	windowTracer:= MarsRoverWindowHeadingObserver for: marsRover.
	marsRover process: 'rlll'.
	self assert: MarsRoverHeadingSouth equals: windowTracer show.! !

!MarsRoverObserverTest methodsFor: 'tests' stamp: 'NB 6/3/2023 17:53:56'!
test09MarsRoverWindowPostionObservingManyMoves
	
	|marsRover windowTracer|
	marsRover:= MarsRover at: 1@1 heading: MarsRoverHeadingNorth .
	windowTracer:= MarsRoverWindowHeadingAndMovingObserver for: marsRover.
	marsRover process: 'frf'.
	self assert: MarsRoverHeadingEast equals: windowTracer heading.
	self assert: 2@2 equals: windowTracer position.! !

!MarsRoverObserverTest methodsFor: 'tests' stamp: 'NB 6/3/2023 17:53:46'!
test10MarsRoverCanObservePositionEvenIfMarsRoverRotates
	
	|marsRover logTracer|
	marsRover:= MarsRover at: 1@1 heading: MarsRoverHeadingNorth .
	logTracer:= MarsRoverPositionLogObserver for: marsRover.
	marsRover process: 'fr'.
	self assert: (OrderedCollection with: 1@2) equals: logTracer show.! !

!MarsRoverObserverTest methodsFor: 'tests' stamp: 'NB 6/3/2023 17:54:05'!
test11MarsRoverCanObserveLogAndWindowAtSameTime
	
	|marsRover logTracer windowTracer|
	marsRover:= MarsRover at: 1@1 heading: MarsRoverHeadingNorth .
	logTracer:= MarsRoverPositionLogObserver for: marsRover.
	windowTracer:= MarsRoverWindowHeadingObserver for: marsRover.
	marsRover process: 'fr'.
	self assert: (OrderedCollection with: 1@2) equals: logTracer show.
	self assert: MarsRoverHeadingEast equals: windowTracer show.! !

!MarsRoverObserverTest methodsFor: 'tests' stamp: 'NB 6/3/2023 17:54:16'!
test12MarsRoverCanStopObserving
	
	|marsRover windowTracer|
	marsRover:= MarsRover at: 1@1 heading: MarsRoverHeadingNorth .
	windowTracer:= MarsRoverWindowPositionObserver for: marsRover.
	marsRover process: 'ff'.
	windowTracer stopObserving.
	marsRover process: 'f'.
	self assert: 1@3 equals: windowTracer show.! !


!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head observers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'NB 6/1/2023 21:47:11'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self.
	observers:= OrderedCollection new.! !


!MarsRover methodsFor: 'heading' stamp: 'NB 6/3/2023 15:26:52'!
headEast
	
	head := MarsRoverHeadingEast for: self.
	self notifyHeadingChange: MarsRoverHeadingEast.! !

!MarsRover methodsFor: 'heading' stamp: 'NB 6/3/2023 15:27:09'!
headNorth
	
	head := MarsRoverHeadingNorth for: self.
	self notifyHeadingChange: MarsRoverHeadingNorth.! !

!MarsRover methodsFor: 'heading' stamp: 'NB 6/3/2023 15:27:20'!
headSouth
	
	head := MarsRoverHeadingSouth for: self.
	self notifyHeadingChange: MarsRoverHeadingSouth.! !

!MarsRover methodsFor: 'heading' stamp: 'NB 6/3/2023 15:25:47'!
headWest
	
	head := MarsRoverHeadingWest for: self.
	self notifyHeadingChange: MarsRoverHeadingWest.! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	head rotateLeft! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	head rotateRight! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:16:32'!
isAt: aPosition heading: aHeadingType

	^position = aPosition and: [ head isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'NB 6/3/2023 16:30:24'!
moveBackward
	
	head moveBackward.
	self notifyPositionChange.
	! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:15:01'!
moveEast
	
	position := position + (1@0)! !

!MarsRover methodsFor: 'moving' stamp: 'NB 6/3/2023 16:30:24'!
moveForward
	
	head moveForward.
	self notifyPositionChange.! !

!MarsRover methodsFor: 'moving' stamp: 'NB 6/1/2023 21:35:45'!
moveNorth
	
	position := position + (0@1).! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:13:34'!
moveSouth
	
	position := position + (0@-1)! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:15:32'!
moveWest
	
	position := position + (-1@0)! !


!MarsRover methodsFor: 'observing' stamp: 'NB 6/1/2023 21:44:04'!
attach: aMarsRoverObserver
	
	observers add: aMarsRoverObserver.
	! !

!MarsRover methodsFor: 'observing' stamp: 'NB 6/3/2023 17:33:13'!
dettach: aMarsRoverWindowPositionTracing 
	
	observers remove: aMarsRoverWindowPositionTracing ifAbsent: []. ! !

!MarsRover methodsFor: 'observing' stamp: 'NB 6/3/2023 17:52:10'!
notifyHeadingChange: aMarsRoverHeading

	^ observers do: [:aMarsRoverObserver | aMarsRoverObserver  updateHeading: aMarsRoverHeading]! !

!MarsRover methodsFor: 'observing' stamp: 'NB 6/3/2023 17:52:35'!
notifyPositionChange

	^ observers do: [:aMarsRoverObserver | aMarsRoverObserver  updatePosition: position]! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !


!classDefinition: #MarsRoverObserver category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverObserver
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverObserver methodsFor: 'observing' stamp: 'NB 6/3/2023 17:50:30'!
stopObserving
	marsRover dettach: self.! !

!MarsRoverObserver methodsFor: 'observing' stamp: 'NB 6/3/2023 17:52:10'!
updateHeading: aMarsRoverHeading! !

!MarsRoverObserver methodsFor: 'observing' stamp: 'NB 6/3/2023 17:52:35'!
updatePosition: aPosition ! !


!classDefinition: #MarsRoverHeadingAndMovingLogObserver category: 'MarsRover-WithHeading'!
MarsRoverObserver subclass: #MarsRoverHeadingAndMovingLogObserver
	instanceVariableNames: 'positionsAndHeadings'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingAndMovingLogObserver methodsFor: 'initialization' stamp: 'NB 6/3/2023 15:48:42'!
initializeFor: aMarsRover 
	
	positionsAndHeadings := OrderedCollection new.
	marsRover := aMarsRover.
	marsRover attach: self.! !


!MarsRoverHeadingAndMovingLogObserver methodsFor: 'observing' stamp: 'NB 6/3/2023 15:48:05'!
show
	
	^positionsAndHeadings.! !

!MarsRoverHeadingAndMovingLogObserver methodsFor: 'observing' stamp: 'NB 6/3/2023 17:52:10'!
updateHeading: aMarsRoverHeading 
	
	positionsAndHeadings add: aMarsRoverHeading .! !

!MarsRoverHeadingAndMovingLogObserver methodsFor: 'observing' stamp: 'NB 6/3/2023 17:52:35'!
updatePosition: aPosition 
	
	positionsAndHeadings add: aPosition .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingAndMovingLogObserver class' category: 'MarsRover-WithHeading'!
MarsRoverHeadingAndMovingLogObserver class
	instanceVariableNames: ''!

!MarsRoverHeadingAndMovingLogObserver class methodsFor: 'instance creation' stamp: 'NB 6/3/2023 15:47:19'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingLogObserver category: 'MarsRover-WithHeading'!
MarsRoverObserver subclass: #MarsRoverHeadingLogObserver
	instanceVariableNames: 'headings'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingLogObserver methodsFor: 'initialization' stamp: 'NB 6/3/2023 15:23:13'!
initializeFor: aMarsRover 
	
	headings:= OrderedCollection new.
	marsRover := aMarsRover.
	marsRover attach: self.! !


!MarsRoverHeadingLogObserver methodsFor: 'observing' stamp: 'NB 6/3/2023 15:23:44'!
show
	
	^headings .! !

!MarsRoverHeadingLogObserver methodsFor: 'observing' stamp: 'NB 6/3/2023 17:52:10'!
updateHeading: aMarsRoverHeading


	headings add: aMarsRoverHeading.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingLogObserver class' category: 'MarsRover-WithHeading'!
MarsRoverHeadingLogObserver class
	instanceVariableNames: ''!

!MarsRoverHeadingLogObserver class methodsFor: 'instance creation' stamp: 'NB 6/3/2023 15:13:41'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverPositionLogObserver category: 'MarsRover-WithHeading'!
MarsRoverObserver subclass: #MarsRoverPositionLogObserver
	instanceVariableNames: 'positions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverPositionLogObserver methodsFor: 'initialization' stamp: 'NB 6/1/2023 21:47:20'!
initializeFor: aMarsRover 
	
	positions:= OrderedCollection new.
	marsRover := aMarsRover.
	marsRover attach: self.! !


!MarsRoverPositionLogObserver methodsFor: 'observing' stamp: 'NB 6/1/2023 21:25:47'!
show
	
	^positions.! !

!MarsRoverPositionLogObserver methodsFor: 'observing' stamp: 'NB 6/3/2023 17:52:35'!
updatePosition: aPosition
	
	^positions add: aPosition.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverPositionLogObserver class' category: 'MarsRover-WithHeading'!
MarsRoverPositionLogObserver class
	instanceVariableNames: ''!

!MarsRoverPositionLogObserver class methodsFor: 'instance creation' stamp: 'NB 6/1/2023 20:36:00'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverWindowHeadingAndMovingObserver category: 'MarsRover-WithHeading'!
MarsRoverObserver subclass: #MarsRoverWindowHeadingAndMovingObserver
	instanceVariableNames: 'position heading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindowHeadingAndMovingObserver methodsFor: 'initialization' stamp: 'NB 6/3/2023 16:01:28'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.
	marsRover attach: self.! !


!MarsRoverWindowHeadingAndMovingObserver methodsFor: 'observing' stamp: 'NB 6/3/2023 16:03:25'!
heading
	
	^heading! !

!MarsRoverWindowHeadingAndMovingObserver methodsFor: 'observing' stamp: 'NB 6/3/2023 16:03:37'!
position
	
	^position! !

!MarsRoverWindowHeadingAndMovingObserver methodsFor: 'observing' stamp: 'NB 6/3/2023 17:52:10'!
updateHeading: aMarsRoverHeading 
	
	heading:= aMarsRoverHeading! !

!MarsRoverWindowHeadingAndMovingObserver methodsFor: 'observing' stamp: 'NB 6/3/2023 17:52:35'!
updatePosition: aPosition 
	
	position:= aPosition.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverWindowHeadingAndMovingObserver class' category: 'MarsRover-WithHeading'!
MarsRoverWindowHeadingAndMovingObserver class
	instanceVariableNames: ''!

!MarsRoverWindowHeadingAndMovingObserver class methodsFor: 'instance creation' stamp: 'NB 6/3/2023 16:01:07'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverWindowHeadingObserver category: 'MarsRover-WithHeading'!
MarsRoverObserver subclass: #MarsRoverWindowHeadingObserver
	instanceVariableNames: 'heading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindowHeadingObserver methodsFor: 'initialization' stamp: 'NB 6/3/2023 15:54:35'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.
	marsRover attach: self.! !


!MarsRoverWindowHeadingObserver methodsFor: 'observing' stamp: 'NB 6/3/2023 15:55:14'!
show
	
	^heading .! !

!MarsRoverWindowHeadingObserver methodsFor: 'observing' stamp: 'NB 6/3/2023 17:52:10'!
updateHeading: aMarsRoverHeading 
	
	heading:= aMarsRoverHeading .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverWindowHeadingObserver class' category: 'MarsRover-WithHeading'!
MarsRoverWindowHeadingObserver class
	instanceVariableNames: ''!

!MarsRoverWindowHeadingObserver class methodsFor: 'instance creation' stamp: 'NB 6/3/2023 15:54:08'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverWindowPositionObserver category: 'MarsRover-WithHeading'!
MarsRoverObserver subclass: #MarsRoverWindowPositionObserver
	instanceVariableNames: 'position'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindowPositionObserver methodsFor: 'initialization' stamp: 'NB 6/1/2023 21:47:33'!
initializeFor: aMarsRover 

	marsRover := aMarsRover.
	marsRover attach: self.! !


!MarsRoverWindowPositionObserver methodsFor: 'observing' stamp: 'NB 6/1/2023 21:41:56'!
show
	^position.! !

!MarsRoverWindowPositionObserver methodsFor: 'observing' stamp: 'NB 6/3/2023 17:52:35'!
updatePosition: aPosition

	position:= aPosition.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverWindowPositionObserver class' category: 'MarsRover-WithHeading'!
MarsRoverWindowPositionObserver class
	instanceVariableNames: ''!

!MarsRoverWindowPositionObserver class methodsFor: 'instance creation' stamp: 'NB 6/1/2023 20:46:56'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !
