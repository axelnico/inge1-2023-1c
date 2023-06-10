!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testSupport'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'NB 6/10/2023 19:31:27'!
setUp

	testSupport := StoreTestObjectFactory new.! !

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
	instanceVariableNames: 'testSupport debitFunctionality creditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'NB 6/10/2023 18:59:36'!
debit: anAmount from: aCreditCard

	^debitFunctionality value: anAmount value: aCreditCard.

	

	! !

!CashierTest methodsFor: 'tests' stamp: 'NB 6/10/2023 19:36:25'!
setUp

	testSupport := StoreTestObjectFactory new.
	debitFunctionality := [:amount :aCreditCard].
	creditCard:= CreditCard number: '1111111111111111' expiresOn: (March ofYear: 2023).

	! !

!CashierTest methodsFor: 'tests' stamp: 'NB 6/10/2023 19:43:37'!
test01CannotCheckoutAnEmptyCart

	|salesBook|
	salesBook:= OrderedCollection new.
	
	self should: [(Cashier 
				for: testSupport createCart 
				withCreditCard: creditCard 
				on: (March ofYear: 2023) 
				withMerchantProcessor: self 
				registerOn: salesBook) ]
	 	raise: Error - MessageNotUnderstood 
	  	withExceptionDo: [:anError | self assert: Cashier emptyCartErrorDescription equals: anError messageText.
							self assert: salesBook isEmpty. ].! !

!CashierTest methodsFor: 'tests' stamp: 'NB 6/10/2023 19:44:01'!
test02CashierCanCheckoutACartWithOneValidItem

	|aCart aSalesBook|
	aCart:= testSupport createCart .
	aCart add: testSupport itemSellByTheStore.
	aSalesBook:= OrderedCollection new.
	
	self assert: 10 equals: ((Cashier 
						for: aCart 
						withCreditCard: creditCard 
						on: (March ofYear: 2023) 
						withMerchantProcessor: self 
						registerOn: aSalesBook ) checkout).
	self assert: aSalesBook includes: 'Sale for 10 with credit card 1111111111111111'.
	! !

!CashierTest methodsFor: 'tests' stamp: 'NB 6/10/2023 19:44:39'!
test03CashierCanCheckoutACartWithSeveralValidItems

	|aCart aSalesBook|
	aCart:= testSupport createCart .
	aCart add:2 of: testSupport itemSellByTheStore.
	aSalesBook:= OrderedCollection new.
	
	self assert: 20 equals: ((Cashier 
						for: aCart 
						withCreditCard: creditCard 
						on: (March ofYear: 2023) 
						withMerchantProcessor: self 
						registerOn: aSalesBook) checkout).
	self assert: aSalesBook includes: 'Sale for 20 with credit card 1111111111111111'.
	! !

!CashierTest methodsFor: 'tests' stamp: 'NB 6/10/2023 19:44:59'!
test04CannotCheckoutACartWithAnExpiredCreditCard

	|aCart salesBook|
	aCart:= testSupport createCart .
	aCart add:2 of: testSupport itemSellByTheStore.
	salesBook:= OrderedCollection new.
	
	self should: [Cashier
				 for: aCart 
				withCreditCard: creditCard 
				on: (June ofYear: 2023) 
				withMerchantProcessor: self 
				registerOn: OrderedCollection new]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: Cashier expiredCreditCardErrorDescription equals: anError messageText. self assert: salesBook isEmpty.]
	! !

!CashierTest methodsFor: 'tests' stamp: 'NB 6/10/2023 19:45:22'!
test05CannotCheckoutACartWithACreditCardWithoutFunds

	|aCart cashier aSalesBook|
	aCart:= testSupport createCart .
	aCart add:2 of: testSupport itemSellByTheStore.
	aSalesBook:= OrderedCollection new.
	debitFunctionality := [:amount :aCreditCard | self error: Cashier creditCardWithoutFundsErrorDescription ].
	
	cashier:= Cashier 
				for: aCart 
				withCreditCard: creditCard 
				on: (March ofYear: 2023) 
				withMerchantProcessor: self 
				registerOn: OrderedCollection new.
	self should: [cashier checkout ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: Cashier creditCardWithoutFundsErrorDescription equals: anError messageText. self assert: aSalesBook isEmpty.]
	! !

!CashierTest methodsFor: 'tests' stamp: 'NB 6/10/2023 19:45:48'!
test06CashierCanCheckoutAndChargeWithAValidCreditCardAndMerchantProcessor

	|aCart cashier amountDebited creditCardDebited|
	aCart:= testSupport createCart .
	aCart add:2 of: testSupport itemSellByTheStore.
	debitFunctionality := [:amount :aCreditCard | amountDebited := amount. creditCardDebited := aCreditCard].
	
	cashier:= Cashier 
				for: aCart 
				withCreditCard: creditCard 
				on: (March ofYear: 2023) 
				withMerchantProcessor: self 
				registerOn: OrderedCollection new.
	self assert: 20 equals: cashier checkout.
	self assert: amountDebited equals: 20.	self assert: creditCardDebited equals: creditCard.
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
	instanceVariableNames: 'cart total creditCard merchantProcessor salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'NB 6/10/2023 19:15:47'!
initializeFor: aCart  withCreditCard: aCreditCard withMerchantProcessor: aMerchantProcessor registerOn: aSalesBook  
	
	cart := aCart.
	creditCard:= aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook:= aSalesBook.! !


!Cashier methodsFor: 'assertions' stamp: 'NB 6/8/2023 20:12:56'!
assertCartIsNotEmpty

	^ cart isEmpty ifTrue: [self error: self class emptyCartErrorDescription ]! !


!Cashier methodsFor: 'checkout' stamp: 'NB 6/8/2023 21:19:19'!
add: anItemSubtotal
	
	total := total + anItemSubtotal.
	! !

!Cashier methodsFor: 'checkout' stamp: 'NB 6/10/2023 19:22:41'!
checkout
	
	total:= 0.
	
	cart total: self.
	
	salesBook add: 'Sale for ', total asString, ' with credit card ' , creditCard number asString.
	
	merchantProcessor debit: total from: creditCard .
	
	^total.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'NB 6/10/2023 19:40:24'!
for: aCart withCreditCard: aCreditCard on: aDate withMerchantProcessor: aMerchantProcessor registerOn: aSalesBook   

	self assertCartIsNotEmpty: aCart.
	
	self assertCreditCard: aCreditCard isNotExpired: aDate.
	
	^self new initializeFor: aCart withCreditCard: aCreditCard withMerchantProcessor: aMerchantProcessor registerOn: aSalesBook.! !


!Cashier class methodsFor: 'error description' stamp: 'NB 6/10/2023 19:42:05'!
creditCardWithoutFundsErrorDescription
	
	^'Cannot checkout with an credit card without funds'.! !

!Cashier class methodsFor: 'error description' stamp: 'NB 6/8/2023 20:12:45'!
emptyCartErrorDescription
	
	^'Cannot checkout an empty cart'.! !

!Cashier class methodsFor: 'error description' stamp: 'NB 6/10/2023 19:40:54'!
expiredCreditCardErrorDescription
	
	^'Cannot checkout with an expired credit card'.! !


!Cashier class methodsFor: 'assertions' stamp: 'NB 6/8/2023 21:25:53'!
assertCartIsNotEmpty: aCart

	^ aCart isEmpty ifTrue: [self error: self emptyCartErrorDescription ]! !

!Cashier class methodsFor: 'assertions' stamp: 'NB 6/10/2023 19:41:05'!
assertCreditCard: aCreditCard isNotExpired: aDate

	^(aCreditCard isExpired: aDate) ifTrue: [self error: self expiredCreditCardErrorDescription ].! !


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


!CreditCard methodsFor: 'testing' stamp: 'NB 6/10/2023 18:41:11'!
isExpired: aCurrentDate

	^monthOfYear < aCurrentDate.! !


!CreditCard methodsFor: 'accessing' stamp: 'NB 6/10/2023 19:18:01'!
number

	^creditCardNumber .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'NB 6/8/2023 21:40:32'!
number: aCreditCardNumber expiresOn: aMonthOfYear 
	
	^self new initializeNumber: aCreditCardNumber expiresOn: aMonthOfYear ! !


!classDefinition: #StoreTestObjectFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectFactory methodsFor: 'support' stamp: 'NB 6/8/2023 19:52:27'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog.! !

!StoreTestObjectFactory methodsFor: 'support' stamp: 'NB 6/8/2023 20:24:07'!
defaultCatalog
	
	|catalog|
	catalog:= Dictionary new.
	catalog at: self itemSellByTheStore put: 10.
	^catalog.! !

!StoreTestObjectFactory methodsFor: 'support' stamp: 'NB 6/8/2023 19:53:14'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectFactory methodsFor: 'support' stamp: 'NB 6/8/2023 19:53:31'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectFactory methodsFor: 'support' stamp: 'NB 6/10/2023 18:23:15'!
monthOfNextYear
	
	^ Month month: (Date today) monthIndex year: ((Date today) year + (Duration days:365)).! !
