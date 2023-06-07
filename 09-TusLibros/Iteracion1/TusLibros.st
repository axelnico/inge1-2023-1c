!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'am 6/7/2023 18:10:04'!
test01CreatingACartStartsEmpty
	
	|aCart inventory|
	
	inventory:= Inventory newWith: (OrderedCollection with: '1123').
	aCart:= Cart forInventory: inventory.
	self assert: aCart isEmpty.	! !

!CartTest methodsFor: 'tests' stamp: 'am 6/7/2023 18:09:41'!
test02AddingAnItemToCartMakesItNotEmpty

	|aCart inventory|
	
	inventory:= Inventory newWith: (OrderedCollection with: '1123').
	aCart:= Cart forInventory: inventory.
	aCart add: '1123' quantity: 1.
	self deny: aCart isEmpty.	! !

!CartTest methodsFor: 'tests' stamp: 'am 6/7/2023 18:08:22'!
test03CartHoldsItemsAdded

	|aCart inventory|
	
	inventory:= Inventory newWith: (OrderedCollection with: '1123').
	aCart:= Cart forInventory: inventory.
	aCart add: '1123' quantity: 1.
	self assert: aCart includes: '1123'.! !

!CartTest methodsFor: 'tests' stamp: 'am 6/7/2023 18:07:56'!
test04CannotAddANonPositiveAmountOfItemsToCart

	|aCart inventory|
	
	inventory:= Inventory newWith: (OrderedCollection with: '1123').
	aCart:= Cart forInventory: inventory.
	self should: [aCart add: '1123' quantity: 0.] 
		raise: Error - MessageNotUnderstood  
		withExceptionDo: [:anError | self assert: aCart isEmpty.
							     self assert:Cart cannotAddANonPositiveAmountOfItemsDescription equals: anError messageText ].! !

!CartTest methodsFor: 'tests' stamp: 'am 6/7/2023 18:06:56'!
test05CartHoldsAmountOfItemsAdded
	
	|aCart inventory|
	
	inventory:= Inventory newWith: (OrderedCollection with: '1123').
	aCart:= Cart forInventory: inventory.
	aCart add: '1123' quantity: 1.
	self assert: (aCart quantityOf: '1123') equals: 1.! !

!CartTest methodsFor: 'tests' stamp: 'am 6/7/2023 17:53:16'!
test06CannotAddItemsThatAreNotOnInventory

	|aCart inventory|
	
	inventory:= Inventory newWith: (OrderedCollection with: 'book1' with: 'book2' with: 'book3').
	aCart:= Cart forInventory: inventory.
	self should: [aCart add: '1123' quantity: 1.] 
		raise: Error - MessageNotUnderstood  
		withExceptionDo: [:anError | self assert: aCart isEmpty.
							     self assert:Cart cannotAddAItemThatsNotOnCatalogo equals: anError messageText ].! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'items inventory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'testing' stamp: 'am 6/7/2023 18:09:03'!
includes: aISBN 
	
	^items includes: aISBN.! !

!Cart methodsFor: 'testing' stamp: 'am 6/7/2023 17:15:18'!
isEmpty
	
	^items isEmpty .! !

!Cart methodsFor: 'testing' stamp: 'am 6/7/2023 18:04:03'!
isOnCatalogo: aISBN 
	
	^inventory isOnCatalogo: aISBN.! !

!Cart methodsFor: 'testing' stamp: 'am 6/7/2023 17:15:18'!
quantityOf: aISBN 
	
	^items occurrencesOf: aISBN.! !


!Cart methodsFor: 'initialization' stamp: 'am 6/7/2023 17:49:58'!
initializeForInventory: aInventory 
	inventory := aInventory.
	items:= Bag new.! !


!Cart methodsFor: 'assertions' stamp: 'am 6/7/2023 17:15:18'!
assertAmountIsStrictlyPositive: anAmount

	^ anAmount strictlyPositive ifFalse: [self error: self class cannotAddANonPositiveAmountOfItemsDescription ]! !

!Cart methodsFor: 'assertions' stamp: 'am 6/7/2023 18:06:06'!
assertISBNIsOnCatalogo: aISBN

	^ (inventory isOnCatalogo: aISBN) ifFalse: [self error: self class cannotAddAItemThatsNotOnCatalogo]. ! !


!Cart methodsFor: 'adding' stamp: 'am 6/7/2023 17:35:59'!
add: aISBN quantity: anAmount 
	
	self assertAmountIsStrictlyPositive: anAmount.
	self assertISBNIsOnCatalogo: aISBN.	
	items add: aISBN  withOccurrences: anAmount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error description' stamp: 'am 6/7/2023 17:39:57'!
cannotAddAItemThatsNotOnCatalogo

	^'Cannot add a item thats not on catalogo'.! !

!Cart class methodsFor: 'error description' stamp: 'am 6/7/2023 17:15:18'!
cannotAddANonPositiveAmountOfItemsDescription

	^'Cannot add a non positive amount of items to cart'! !


!Cart class methodsFor: 'instance creation' stamp: 'am 6/7/2023 17:49:26'!
forInventory: aInventory
	
	^self new initializeForInventory: aInventory! !


!classDefinition: #Inventory category: 'TusLibros'!
Object subclass: #Inventory
	instanceVariableNames: 'catalogo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Inventory methodsFor: 'inicialization' stamp: 'am 6/7/2023 17:58:28'!
isOnCatalogo: aItem
	^catalogo includes: aItem! !

!Inventory methodsFor: 'inicialization' stamp: 'am 6/7/2023 17:32:29'!
with: aCatalogo
	catalogo := aCatalogo ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Inventory class' category: 'TusLibros'!
Inventory class
	instanceVariableNames: ''!

!Inventory class methodsFor: 'class initialization' stamp: 'am 6/7/2023 18:05:20'!
newWith: aCatalgo 
	^self new with:aCatalgo.! !

