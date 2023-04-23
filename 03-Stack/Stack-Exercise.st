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
	instanceVariableNames: 'stack sentenceFinder'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'NB 4/23/2023 16:48:43'!
setUp

	stack:= OOStack new.
	sentenceFinder := SentenceFinderByPrefix for: stack.
	stack push: 'winter is coming'.
	stack push: 'winning is everything'.
	stack push: 'The winds of Winter'.
	stack push: 'Winter is here'.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'NB 4/23/2023 16:42:03'!
test01SentenceFinderReturnsOnlyOneSentenceWhenStackContainsOneSentenceWithPrefix

	| sentences |
	sentences := sentenceFinder selectSentencesThatStartWith: 'Wint'.
	self assert: sentences includes: 'Winter is here'.
	self assert: sentences size equals: 1.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'NB 4/23/2023 16:42:21'!
test02SentenceFinderReturnsOnlyTwoSentencesWhenStackContainsTwoSentencesWithPrefix

	| sentences |
	sentences := sentenceFinder selectSentencesThatStartWith: 'win'.
	self assert: sentences includes: 'winter is coming'.
	self assert: sentences includes: 'winning is everything'.
	self assert: sentences size equals: 2.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'NB 4/23/2023 16:42:31'!
test03SentenceFinderDoesNotReturnSentencesWhenStackDoesNotContainsSentencesWithPrefix

	| sentences |
	sentences := sentenceFinder selectSentencesThatStartWith: 'dog'.
	self assert: sentences isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'NB 4/23/2023 16:44:40'!
test04SentenceFinderDoesNotReturnSentencesWhenStackIsEmpty

	| emptyStack sentenceFinderForEmptyStack sentences |
	emptyStack := OOStack new.
	sentenceFinderForEmptyStack := SentenceFinderByPrefix for: emptyStack .
	sentences := sentenceFinderForEmptyStack selectSentencesThatStartWith: 'dog'.
	self assert: sentences isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'NB 4/23/2023 16:49:26'!
test05SentenceFinderDoesNotModifyStack

	| stackForCheckingModification sentenceFinderForStackCheckingModification |
	
	stackForCheckingModification := OOStack new.
	sentenceFinderForStackCheckingModification := SentenceFinderByPrefix for: stackForCheckingModification.
	stackForCheckingModification push: 'winning is everything'.
	stackForCheckingModification push: 'The winds of Winter'.
	sentenceFinderForStackCheckingModification selectSentencesThatStartWith: 'dog'.
	self assert: stackForCheckingModification pop equals: 'The winds of Winter'.
	self assert: stackForCheckingModification pop equals: 'winning is everything'.
	self assert: stackForCheckingModification isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'NB 4/23/2023 16:45:07'!
test06SentenceFinderIsCaseSensitive

	| sentences|
	sentences := sentenceFinder selectSentencesThatStartWith: 'the'.
	self assert: sentences isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'NB 4/23/2023 16:45:20'!
test07SentenceFinderShouldRaiseErrorIfPrefixIsEmpty

	self should: [sentenceFinder selectSentencesThatStartWith: '']
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText = SentenceFinderByPrefix prefixEmptyErrorDescription ].! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'NB 4/23/2023 16:45:26'!
test08SentenceFinderShouldRaiseErrorIfPrefixContainsSpaces

	self should: [sentenceFinder selectSentencesThatStartWith: 'The winds of Winter']
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText = SentenceFinderByPrefix prefixWithSpacesErrorDescription ].! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'currentElementAtTheTop'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'adding' stamp: 'NB 4/22/2023 01:35:41'!
push: anObjectToBeAddedAtTheTop

	currentElementAtTheTop:= StackPointerElement with: anObjectToBeAddedAtTheTop elementBelow: currentElementAtTheTop.! !


!OOStack methodsFor: 'initialization' stamp: 'NB 4/22/2023 01:37:02'!
initialize

	currentElementAtTheTop:= StackBaseElement new.! !


!OOStack methodsFor: 'testing' stamp: 'NB 4/22/2023 01:34:48'!
isEmpty

	^currentElementAtTheTop isBase.! !


!OOStack methodsFor: 'accessing' stamp: 'NB 4/22/2023 01:35:48'!
size

	^currentElementAtTheTop count.! !

!OOStack methodsFor: 'accessing' stamp: 'NB 4/22/2023 01:35:52'!
top

	^currentElementAtTheTop element.! !


!OOStack methodsFor: 'removing' stamp: 'NB 4/22/2023 01:35:24'!
pop

	|elementAtTop|
	elementAtTop:= currentElementAtTheTop element.
	currentElementAtTheTop:= currentElementAtTheTop elementBelow.
	^elementAtTop.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: 't top'!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/16/2021 17:39:43'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'sentencesWithPrefix stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'NB 4/23/2023 15:39:06'!
initializeWith: anOOStack
	stack := anOOStack.! !


!SentenceFinderByPrefix methodsFor: 'private' stamp: 'NB 4/23/2023 16:27:25'!
assertPrefixIsValid: aStringPrefix

	aStringPrefix isEmpty ifTrue: [self error: self class prefixEmptyErrorDescription].
	(aStringPrefix includesSubString: ' ') ifTrue: [self error: self class prefixWithSpacesErrorDescription]! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'NB 4/23/2023 16:28:01'!
prefixes: aStringPrefix inStack: anOOStackWithSentences
	
	| elementAtTheTop 	|
	anOOStackWithSentences isEmpty ifFalse:
	[
		elementAtTheTop :=anOOStackWithSentences pop.
		(elementAtTheTop beginsWith: aStringPrefix) ifTrue: [sentencesWithPrefix add: elementAtTheTop] .
		self prefixes: aStringPrefix inStack: anOOStackWithSentences.
		anOOStackWithSentences push: elementAtTheTop. 
	].
	^sentencesWithPrefix.! !


!SentenceFinderByPrefix methodsFor: 'enumerating' stamp: 'NB 4/23/2023 16:27:31'!
selectSentencesThatStartWith: aStringPrefix

	self assertPrefixIsValid: aStringPrefix.
	
	sentencesWithPrefix := OrderedCollection new.
	^ self prefixes: aStringPrefix inStack: stack.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'instance creation' stamp: 'NB 4/23/2023 15:40:32'!
for: anOOStack
	^self new initializeWith: anOOStack.! !

!SentenceFinderByPrefix class methodsFor: 'instance creation' stamp: 'NB 4/23/2023 16:24:54'!
prefixEmptyErrorDescription
	
	^'Prefix should not be empty'.! !

!SentenceFinderByPrefix class methodsFor: 'instance creation' stamp: 'NB 4/23/2023 16:25:54'!
prefixWithSpacesErrorDescription
	
	^'Prefix should not contain spaces'.! !


!classDefinition: #StackElement category: 'Stack-Exercise'!
Object subclass: #StackElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackElement methodsFor: 'accessing' stamp: 'NB 4/22/2023 00:55:32'!
element 

	self subclassResponsibility ! !

!StackElement methodsFor: 'accessing' stamp: 'NB 4/22/2023 00:59:36'!
elementBelow 

	self subclassResponsibility ! !


!StackElement methodsFor: 'testing' stamp: 'NB 4/22/2023 00:55:37'!
isBase 

	self subclassResponsibility ! !


!StackElement methodsFor: 'enumerating' stamp: 'NB 4/22/2023 00:47:28'!
count 

	self subclassResponsibility ! !


!classDefinition: #StackBaseElement category: 'Stack-Exercise'!
StackElement subclass: #StackBaseElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackBaseElement methodsFor: 'enumerating' stamp: 'NB 4/22/2023 00:47:42'!
count

	^0.! !


!StackBaseElement methodsFor: 'accessing' stamp: 'NB 4/22/2023 00:57:37'!
element

	self error: OOStack stackEmptyErrorDescription.! !

!StackBaseElement methodsFor: 'accessing' stamp: 'NB 4/22/2023 00:58:43'!
elementBelow

	self error: OOStack stackEmptyErrorDescription.! !


!StackBaseElement methodsFor: 'testing' stamp: 'NB 4/22/2023 00:56:34'!
isBase

	^true! !


!classDefinition: #StackPointerElement category: 'Stack-Exercise'!
StackElement subclass: #StackPointerElement
	instanceVariableNames: 'value elementBelow'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackPointerElement methodsFor: 'as yet unclassified' stamp: 'NB 4/22/2023 01:19:57'!
initializeWith: anObjectPointedByAStack elementBelow: anObjectBelowPointedElement

	value:= anObjectPointedByAStack .
	elementBelow  := anObjectBelowPointedElement .
	! !


!StackPointerElement methodsFor: 'enumerating' stamp: 'NB 4/22/2023 00:49:25'!
count

	^1 + elementBelow count.! !


!StackPointerElement methodsFor: 'accessing' stamp: 'NB 4/22/2023 00:54:13'!
element

	^value.! !

!StackPointerElement methodsFor: 'accessing' stamp: 'NB 4/22/2023 01:23:32'!
elementBelow

	^elementBelow ! !


!StackPointerElement methodsFor: 'testing' stamp: 'NB 4/22/2023 00:56:50'!
isBase

	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackPointerElement class' category: 'Stack-Exercise'!
StackPointerElement class
	instanceVariableNames: ''!

!StackPointerElement class methodsFor: 'as yet unclassified' stamp: 'NB 4/22/2023 01:06:02'!
with: anObjectPointedByAStack elementBelow: anObjectBelowPointedElement

	^(StackPointerElement new) initializeWith: anObjectPointedByAStack elementBelow: anObjectBelowPointedElement! !
