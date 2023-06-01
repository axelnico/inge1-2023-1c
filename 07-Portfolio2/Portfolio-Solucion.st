!classDefinition: #PortfolioReportTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioReportTest methodsFor: 'tests' stamp: 'NB 6/1/2023 00:44:20'!
test01NewPortfolioPortfolioAccountSummaryReportIsOk

	self assert: (OrderedCollection with:'Portfolio de la familia')
		 equals: (PortfolioSummaryReport for: (Portfolio named: 'Portfolio de la familia')) compute.! !

!PortfolioReportTest methodsFor: 'tests' stamp: 'NB 6/1/2023 00:44:20'!
test02OneLevelDeepPortfolioPortfolioAccountSummaryReportIsOk


	|myAccount familyPortfolio|
	myAccount := ReceptiveAccount named: 'Cuenta mia'.
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount.

	self assert: (OrderedCollection with:'Portfolio de la familia' with: ' Cuenta mia')
		 equals: (PortfolioSummaryReport for: familyPortfolio) compute.! !

!PortfolioReportTest methodsFor: 'tests' stamp: 'NB 6/1/2023 00:44:20'!
test03ManyLevelDeepPortfolioPortfolioAccountSummaryReportIsOk


	|myAccount familyPortfolio johnsAccount angiesAccount childrenPortfolio|
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'.
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount with: angiesAccount.
	myAccount := ReceptiveAccount named: 'Cuenta mia'.
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount with: childrenPortfolio.

	self assert: (OrderedCollection 
				with:'Portfolio de la familia' 
				with: ' Cuenta mia'
				with: ' Portfolio de hijos'
				with: '  Cuenta de Juan'
				with: '  Cuenta de Angeles'
		)
		 equals: (PortfolioSummaryReport for: familyPortfolio) compute.! !

!PortfolioReportTest methodsFor: 'tests' stamp: 'NB 6/1/2023 00:44:20'!
test04CannotGeneratePortfolioReportForAReceptiveAccount


	self should: [PortfolioSummaryReport for: ReceptiveAccount new] 
		raise: Error
	  withMessageText: PortfolioSummaryReport operationExclusiveToPortfolioErrorDescription.! !


!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #ReportTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportTest methodsFor: 'tests' stamp: 'NB 6/1/2023 00:18:28'!
test01NewReceptiveAccountSummaryReportIsOk
	
	self assert: (OrderedCollection with: 'Balance = 0') equals: (SummaryReport for: ReceptiveAccount new) compute.! !

!ReportTest methodsFor: 'tests' stamp: 'NB 6/1/2023 00:18:28'!
test02ReceptiveAccountWithOneTransactionSummaryReportIsOk

	| account1 account2|
	
	account1:= ReceptiveAccount new.
	account2:= ReceptiveAccount new.
	Deposit register: 100 on: account1.
	Withdraw register: 50 on: account1.
	Transfer registrer: 20 from: account1 to: account2.
	Transfer registrer: 30 from: account2 to: account1.
	
	self assert: (
		OrderedCollection
			with: 'Depósito por 100.'
			with: 'Extracción por 50.'
			with: 'Salida por transferencia de 20.'
			with: 'Entrada por transferencia de 30.'
			with: 'Balance = 60'
		)
	equals: (SummaryReport for: account1) compute.! !

!ReportTest methodsFor: 'tests' stamp: 'NB 6/1/2023 00:18:28'!
test03NewPortfolioSummaryReportIsOk

	| portfolio |
	
	portfolio:= Portfolio new.
	
	self assert: (
		OrderedCollection
			with: 'Balance = 0'
		)
	equals: (SummaryReport for: portfolio) compute.! !

!ReportTest methodsFor: 'tests' stamp: 'NB 6/1/2023 00:18:28'!
test04OneLevelDeepPortfolioSummaryReportIsOk

	| portfolio account1 account2|
	
	
	account1:= ReceptiveAccount new.
	account2:= ReceptiveAccount new.
	Deposit register: 100 on: account1.
	Withdraw register: 50 on: account1.
	Transfer registrer: 20 from: account1 to: account2.
	Transfer registrer: 30 from: account2 to: account1.
	
	portfolio:= Portfolio with: account1.
	
	self assert: (
		OrderedCollection
			with: 'Depósito por 100.'
			with: 'Extracción por 50.'
			with: 'Salida por transferencia de 20.'
			with: 'Entrada por transferencia de 30.'
			with: 'Balance = 60'
		)
	equals: (SummaryReport for: portfolio) compute.! !

!ReportTest methodsFor: 'tests' stamp: 'NB 6/1/2023 00:18:28'!
test05ManyLevelsDeepPortfolioSummaryReportIsOk

	| portfolio account1 account2 portfolio2 expectedSummaryReport|
	
	
	account1:= ReceptiveAccount new.
	account2:= ReceptiveAccount new.
	Deposit register: 100 on: account1.
	Withdraw register: 50 on: account1.
	Transfer registrer: 20 from: account1 to: account2.
	Transfer registrer: 30 from: account2 to: account1.
	
	portfolio2 := Portfolio with: account1.
	portfolio:= Portfolio with: portfolio2 with: account2.
	
	expectedSummaryReport:= OrderedCollection
			with: 'Depósito por 100.'
			with: 'Extracción por 50.'
			with: 'Salida por transferencia de 20.'
			with: 'Entrada por transferencia de 30.'
			with: 'Entrada por transferencia de 20.'
			with: 'Salida por transferencia de 30.'.
			
	
	expectedSummaryReport 	add: 'Balance = 50'.
	
	self assert: expectedSummaryReport equals: (SummaryReport for: portfolio) compute.! !

!ReportTest methodsFor: 'tests' stamp: 'NB 5/31/2023 23:22:54'!
test06NewReceptiveAccountTransferNetReportIsOk
	
	self assert: 0 equals: (TransferNetReport for: ReceptiveAccount new) compute.! !

!ReportTest methodsFor: 'tests' stamp: 'NB 5/31/2023 23:22:54'!
test07ReceptiveAccountWithManyTransactionTransferNetReportIsOk

	| account1 account2|
	
	account1:= ReceptiveAccount new.
	account2:= ReceptiveAccount new.
	Deposit register: 100 on: account1.
	Withdraw register: 50 on: account1.
	Transfer registrer: 20 from: account1 to: account2.
	Transfer registrer: 30 from: account2 to: account1.
	
	self assert: 10 equals: (TransferNetReport for: account1) compute.! !

!ReportTest methodsFor: 'tests' stamp: 'NB 5/31/2023 23:22:54'!
test08NewPortfolioTransferNetReportIsOk

	self assert: 0 equals: (TransferNetReport for: Portfolio new) compute.! !

!ReportTest methodsFor: 'tests' stamp: 'NB 5/31/2023 23:22:54'!
test09OneLevelDeepPortfolioTransferNetReportIsOk

	| portfolio account1 account2|
	
	
	account1:= ReceptiveAccount new.
	account2:= ReceptiveAccount new.
	Deposit register: 100 on: account1.
	Withdraw register: 50 on: account1.
	Transfer registrer: 20 from: account1 to: account2.
	Transfer registrer: 30 from: account2 to: account1.
	
	portfolio:= Portfolio with: account1.
	
	self assert: 10 equals: (TransferNetReport for: portfolio) compute.! !

!ReportTest methodsFor: 'tests' stamp: 'NB 5/31/2023 23:22:54'!
test10ManyLevelDeepPortfolioTransferNetReportIsOk

	| portfolio account1 account2 portfolio2 |
	
	
	account1:= ReceptiveAccount new.
	account2:= ReceptiveAccount new.
	Deposit register: 100 on: account1.
	Withdraw register: 50 on: account1.
	Transfer registrer: 20 from: account1 to: account2.
	Transfer registrer: 30 from: account2 to: account1.
	
	portfolio2 := Portfolio with: account1.
	portfolio:= Portfolio with: portfolio2.
	
	self assert: 10 equals: (TransferNetReport for: portfolio) compute.! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: 'transferSenderAccount transferReceiverAccount initialBalanceForAccounts amountTransfered transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'setUp' stamp: 'NB 5/26/2023 23:25:46'!
setUp

	transferSenderAccount:= ReceptiveAccount new.
	transferReceiverAccount:= ReceptiveAccount new.
	initialBalanceForAccounts:= 0.
	amountTransfered:= 100.
	transfer:= Transfer registrer: amountTransfered from: transferSenderAccount to: transferReceiverAccount.! !


!TransferTest methodsFor: 'tests' stamp: 'NB 5/26/2023 23:26:59'!
test01TransferCorrectlyDecreasesSenderBalanceAndIncreasesReceiverBalanceForTheAmountTransfered
	
	self assert: initialBalanceForAccounts + amountTransfered equals: transferReceiverAccount balance.
	self assert: initialBalanceForAccounts - amountTransfered equals: transferSenderAccount balance.! !

!TransferTest methodsFor: 'tests' stamp: 'NB 5/26/2023 23:30:55'!
test02SenderAccountCorrectlyRegistersATransferSending

	self assert: (transferSenderAccount hasRegistered: transfer sender).! !

!TransferTest methodsFor: 'tests' stamp: 'NB 5/26/2023 23:31:15'!
test03ReceptionAccountCorrectlyRegistersATransferReception
	
	self assert: (transferReceiverAccount hasRegistered: transfer receiver).! !

!TransferTest methodsFor: 'tests' stamp: 'NB 5/26/2023 23:31:45'!
test04TransferSendingCanReachTheTransfer
	
	self assert: transfer equals: transfer sender transfer.! !

!TransferTest methodsFor: 'tests' stamp: 'NB 5/26/2023 23:32:03'!
test05TransferReceptionCanReachTheTransfer
	
	self assert: transfer equals: transfer receiver transfer.! !

!TransferTest methodsFor: 'tests' stamp: 'NB 5/26/2023 23:21:10'!
test06CannotTransferAnAmountThatItIsNotAStrictlyPositiveNumber
	
	self should: [Transfer registrer: -100 from: ReceptiveAccount new to: ReceptiveAccount new. ]
		raise: Error
		withMessageText: Transfer cannotTransferAmountLessThanAPositiveNumber.! !

!TransferTest methodsFor: 'tests' stamp: 'NB 5/31/2023 00:21:30'!
test07CannotTransferToTheSameAccount
	
	|account|
	account:= ReceptiveAccount new.
	self should: [Transfer registrer: 100 from: account to: account. ]
		raise: Error
		withMessageText: Transfer cannotTransferToTheSameAccountError.! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'operations' stamp: 'NB 5/31/2023 23:00:22'!
operateOver: anOperationOverAccount
	
	self subclassResponsibility .! !

!Account methodsFor: 'operations' stamp: 'NB 6/1/2023 00:10:43'!
traverseWithOperation: anOperationOverAccount
	
	self subclassResponsibility .! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'NB 5/28/2023 17:22:19'!
initializeNamed: aName 
	
	self initialize .
	name := aName.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'operations' stamp: 'NB 5/31/2023 23:14:58'!
operateOver: anOperationOverAccount

	anOperationOverAccount operationOverPortfolio: self.
	
	
	! !

!Portfolio methodsFor: 'operations' stamp: 'NB 5/31/2023 23:14:35'!
traverseWithOperation: anOperationOverAccount

	accounts do: [:anAccount | anAccount operateOver: anOperationOverAccount].
	
	
	! !


!Portfolio methodsFor: 'accessing' stamp: 'NB 5/28/2023 17:22:46'!
name

	^name! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!Portfolio class methodsFor: 'instance creation' stamp: 'NB 5/28/2023 17:19:38'!
named: aName 
	
	^self new initializeNamed: aName ! !

!Portfolio class methodsFor: 'instance creation' stamp: 'NB 5/28/2023 17:28:52'!
named: aName with: anAccount 
	
	^(self new initializeNamed: aName) add: anAccount;yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'NB 5/28/2023 17:48:09'!
named: aName with: anAccount with: anotherAccount 
	
	^(self new initializeNamed: aName) add: anAccount; add: anotherAccount ;yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NB 5/28/2023 17:26:05'!
initializeNamed: aName 

	self initialize .
	name := aName.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'operations' stamp: 'NB 5/31/2023 23:16:22'!
operateOver: anOperationOverAccount

	anOperationOverAccount operationOverReceptiveAccount: self.
	
	! !

!ReceptiveAccount methodsFor: 'operations' stamp: 'NB 5/31/2023 23:18:47'!
traverseWithOperation: anOperationOverAccount

	transactions do: [:aTransaction | aTransaction operateOver: anOperationOverAccount].
	
	! !


!ReceptiveAccount methodsFor: 'accessing' stamp: 'NB 5/28/2023 17:43:02'!
name

	^name! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'NB 5/28/2023 17:25:48'!
named: aName 
	
	^self new initializeNamed: aName ! !


!classDefinition: #OperationOverAccount category: 'Portfolio-Solucion'!
Object subclass: #OperationOverAccount
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!OperationOverAccount methodsFor: 'initialization' stamp: 'NB 6/1/2023 00:28:48'!
initializeFor: accountForReport 
	
	account := accountForReport.! !


!OperationOverAccount methodsFor: 'operations' stamp: 'NB 6/1/2023 00:19:54'!
compute
	
	self subclassResponsibility .! !

!OperationOverAccount methodsFor: 'operations' stamp: 'NB 6/1/2023 00:20:18'!
operationOverPortfolio: aPortoflio
	
	self subclassResponsibility .! !

!OperationOverAccount methodsFor: 'operations' stamp: 'NB 6/1/2023 00:20:31'!
operationOverReceptiveAccount: aReceptiveAccount
	
	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OperationOverAccount class' category: 'Portfolio-Solucion'!
OperationOverAccount class
	instanceVariableNames: ''!

!OperationOverAccount class methodsFor: 'instance creation' stamp: 'NB 6/1/2023 00:29:33'!
for: anAccount 
	
	^self new initializeFor: anAccount ! !


!classDefinition: #AccountReport category: 'Portfolio-Solucion'!
OperationOverAccount subclass: #AccountReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountReport methodsFor: 'operations' stamp: 'NB 5/31/2023 23:21:16'!
operationOverDeposit: aDeposit

	self subclassResponsibility .! !

!AccountReport methodsFor: 'operations' stamp: 'NB 6/1/2023 00:59:17'!
operationOverPortfolio: aPortoflio

	aPortoflio traverseWithOperation: self.! !

!AccountReport methodsFor: 'operations' stamp: 'NB 6/1/2023 00:59:40'!
operationOverReceptiveAccount: aReceptiveAccount

	aReceptiveAccount traverseWithOperation: self.! !

!AccountReport methodsFor: 'operations' stamp: 'NB 5/31/2023 23:21:52'!
operationOverTransferReception: aTransferReception

	self subclassResponsibility .! !

!AccountReport methodsFor: 'operations' stamp: 'NB 5/31/2023 23:22:04'!
operationOverTransferSending: aTransferSending

	self subclassResponsibility .! !

!AccountReport methodsFor: 'operations' stamp: 'NB 5/31/2023 23:21:35'!
operationOverWithdraw: aWithdraw

	self subclassResponsibility .! !


!classDefinition: #SummaryReport category: 'Portfolio-Solucion'!
AccountReport subclass: #SummaryReport
	instanceVariableNames: 'reportLines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!SummaryReport methodsFor: 'operations - private' stamp: 'NB 5/31/2023 00:11:23'!
addBalanceLine

	^ reportLines add: 'Balance = ',account balance asString! !


!SummaryReport methodsFor: 'operations' stamp: 'NB 5/31/2023 23:22:54'!
compute

	reportLines:= OrderedCollection new.
	account operateOver: self.
	self addBalanceLine.
	^reportLines.
	
	! !

!SummaryReport methodsFor: 'operations' stamp: 'NB 5/31/2023 23:21:16'!
operationOverDeposit: aDeposit

	reportLines add: 'Depósito por ', aDeposit value asString ,'.'.
	
	! !

!SummaryReport methodsFor: 'operations' stamp: 'NB 5/31/2023 23:21:52'!
operationOverTransferReception: aTransferReception

	reportLines add: 'Entrada por transferencia de ', aTransferReception value asString,'.'.
	
	! !

!SummaryReport methodsFor: 'operations' stamp: 'NB 5/31/2023 23:22:04'!
operationOverTransferSending: aTransferSending

	reportLines add: 'Salida por transferencia de ', aTransferSending value asString,'.'.
	
	! !

!SummaryReport methodsFor: 'operations' stamp: 'NB 5/31/2023 23:21:35'!
operationOverWithdraw: aWithdraw

	reportLines add: 'Extracción por ', aWithdraw value asString,'.'.
	
	! !


!classDefinition: #TransferNetReport category: 'Portfolio-Solucion'!
AccountReport subclass: #TransferNetReport
	instanceVariableNames: 'transferNetAmount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetReport methodsFor: 'operations' stamp: 'NB 5/31/2023 23:22:54'!
compute
	
	transferNetAmount := 0.
	account operateOver: self.
	^transferNetAmount.! !

!TransferNetReport methodsFor: 'operations' stamp: 'NB 5/31/2023 23:21:16'!
operationOverDeposit: aDeposit

	! !

!TransferNetReport methodsFor: 'operations' stamp: 'NB 5/31/2023 23:21:52'!
operationOverTransferReception: aTransferReception

	transferNetAmount:= transferNetAmount + aTransferReception value.
	
	! !

!TransferNetReport methodsFor: 'operations' stamp: 'NB 5/31/2023 23:22:04'!
operationOverTransferSending: aTransferSending

	transferNetAmount:= transferNetAmount - aTransferSending value.
	
	! !

!TransferNetReport methodsFor: 'operations' stamp: 'NB 5/31/2023 23:21:35'!
operationOverWithdraw: aWithdraw

	
	! !


!classDefinition: #PortfolioSummaryReport category: 'Portfolio-Solucion'!
OperationOverAccount subclass: #PortfolioSummaryReport
	instanceVariableNames: 'portfolioLevel reportLines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioSummaryReport methodsFor: 'operations - private' stamp: 'NB 6/1/2023 00:06:52'!
addName: anAccount

	|nameLength|
	nameLength:= anAccount name size.
	reportLines add: (anAccount name padded: #left to: portfolioLevel + nameLength with: Character separators first).! !


!PortfolioSummaryReport methodsFor: 'operations' stamp: 'NB 6/1/2023 00:30:08'!
compute

	reportLines:= OrderedCollection new.
	portfolioLevel := 0.
	account operateOver: self.
	^reportLines.! !

!PortfolioSummaryReport methodsFor: 'operations' stamp: 'NB 5/31/2023 23:56:57'!
operationOverPortfolio: aPortoflio

	self addName: aPortoflio.
	portfolioLevel:= portfolioLevel + 1.
	aPortoflio traverseWithOperation: self.
	portfolioLevel:= portfolioLevel - 1.! !

!PortfolioSummaryReport methodsFor: 'operations' stamp: 'NB 5/31/2023 23:57:55'!
operationOverReceptiveAccount: aReceptiveAccount

	self addName: aReceptiveAccount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioSummaryReport class' category: 'Portfolio-Solucion'!
PortfolioSummaryReport class
	instanceVariableNames: ''!

!PortfolioSummaryReport class methodsFor: 'error description' stamp: 'NB 6/1/2023 00:37:13'!
operationExclusiveToPortfolioErrorDescription
	
	'El reporte solo puede ser realizado sobre portfolios'.! !


!PortfolioSummaryReport class methodsFor: 'assertions' stamp: 'NB 6/1/2023 00:37:48'!
assertAccountIsAPortfolio: aPortfolio

	^ (aPortfolio isKindOf: Portfolio) ifFalse: [self error: self operationExclusiveToPortfolioErrorDescription]! !


!PortfolioSummaryReport class methodsFor: 'instance creation' stamp: 'NB 6/1/2023 00:37:48'!
for: aPortfolio
	
	self assertAccountIsAPortfolio: aPortfolio.
	
	^self new initializeFor: aPortfolio ! !


!classDefinition: #Transaction category: 'Portfolio-Solucion'!
Object subclass: #Transaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!Transaction methodsFor: 'operations' stamp: 'NB 6/1/2023 01:05:24'!
operateOver: anOperationOverAccount

	self subclassResponsibility .! !


!Transaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Transaction subclass: #AccountTransaction
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'NB 5/26/2023 22:39:55'!
value

	^ value! !


!AccountTransaction methodsFor: 'initialization' stamp: 'NB 5/26/2023 22:40:30'!
initializeFor: aValue

	value := aValue ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NB 5/26/2023 22:43:38'!
for: aValue

	^ self new initializeFor: aValue ! !

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NB 5/26/2023 22:42:48'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'balance' stamp: 'NB 5/26/2023 22:46:27'!
affectBalance: aBalance

	^aBalance + self value ! !


!Deposit methodsFor: 'operations' stamp: 'NB 6/1/2023 01:04:18'!
operateOver: anOperationOverAccount

	anOperationOverAccount operationOverDeposit: self.
	! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'operations' stamp: 'NB 6/1/2023 01:04:32'!
operateOver: anOperationOverAccount

	anOperationOverAccount operationOverWithdraw: self.
	

	! !


!Withdraw methodsFor: 'balance' stamp: 'NB 5/26/2023 22:46:32'!
affectBalance: aBalance

	^aBalance - self value! !


!classDefinition: #TransferTransaction category: 'Portfolio-Solucion'!
Transaction subclass: #TransferTransaction
	instanceVariableNames: 'account transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTransaction methodsFor: 'transfer' stamp: 'NB 5/26/2023 21:50:39'!
transfer
	^transfer.! !


!TransferTransaction methodsFor: 'initialization' stamp: 'NB 5/26/2023 22:47:42'!
initializeWith: aTransfer for: anAccount

	transfer:= aTransfer.
	account := anAccount.! !


!TransferTransaction methodsFor: 'value' stamp: 'NB 5/26/2023 21:51:50'!
value

	^self transfer amount. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferTransaction class' category: 'Portfolio-Solucion'!
TransferTransaction class
	instanceVariableNames: ''!

!TransferTransaction class methodsFor: 'instance creation' stamp: 'NB 5/26/2023 22:47:34'!
register: aTransfer on: anAccount


	| transferTransaction |
	
	transferTransaction := self new initializeWith: aTransfer for: anAccount.
	anAccount register: transferTransaction.
		
	^ transferTransaction.

	! !


!classDefinition: #TransferReception category: 'Portfolio-Solucion'!
TransferTransaction subclass: #TransferReception
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferReception methodsFor: 'balance' stamp: 'NB 5/26/2023 22:46:04'!
affectBalance: aBalance

	^aBalance + self value. ! !


!TransferReception methodsFor: 'operations' stamp: 'NB 6/1/2023 01:04:39'!
operateOver: anOperationOverAccount

	anOperationOverAccount operationOverTransferReception: self.
	
! !


!classDefinition: #TransferSending category: 'Portfolio-Solucion'!
TransferTransaction subclass: #TransferSending
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferSending methodsFor: 'balance' stamp: 'NB 5/26/2023 22:46:11'!
affectBalance: aBalance

	^aBalance - self value. ! !


!TransferSending methodsFor: 'operations' stamp: 'NB 6/1/2023 01:04:45'!
operateOver: anOperationOverAccount

	anOperationOverAccount operationOverTransferSending: self.
	! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'amountToTransfer accountToWithdraw_CHANGE_ME accountToDeposit_CHANGE_ME amount sender receiver'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'initialize' stamp: 'NB 5/26/2023 22:37:45'!
initializeFor: anAmountToTransfer from: aAccountToWithdraw to: accountToDeposit 

	amount := anAmountToTransfer.
	sender := TransferSending  register: self on: aAccountToWithdraw.
	receiver := TransferReception  register: self on: accountToDeposit.
	! !


!Transfer methodsFor: 'accesing' stamp: 'am 5/26/2023 20:47:11'!
amount
	^amount.! !

!Transfer methodsFor: 'accesing' stamp: 'am 5/26/2023 20:16:36'!
receiver
	^receiver! !

!Transfer methodsFor: 'accesing' stamp: 'am 5/26/2023 20:11:28'!
sender
	^sender! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'assertions' stamp: 'NB 5/26/2023 22:58:11'!
assertAmountIsStrictlyPositive: anAmountToTransfer

	^ anAmountToTransfer strictlyPositive ifFalse: [self error: self cannotTransferAmountLessThanAPositiveNumber ]! !


!Transfer class methodsFor: 'transfer' stamp: 'NB 5/31/2023 00:24:37'!
assertAccount: accountToDeposit isNotTheSameAs: accountToWithdraw

	^ accountToWithdraw = accountToDeposit ifTrue: [self error: self cannotTransferToTheSameAccountError ]! !

!Transfer class methodsFor: 'transfer' stamp: 'NB 5/31/2023 00:24:37'!
registrer: anAmountToTransfer from: accountToWithdraw to: accountToDeposit 
	self assertAmountIsStrictlyPositive: anAmountToTransfer.
	
	self assertAccount: accountToDeposit isNotTheSameAs: accountToWithdraw.
	
	^self new initializeFor: anAmountToTransfer from: accountToWithdraw to: accountToDeposit.
	! !


!Transfer class methodsFor: 'error description' stamp: 'NB 5/26/2023 22:54:28'!
cannotTransferAmountLessThanAPositiveNumber
	
	^'Cannot transfer an amount that it lower or equal to 0'.! !

!Transfer class methodsFor: 'error description' stamp: 'NB 5/31/2023 00:21:57'!
cannotTransferToTheSameAccountError
	
	'No se puede transferir a la misma cuenta'.! !
