!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NB 5/15/2023 19:48:52'!
test08

	|  portfolio |
	
	
	portfolio := Portfolio new.	
	self assert: 0 equals: portfolio balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NB 5/15/2023 19:51:18'!
test09

	|  portfolio account |
	
	
	portfolio := Portfolio new.	
	account := ReceptiveAccount new.
	portfolio add: account.
	self assert: 0 equals: portfolio balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NB 5/15/2023 20:59:37'!
test10

	|  portfolio account |
	
	
	portfolio := Portfolio new.	
	account := ReceptiveAccount new.
	portfolio add: account.
	Deposit register: 100 on: account.
	self assert: 100 equals: portfolio balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NB 5/15/2023 21:07:50'!
test11

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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NB 5/15/2023 21:14:19'!
test12

	|aPortfolio deposit |
	
	aPortfolio := Portfolio new.
	deposit := Deposit for: 200.
	self deny: (aPortfolio hasRegistered: deposit).! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NB 5/15/2023 21:19:58'!
test13

	|aPortfolio deposit aAccout|
	
	aPortfolio := Portfolio new.
	
	aAccout := ReceptiveAccount new.
	aPortfolio add: aAccout .
	deposit := Deposit register: 100 on: aAccout .
	self assert: (aPortfolio hasRegistered: deposit).! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NB 5/15/2023 21:21:45'!
test14

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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NB 5/15/2023 21:23:07'!
test15

	|  portfolio |
	
	
	portfolio := Portfolio new.	
	self assert: (portfolio transactions isEmpty).
	! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NB 5/15/2023 21:24:55'!
test16

	|  portfolio account deposit|
	
	
	portfolio := Portfolio new.	
	account := ReceptiveAccount new.
	deposit:= Deposit register: 100 on: account.
	portfolio add: account. 
	self assert: 1 equals: portfolio transactions size.
	self assert: (portfolio transactions includes: deposit).
	! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NB 5/15/2023 21:27:08'!
test17

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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NB 5/15/2023 21:33:31'!
test18

	|  portfolio account |
	
	
	portfolio := Portfolio new.	
	account := ReceptiveAccount new.
	portfolio add: account.
	
	self should: [portfolio add: account] raise: Error  withMessageText: 'No se puede agregar la cuenta porque ya esta'.
	! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NB 5/15/2023 21:36:47'!
test19

	|  portfolio account portfolio2|
	
	
	portfolio := Portfolio new.	
	account := ReceptiveAccount new.
	portfolio add: account.
	
	portfolio2 := Portfolio new.	
	portfolio2 add: account.
	
	self should: [portfolio add: portfolio2] raise: Error  withMessageText: 'No se puede agregar la cuenta porque ya esta'.
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
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Backlog subclass: #Portfolio
	instanceVariableNames: 'accounts portfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'NB 5/15/2023 21:05:48'!
balance
	
	^(accounts sum: [:anAccount | anAccount balance] ifEmpty: [0]) + (portfolios sum: [:aPortfolio | aPortfolio balance] ifEmpty: [0])! !


!Portfolio methodsFor: 'initialization' stamp: 'NB 5/15/2023 21:04:55'!
initialize
	
	accounts:= OrderedCollection new.
	portfolios := OrderedCollection new.! !


!Portfolio methodsFor: 'adding' stamp: 'NB 5/18/2023 20:17:06'!
add: anObject 
	
	(anObject isKindOf: ReceptiveAccount) ifTrue: [
		(accounts includes: anObject) ifTrue: [self error: 'No se puede agregar la cuenta porque ya esta'].
		
		accounts add: anObject.
	].
	(anObject isKindOf: Portfolio ) ifTrue: [
		
		(accounts anySatisfy: [:anAccount | anObject includes: anAccount]) ifTrue: [self error: 'No se puede agregar la cuenta porque ya esta'].
		
		(portfolios anySatisfy: [:aPortfolio | aPortfolio includes: anObject]) ifTrue: [self error: 'No se puede agregar la cuenta porque ya esta'].
		
		portfolios add: anObject.
		
	].
	! !

!Portfolio methodsFor: 'adding' stamp: 'NB 5/18/2023 20:13:36'!
includes: anAccount
	
	^accounts includes: anAccount
	! !


!Portfolio methodsFor: 'xxxxx' stamp: 'NB 5/15/2023 21:22:34'!
hasRegistered: aTransaction 
	
	
	^(accounts anySatisfy: [:anAccount | anAccount hasRegistered: aTransaction]) or: [portfolios anySatisfy: [:aPortfolio | aPortfolio hasRegistered: aTransaction]]
	! !

!Portfolio methodsFor: 'xxxxx' stamp: 'NB 5/15/2023 21:30:06'!
transactions
	
	^(accounts inject: OrderedCollection new into: [:transactions :anAccount | transactions addAll: anAccount transactions;yourself]) addAll: (portfolios inject: OrderedCollection new into: [:transactions :aPortfolio | transactions addAll: aPortfolio transactions;yourself]);yourself.! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Backlog subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


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
