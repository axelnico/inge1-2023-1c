!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testSupport'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'NB 6/8/2023 19:55:27'!
setUp

	testSupport := TestSupport new.! !

!CartTest methodsFor: 'tests' stamp: 'NB 6/8/2023 19:55:37'!
test01NewCartsAreCreatedEmpty

	self assert: testSupport createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'NB 6/8/2023 19:57:36'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testSupport createCart.
	
	self 
		should: [ cart add: testSupport itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'NB 6/8/2023 19:57:50'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testSupport createCart.
	
	cart add: testSupport itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'NB 6/8/2023 19:58:00'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testSupport createCart.
	
	self 
		should: [cart add: 0 of: testSupport itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'NB 6/8/2023 19:58:09'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testSupport createCart.
	
	self 
		should: [cart add: 2 of: testSupport itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'NB 6/8/2023 19:58:21'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testSupport createCart.
	
	cart add: testSupport itemSellByTheStore.
	self assert: (cart includes: testSupport itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'NB 6/8/2023 19:58:27'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testSupport createCart.
	
	self deny: (cart includes: testSupport itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'NB 6/8/2023 19:58:35'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testSupport createCart.
	
	cart add: 2 of: testSupport itemSellByTheStore.
	self assert: (cart occurrencesOf: testSupport itemSellByTheStore) = 2! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testSupport'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'NB 6/8/2023 19:59:53'!
setUp

	testSupport := TestSupport new.

	! !

!CashierTest methodsFor: 'tests' stamp: 'NB 6/8/2023 21:48:49'!
test01CannotCheckoutAnEmptyCart

	self should: [(Cashier for: testSupport createCart withCreditCard: '1111111111111111' on: testSupport monthOfNextYear ) ]
	 raise: Error - MessageNotUnderstood 
	  withExceptionDo: [:anError | self assert: Cashier emptyCartErrorDescription equals: anError messageText ].! !

!CashierTest methodsFor: 'tests' stamp: 'NB 6/8/2023 21:48:55'!
test02CashierCanCheckoutACartWithOneValidItem

	|aCart|
	aCart:= testSupport createCart .
	aCart add: testSupport itemSellByTheStore.
	self assert: 10 equals: ((Cashier for: aCart withCreditCard: '1111111111111111' on: testSupport monthOfNextYear ) checkout).
	! !

!CashierTest methodsFor: 'tests' stamp: 'NB 6/8/2023 21:48:59'!
test03CashierCanCheckoutACartWithSeveralValidItems

	|aCart|
	aCart:= testSupport createCart .
	aCart add:2 of: testSupport itemSellByTheStore.
	self assert: 20 equals: ((Cashier for: aCart withCreditCard: '1111111111111111' on: testSupport monthOfNextYear ) checkout)
	! !

!CashierTest methodsFor: 'tests' stamp: 'NB 6/8/2023 21:43:35'!
test04CannotCheckoutACartWithAnExpiredCreditCard

	|aCart creditCard|
	aCart:= testSupport createCart .
	aCart add:2 of: testSupport itemSellByTheStore.
	creditCard:= CreditCard number: '1111111111111111' expiresOn: (March ofYear: 2023).
	self should: [Cashier for: aCart withCreditCard: creditCard on: nil]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: 'Cannot checkout with an expired credit card' equals: anError messageText]
	! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'NB 6/8/2023 20:25:37'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'NB 6/8/2023 21:02:41'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'NB 6/8/2023 21:04:49'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.
	
	items add: anItem withOccurrences: aQuantity.
! !


!Cart methodsFor: 'checkout' stamp: 'NB 6/8/2023 21:20:20'!
total: aCashier

	items do: [:anItem | aCashier add: (catalog at: anItem)].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart total creditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'NB 6/8/2023 21:23:26'!
initializeFor: aCart  withCreditCard: aCreditCard
	cart := aCart.
	creditCard:= aCreditCard.! !


!Cashier methodsFor: 'assertions' stamp: 'NB 6/8/2023 20:12:56'!
assertCartIsNotEmpty

	^ cart isEmpty ifTrue: [self error: self class emptyCartErrorDescription ]! !


!Cashier methodsFor: 'checkout' stamp: 'NB 6/8/2023 21:19:19'!
add: anItemSubtotal
	
	total := total + anItemSubtotal.
	! !

!Cashier methodsFor: 'checkout' stamp: 'NB 6/8/2023 21:27:24'!
checkout
	
	total:= 0.
	
	cart total: self.
	
	^total.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'NB 6/8/2023 21:43:35'!
for: aCart withCreditCard: aCreditCard on: aDate 

	self assertCartIsNotEmpty: aCart.
	
	^self new initializeFor: aCart withCreditCard: aCreditCard.! !


!Cashier class methodsFor: 'error description' stamp: 'NB 6/8/2023 20:12:45'!
emptyCartErrorDescription
	
	^'Cannot checkout an empty cart'.! !


!Cashier class methodsFor: 'assertions' stamp: 'NB 6/8/2023 21:25:53'!
assertCartIsNotEmpty: aCart

	^ aCart isEmpty ifTrue: [self error: self emptyCartErrorDescription ]! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'creditCardNumber monthOfYear'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'NB 6/8/2023 21:40:48'!
initializeNumber: aCreditCardNumber expiresOn: aMonthOfYear 

	creditCardNumber := aCreditCardNumber.
	monthOfYear := aMonthOfYear.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'NB 6/8/2023 21:40:32'!
number: aCreditCardNumber expiresOn: aMonthOfYear 
	
	^self new initializeNumber: aCreditCardNumber expiresOn: aMonthOfYear ! !


!classDefinition: #TestSupport category: 'TusLibros'!
Object subclass: #TestSupport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TestSupport methodsFor: 'support' stamp: 'NB 6/8/2023 19:52:27'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog.! !

!TestSupport methodsFor: 'support' stamp: 'NB 6/8/2023 20:24:07'!
defaultCatalog
	
	|catalog|
	catalog:= Dictionary new.
	catalog at: self itemSellByTheStore put: 10.
	^catalog.! !

!TestSupport methodsFor: 'support' stamp: 'NB 6/8/2023 19:53:14'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!TestSupport methodsFor: 'support' stamp: 'NB 6/8/2023 19:53:31'!
itemSellByTheStore
	
	^ 'validBook'! !

!TestSupport methodsFor: 'support' stamp: 'NB 6/8/2023 21:51:56'!
monthOfNextYear
	
	^ Month month: (Date today) monthIndex year: ((Date today) year - 1).! !
