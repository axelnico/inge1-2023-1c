!classDefinition: #BacklogTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #BacklogTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!BacklogTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!BacklogTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!BacklogTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!BacklogTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!BacklogTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!BacklogTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!BacklogTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !

!BacklogTest methodsFor: 'tests' stamp: 'NB 5/20/2023 17:43:53'!
test08PortfolioBalanceIsZeroWhenCreated

	|  portfolio |
	
	
	portfolio := Portfolio new.	
	self assert: 0 equals: portfolio balance.
! !

!BacklogTest methodsFor: 'tests' stamp: 'NB 5/20/2023 17:44:43'!
test09PortfolioBalanceIsZeroWhenAccountHasAZeroBalance

	|  portfolio account |
	
	
	portfolio := Portfolio new.	
	account := ReceptiveAccount new.
	portfolio add: account.
	self assert: 0 equals: portfolio balance.
! !

!BacklogTest methodsFor: 'tests' stamp: 'NB 5/20/2023 17:46:17'!
test10PortfolioBalanceHasAccountsBalanceWhenOnlyAccountsAreAddedToPortfolio

	|  portfolio account |
	
	
	portfolio := Portfolio new.	
	account := ReceptiveAccount new.
	portfolio add: account.
	Deposit register: 100 on: account.
	self assert: 100 equals: portfolio balance.
! !

!BacklogTest methodsFor: 'tests' stamp: 'NB 5/20/2023 17:47:00'!
test11PortfolioBalanceIsCorrectWhenPortfoliosAreAddedToPortfolio

	|  portfolio account portfolioIntern accountOfPortfolioIntern|
	
	
	portfolio := Portfolio new.	
	account := ReceptiveAccount new.
	portfolio add: account.
	portfolioIntern := Portfolio new.
	accountOfPortfolioIntern:=  ReceptiveAccount new.
	Deposit register: 100 on: account.
	Deposit register: 200 on: accountOfPortfolioIntern.
	portfolioIntern add: accountOfPortfolioIntern .
	portfolio add: portfolioIntern .
	self assert: 300 equals: portfolio balance.
! !

!BacklogTest methodsFor: 'tests' stamp: 'NB 5/20/2023 17:47:54'!
test12EmptyPortfolioDoesNotHaveRegisteredTransactions

	|aPortfolio deposit |
	
	aPortfolio := Portfolio new.
	deposit := Deposit for: 200.
	self deny: (aPortfolio hasRegistered: deposit).! !

!BacklogTest methodsFor: 'tests' stamp: 'NB 5/20/2023 17:49:30'!
test13PortfolioRegistersTransactionsWhenOnlyAccountsAreAddedToPortfolio

	|aPortfolio deposit aAccout|
	
	aPortfolio := Portfolio new.
	
	aAccout := ReceptiveAccount new.
	aPortfolio add: aAccout .
	deposit := Deposit register: 100 on: aAccout .
	self assert: (aPortfolio hasRegistered: deposit).! !

!BacklogTest methodsFor: 'tests' stamp: 'NB 5/20/2023 17:49:58'!
test14PortfolioCorrectlyRegistersTransactionsWhenPortfoliosAreAddedToPortfolio

	|  portfolio account portfolioIntern accountOfPortfolioIntern deposit depositIntern|
	
	
	portfolio := Portfolio new.	
	account := ReceptiveAccount new.
	portfolio add: account.
	portfolioIntern := Portfolio new.
	accountOfPortfolioIntern:=  ReceptiveAccount new.
	deposit:= Deposit register: 100 on: account.
	depositIntern:= Deposit register: 200 on: accountOfPortfolioIntern.
	portfolioIntern add: accountOfPortfolioIntern .
	portfolio add: portfolioIntern .
	self assert: (portfolio hasRegistered: deposit).
	self assert: (portfolio hasRegistered: depositIntern).
	! !

!BacklogTest methodsFor: 'tests' stamp: 'NB 5/20/2023 17:50:32'!
test15EmptyPortfolioDoesNotHaveTransactions

	|  portfolio |
	
	
	portfolio := Portfolio new.	
	self assert: (portfolio transactions isEmpty).
	! !

!BacklogTest methodsFor: 'tests' stamp: 'NB 5/20/2023 17:51:04'!
test16PortfolioHasAccountTransactionsWhenOnlyAccountsAreAddedToPortfolio

	|  portfolio account deposit|
	
	
	portfolio := Portfolio new.	
	account := ReceptiveAccount new.
	deposit:= Deposit register: 100 on: account.
	portfolio add: account. 
	self assert: 1 equals: portfolio transactions size.
	self assert: (portfolio transactions includes: deposit).
	! !

!BacklogTest methodsFor: 'tests' stamp: 'NB 5/20/2023 17:51:36'!
test17PortolioHasPortfolioTransactionsWhenPortfoliosAreAddedToPortfolio

	|  portfolio account portfolioIntern accountOfPortfolioIntern deposit depositIntern|
	
	
	portfolio := Portfolio new.	
	account := ReceptiveAccount new.
	portfolio add: account.
	portfolioIntern := Portfolio new.
	accountOfPortfolioIntern:=  ReceptiveAccount new.
	deposit:= Deposit register: 100 on: account.
	depositIntern:= Deposit register: 200 on: accountOfPortfolioIntern.
	portfolioIntern add: accountOfPortfolioIntern .
	portfolio add: portfolioIntern .
	self assert: 2 equals: portfolio transactions size.
	self assert: (portfolio transactions includes: deposit).
	self assert: (portfolio transactions includes: depositIntern).
	! !

!BacklogTest methodsFor: 'tests' stamp: 'NB 5/20/2023 18:07:04'!
test18CannotAddTheSameAccountToAPortfolioMoreThanOneTime

	|  portfolio account |
	
	
	portfolio := Portfolio new.	
	account := ReceptiveAccount new.
	portfolio add: account.
	
	self should: [portfolio add: account] raise: Error  withMessageText: Portfolio repeatedBackLogAddedError .
	! !

!BacklogTest methodsFor: 'tests' stamp: 'NB 5/20/2023 18:07:13'!
test19CannotAddAnAccountWhenAnotherPortfolioHasTheSameAccount

	|  portfolio account portfolio2|
	
	
	portfolio := Portfolio new.	
	account := ReceptiveAccount new.
	
	portfolio2 := Portfolio new.	
	portfolio2 add: account.
	
	portfolio add: portfolio2.
	
	self should: [portfolio add: account] raise: Error  withMessageText: Portfolio repeatedBackLogAddedError.
	! !

!BacklogTest methodsFor: 'tests' stamp: 'NB 5/20/2023 18:07:18'!
test20CannotAddAPortfolioThatHasAnAccountThatTheActualPortfolioAlreadyHas

	|  portfolio account portfolio2|
	
	
	portfolio := Portfolio new.	
	account := ReceptiveAccount new.
	
	portfolio add: account.
	
	portfolio2 := Portfolio new.	
	portfolio2 add: account.
	
	
	self should: [portfolio add: portfolio2] raise: Error  withMessageText: Portfolio repeatedBackLogAddedError.
	! !

!BacklogTest methodsFor: 'tests' stamp: 'NB 5/20/2023 18:07:24'!
test21CannotAddAPortfolioThatHasAnAccountThatOtherPortfolioHasAPortfolioWithTheSameAccount

	|  portfolio account portfolio2 portfolio3|
	
	
	portfolio := Portfolio new.	
	account := ReceptiveAccount new.
	
	portfolio2 := Portfolio new.	
	portfolio2 add: account.
	
	portfolio3 := Portfolio new.	
	portfolio3 add: account.
	
	portfolio add: portfolio2 .
	
	self should: [portfolio add: portfolio3] raise: Error  withMessageText: Portfolio repeatedBackLogAddedError.
	! !

!BacklogTest methodsFor: 'tests' stamp: 'NB 5/20/2023 18:07:29'!
test22CannotAddAPortfolioThatHasAPortfolioAlreadyAdded

	|  portfolio portfolio2 portfolio3|
	
	
	portfolio := Portfolio new.	
	
	portfolio2 := Portfolio new.	
	
	portfolio3 := Portfolio new.	

	portfolio add: portfolio3 .
	
	portfolio2 add: portfolio3.
	
	self should: [portfolio add: portfolio2] raise: Error  withMessageText: Portfolio repeatedBackLogAddedError.
	! !

!BacklogTest methodsFor: 'tests' stamp: 'NB 5/20/2023 18:07:34'!
test23CannotAddTheSamePortfolioToSelf

	|  portfolio account |
	
	
	portfolio := Portfolio new.	
	
	account := ReceptiveAccount new.
	
	portfolio add: account.
	
	self should: [portfolio add: portfolio] raise: Error  withMessageText: Portfolio repeatedBackLogAddedError.
	! !

!BacklogTest methodsFor: 'tests' stamp: 'NB 5/20/2023 18:07:42'!
test24CannotAddAnAccountThatPortfoliosParentAlreadyHas

	|  portfolio portfolio2 account  |
	
	
	portfolio := Portfolio new.	
	
	portfolio2 := Portfolio new.	
	
	account := ReceptiveAccount new.
	
	portfolio add: account.
	
	portfolio add: portfolio2 .
	
	self should: [portfolio2 add: account] raise: Error  withMessageText: Portfolio repeatedBackLogAddedError.
	! !

!BacklogTest methodsFor: 'tests' stamp: 'NB 5/20/2023 18:07:46'!
test25CannotAddAnAccountThatOneOfPortfoliosParentAlreadyHas

	|  portfolio portfolio2 portfolio3 account  |
	
	
	portfolio := Portfolio new.	
	
	portfolio2 := Portfolio new.	
	
	portfolio3 := Portfolio new.	
	
	account := ReceptiveAccount new.
	
	portfolio add: account.
	
	portfolio add: portfolio3 .
	
	portfolio2 add: portfolio3 .
	
	self should: [portfolio3 add: account] raise: Error  withMessageText: Portfolio repeatedBackLogAddedError.
	! !

!BacklogTest methodsFor: 'tests' stamp: 'NB 5/20/2023 18:07:53'!
test26CannotAddAnAccountThatOneOfTheRootsParentAlreadyHas

	|  portfolio portfolio2 portfolio3 portfolio4 account  |
	
	
	portfolio := Portfolio new.	
	
	portfolio2 := Portfolio new.	
	
	portfolio3 := Portfolio new.	
	
	portfolio4 := Portfolio new.	
	
	account := ReceptiveAccount new.
	
	portfolio add: account.
	
	portfolio add: portfolio3 .
	
	portfolio2 add: portfolio3 .
	
	portfolio3 add: portfolio4 .
	
	self should: [portfolio4 add: account] raise: Error  withMessageText: Portfolio repeatedBackLogAddedError.
	! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'balance' stamp: 'NB 5/17/2023 00:03:43'!
addToBalance: anAcumulatedBalance 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'balance' stamp: 'NB 5/15/2023 20:13:51'!
addToBalance: anAcumulatedBalance 
	
	^anAcumulatedBalance + self value.! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'NB 5/15/2023 20:14:04'!
addToBalance: anAcumulatedBalance 
	
	^anAcumulatedBalance - self value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Backlog category: 'Portfolio-Ejercicio'!
Object subclass: #Backlog
	instanceVariableNames: 'parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Backlog methodsFor: 'root - private' stamp: 'NB 5/20/2023 17:20:40'!
addAsParent: aPortfolio


	parents add: aPortfolio .! !

!Backlog methodsFor: 'root - private' stamp: 'NB 5/20/2023 17:22:33'!
rootParents


	^parents isEmpty ifTrue: [^OrderedCollection with: self] 
				     ifFalse: [^parents inject: OrderedCollection new addingAll: [:aBacklog | aBacklog rootParents ] ].! !


!Backlog methodsFor: 'childs - private' stamp: 'NB 5/20/2023 16:55:29'!
allChildBacklogs

	self subclassResponsibility ! !

!Backlog methodsFor: 'childs - private' stamp: 'NB 5/20/2023 16:54:55'!
hasABacklogInCommonWith: aBacklog


	^(self allChildBacklogs intersection: aBacklog allChildBacklogs) notEmpty! !


!Backlog methodsFor: 'balance' stamp: 'NB 5/20/2023 15:31:37'!
balance
	
	self subclassResponsibility ! !


!Backlog methodsFor: 'testing' stamp: 'NB 5/20/2023 17:33:13'!
hasRegistered: aTransaction

	self subclassResponsibility .! !


!Backlog methodsFor: 'initialization' stamp: 'NB 5/20/2023 17:20:58'!
initialize


	parents:= OrderedCollection new.! !


!Backlog methodsFor: 'transactions' stamp: 'NB 5/20/2023 17:33:49'!
transactions

	self subclassResponsibility .! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Backlog subclass: #Portfolio
	instanceVariableNames: 'backlogs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'NB 5/20/2023 15:32:02'!
balance
	
	^backlogs sum: [:aBacklog | aBacklog balance] ifEmpty: [0]! !


!Portfolio methodsFor: 'initialization' stamp: 'NB 5/20/2023 17:23:22'!
initialize
	
	backlogs := OrderedCollection new.
	super initialize .! !


!Portfolio methodsFor: 'adding' stamp: 'NB 5/21/2023 16:10:07'!
add: aBacklog

	self assertBacklogCanBeAdded: aBacklog.
		
	backlogs add: aBacklog.
	aBacklog addAsParent: self.
	! !

!Portfolio methodsFor: 'adding' stamp: 'NB 5/20/2023 16:56:19'!
includes: aBacklog

	^backlogs anySatisfy: [:anotherBacklog | anotherBacklog hasABacklogInCommonWith: aBacklog]! !


!Portfolio methodsFor: 'childs - private' stamp: 'NB 5/20/2023 16:50:57'!
allChildBacklogs
	
	
	^backlogs inject: (OrderedCollection with: self) addingAll: [:childBacklogs | childBacklogs allChildBacklogs].
	! !


!Portfolio methodsFor: 'transactions' stamp: 'NB 5/20/2023 15:32:46'!
transactions
	
	
	^backlogs inject: OrderedCollection new addingAll: [:aBacklog | aBacklog transactions].! !


!Portfolio methodsFor: 'testing' stamp: 'NB 5/20/2023 15:32:29'!
hasRegistered: aTransaction 
	
	
	^backlogs anySatisfy: [:aBacklog | aBacklog hasRegistered: aTransaction]
	! !


!Portfolio methodsFor: 'assertions' stamp: 'NB 5/21/2023 16:10:07'!
assertBacklogCanBeAdded: aBacklog

	^ (self rootParents anySatisfy: [:aRootParent | aRootParent includes: aBacklog ]) ifTrue: [self error: self class repeatedBackLogAddedError ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'NB 5/20/2023 18:06:18'!
repeatedBackLogAddedError

	^'El backlog ya se encuentra agregado'.! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Backlog subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NB 5/20/2023 17:26:56'!
initialize

	transactions := OrderedCollection new.
	super initialize .! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'NB 5/15/2023 20:13:13'!
balance

	^transactions  inject: 0 into: [:acumulatedBalance :aTransaction | aTransaction addToBalance: acumulatedBalance]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'childs - private' stamp: 'NB 5/20/2023 16:51:18'!
allChildBacklogs
	
	
	^OrderedCollection with: self.! !
