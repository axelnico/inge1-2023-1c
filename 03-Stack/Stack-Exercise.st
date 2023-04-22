!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'currentElementAtTheTop'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'NB 4/22/2023 01:37:02'!
initialize

	currentElementAtTheTop:= StackBaseElement new.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'NB 4/22/2023 01:34:48'!
isEmpty

	^currentElementAtTheTop isBase.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'NB 4/22/2023 01:35:24'!
pop

	|elementAtTop|
	elementAtTop:= currentElementAtTheTop element.
	currentElementAtTheTop:= currentElementAtTheTop elementBelow.
	^elementAtTop.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'NB 4/22/2023 01:35:41'!
push: anObjectToBeAddedAtTheTop

	currentElementAtTheTop:= StackPointerElement with: anObjectToBeAddedAtTheTop elementBelow: currentElementAtTheTop.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'NB 4/22/2023 01:35:48'!
size

	^currentElementAtTheTop count.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'NB 4/22/2023 01:35:52'!
top

	^currentElementAtTheTop element.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: 't top'!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/16/2021 17:39:43'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'NB 4/22/2023 01:45:04'!
prefixes: aStringPrefix inStack: anOOStackWithSentences

	! !


!classDefinition: #StackElement category: 'Stack-Exercise'!
Object subclass: #StackElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackElement methodsFor: 'as yet unclassified' stamp: 'NB 4/22/2023 00:47:28'!
count 

	self subclassResponsibility ! !

!StackElement methodsFor: 'as yet unclassified' stamp: 'NB 4/22/2023 00:55:32'!
element 

	self subclassResponsibility ! !

!StackElement methodsFor: 'as yet unclassified' stamp: 'NB 4/22/2023 00:59:36'!
elementBelow 

	self subclassResponsibility ! !

!StackElement methodsFor: 'as yet unclassified' stamp: 'NB 4/22/2023 00:55:37'!
isBase 

	self subclassResponsibility ! !


!classDefinition: #StackBaseElement category: 'Stack-Exercise'!
StackElement subclass: #StackBaseElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackBaseElement methodsFor: 'as yet unclassified' stamp: 'NB 4/22/2023 00:47:42'!
count

	^0.! !

!StackBaseElement methodsFor: 'as yet unclassified' stamp: 'NB 4/22/2023 00:57:37'!
element

	self error: OOStack stackEmptyErrorDescription.! !

!StackBaseElement methodsFor: 'as yet unclassified' stamp: 'NB 4/22/2023 00:58:43'!
elementBelow

	self error: OOStack stackEmptyErrorDescription.! !

!StackBaseElement methodsFor: 'as yet unclassified' stamp: 'NB 4/22/2023 00:56:34'!
isBase

	^true! !


!classDefinition: #StackPointerElement category: 'Stack-Exercise'!
StackElement subclass: #StackPointerElement
	instanceVariableNames: 'value elementBelow'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackPointerElement methodsFor: 'as yet unclassified' stamp: 'NB 4/22/2023 00:49:25'!
count

	^1 + elementBelow count.! !

!StackPointerElement methodsFor: 'as yet unclassified' stamp: 'NB 4/22/2023 00:54:13'!
element

	^value.! !

!StackPointerElement methodsFor: 'as yet unclassified' stamp: 'NB 4/22/2023 01:23:32'!
elementBelow

	^elementBelow ! !

!StackPointerElement methodsFor: 'as yet unclassified' stamp: 'NB 4/22/2023 01:19:57'!
initializeWith: anObjectPointedByAStack elementBelow: anObjectBelowPointedElement

	value:= anObjectPointedByAStack .
	elementBelow  := anObjectBelowPointedElement .
	! !

!StackPointerElement methodsFor: 'as yet unclassified' stamp: 'NB 4/22/2023 00:56:50'!
isBase

	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackPointerElement class' category: 'Stack-Exercise'!
StackPointerElement class
	instanceVariableNames: ''!

!StackPointerElement class methodsFor: 'as yet unclassified' stamp: 'NB 4/22/2023 01:06:02'!
with: anObjectPointedByAStack elementBelow: anObjectBelowPointedElement

	^(StackPointerElement new) initializeWith: anObjectPointedByAStack elementBelow: anObjectBelowPointedElement! !
