!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'NB 6/6/2023 23:11:00'!
test01CreatingACartStartsEmpty

	self assert: Cart new isEmpty.	! !

!CartTest methodsFor: 'tests' stamp: 'NB 6/6/2023 23:15:50'!
test02AddingAnItemToCartMakesItNotEmpty

	|aCart|
	aCart:= Cart new.
	aCart add: '1123' quantity: 1.
	self deny: aCart isEmpty.	! !

!CartTest methodsFor: 'tests' stamp: 'NB 6/6/2023 23:37:35'!
test03CartHoldsItemsAdded

	|aCart|
	aCart:= Cart new.
	aCart add: '1123' quantity: 1.
	self assert: aCart includes: '1123'.! !

!CartTest methodsFor: 'tests' stamp: 'NB 6/6/2023 23:45:24'!
test04CannotAddANonPositiveAmountOfItemsToCart

	|aCart|
	aCart:= Cart new.
	self should: [aCart add: '1123' quantity: 0.] 
		raise: Error - MessageNotUnderstood  
		withExceptionDo: [:anError | self assert: aCart isEmpty.
							     self assert:Cart cannotAddANonPositiveAmountOfItemsDescription equals: anError messageText ].! !

!CartTest methodsFor: 'tests' stamp: 'NB 6/6/2023 23:46:54'!
test05CartHoldsAmountOfItemsAdded

	|aCart|
	aCart:= Cart new.
	aCart add: '1123' quantity: 1.
	self assert: (aCart quantityOf: '1123') equals: 1.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'testing' stamp: 'NB 6/6/2023 23:38:05'!
includes: aISBN 
	
	^items includes: aISBN.! !

!Cart methodsFor: 'testing' stamp: 'NB 6/6/2023 23:34:30'!
isEmpty
	
	^items isEmpty .! !

!Cart methodsFor: 'testing' stamp: 'NB 6/6/2023 23:47:33'!
quantityOf: aISBN 
	
	^items occurrencesOf: aISBN.! !


!Cart methodsFor: 'initialization' stamp: 'NB 6/6/2023 23:34:16'!
initialize

	items:= Bag new.! !


!Cart methodsFor: 'assertions' stamp: 'NB 6/6/2023 23:45:13'!
assertAmountIsStrictlyPositive: anAmount

	^ anAmount strictlyPositive ifFalse: [self error: self class cannotAddANonPositiveAmountOfItemsDescription ]! !


!Cart methodsFor: 'adding' stamp: 'NB 6/6/2023 23:43:44'!
add: aISBN quantity: anAmount 
	
	self assertAmountIsStrictlyPositive: anAmount.
	
	items add: aISBN  withOccurrences: anAmount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error description' stamp: 'NB 6/6/2023 23:44:56'!
cannotAddANonPositiveAmountOfItemsDescription

	^'Cannot add a non positive amount of items to cart'! !
