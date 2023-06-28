!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'NB 6/27/2023 22:56:04'!
test01CanImportCorrectlyAValidInputWithTwoCustomers

	CustomerImporter valueFrom: self validImportData into: session.

	self assertImportedRightNumberOfCustomers.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly ! !

!ImportTest methodsFor: 'tests' stamp: 'NB 6/28/2023 00:00:30'!
test02CannotImportAnEmptyInput
	
	
	self shouldRaiseErrorWhenImporting: self emptyInput  withErrorMessageText: CustomerImporter cannotImportEmptyStream  assertingThat: [self assertNoCustomerWasImported.].
	! !

!ImportTest methodsFor: 'tests' stamp: 'NB 6/28/2023 00:09:30'!
test03CannotImportAnInputThatHasWrongCustomerRecordIdentificationStartingWithC
	
	
	self shouldRaiseErrorWhenImporting: self invalidInputWithWrongCustomerRecordIdentification
		 withErrorMessageText: CustomerImporter cannotImportStreamWithInvalidRecordIdentification 
		assertingThat: [self assertNoCustomerWasImported.].
	
	
! !

!ImportTest methodsFor: 'tests' stamp: 'NB 6/28/2023 00:02:09'!
test04CannotImportAnInputWithACustomerRecordWithLessThanFiveFields
	
	
	self shouldRaiseErrorWhenImporting: self invalidInputWithACustomerRecordWithLessThanFiveFields
		 withErrorMessageText: CustomerImporter cannotImportStreamWithWrongCustomerRecordLength
		assertingThat: [self assertNoCustomerWasImported.].
		
	
! !

!ImportTest methodsFor: 'tests' stamp: 'NB 6/28/2023 00:02:53'!
test05CannotImportAnInputWithAnAddressRecordWithLessThanSixFields
	
	
	self shouldRaiseErrorWhenImporting: self invalidInputWithAnAddressRecordWithLessThanSixFields
		 withErrorMessageText: CustomerImporter cannotImportAnInputWithWrongAddressRecordLength
		assertingThat: [self assertOnlyOneCustomerWasImportedWithoutAddresses].
		
	
! !

!ImportTest methodsFor: 'tests' stamp: 'NB 6/28/2023 00:09:30'!
test06CannotImportAnInputThatHasWrongAddressRecordIdentificationStartingWithA
	
	
	self shouldRaiseErrorWhenImporting: self invalidInputWithWrongAddressRecordIdentification
		 withErrorMessageText: CustomerImporter cannotImportStreamWithInvalidRecordIdentification
		assertingThat: [self assertOnlyOneCustomerWasImportedWithoutAddresses.].
		
	
! !

!ImportTest methodsFor: 'tests' stamp: 'NB 6/28/2023 00:04:00'!
test07CannotImportAnInputWithACustomerRecordWithMoreThanFiveFields
	
	
	self shouldRaiseErrorWhenImporting: self invalidInputWithACustomerRecordWithMoreThanFiveFields
		 withErrorMessageText: CustomerImporter cannotImportStreamWithWrongCustomerRecordLength
		assertingThat: [self assertNoCustomerWasImported.].
		

! !

!ImportTest methodsFor: 'tests' stamp: 'NB 6/28/2023 00:04:34'!
test08CannotImportAnInputWithAnAddressRecordWithMoreThanSixFields
	
	
	self shouldRaiseErrorWhenImporting: self invalidInputWithAnAddressRecordWithMoreThanSixFields
		 withErrorMessageText: CustomerImporter cannotImportAnInputWithWrongAddressRecordLength
		assertingThat: [self assertOnlyOneCustomerWasImportedWithoutAddresses.].
		
	
! !

!ImportTest methodsFor: 'tests' stamp: 'NB 6/28/2023 00:06:29'!
test09CannotImportAnInputWithAnAddressRecordWithoutACustomer
	
	
	self shouldRaiseErrorWhenImporting: self invalidInputWithOnlyAnAddressRecord
		 withErrorMessageText: CustomerImporter cannotImportAnAddressRecordWithoutACustomer
		assertingThat: [self assertNoAddressWasImported].
! !


!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:22:05'!
assertAddressOf: importedCustomer at: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince

	| importedAddress |

	importedAddress := importedCustomer addressAt: aStreetName ifNone: [ self fail ].
	self assert: aStreetName equals: importedAddress streetName.
	self assert: aNumber equals: importedAddress streetNumber.
	self assert: aTown equals: importedAddress town.
	self assert: aZipCode equals: importedAddress zipCode.
	self assert: aProvince equals: importedAddress province.

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:27:57'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := self customerWithIdentificationType: anIdType number: anIdNumber.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.

	^importedCustomer

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:12:18'!
assertImportedRightNumberOfCustomers

	^ self assert: 2 equals: (session selectAllOfType: Customer) size! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:45'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!ImportTest methodsFor: 'assertions' stamp: 'NB 6/28/2023 00:06:16'!
assertNoAddressWasImported

	^ self assert: 0 equals: (session selectAllOfType: Address) size! !

!ImportTest methodsFor: 'assertions' stamp: 'NB 6/27/2023 22:54:54'!
assertNoCustomerWasImported

	^ self assert: 0 equals: (session selectAllOfType: Customer) size! !

!ImportTest methodsFor: 'assertions' stamp: 'NB 6/27/2023 23:04:17'!
assertOnlyOneCustomerWasImportedWithoutAddresses

	self assert: 1 equals: (session selectAllOfType: Customer) size.
		self assert: 0 equals: (session selectAllOfType: Address ) size! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:05'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !

!ImportTest methodsFor: 'assertions' stamp: 'NB 6/27/2023 23:59:21'!
shouldRaiseErrorWhenImporting: aReadStream withErrorMessageText: anErrorMessageText assertingThat: anAssertionBlock
	
	
	self should: 
		[CustomerImporter valueFrom: aReadStream into: session.] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError| 
		self assert: anErrorMessageText equals: anError messageText. 
		anAssertionBlock value].
! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 00:27:50'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.
! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 00:28:23'!
tearDown

	session commit.
	session close.
	! !


!ImportTest methodsFor: 'customer' stamp: 'HAW 5/22/2022 18:14:22'!
customerWithIdentificationType: anIdType number: anIdNumber

	^ (session
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer) anyOne! !


!ImportTest methodsFor: 'test data' stamp: 'NB 6/27/2023 23:43:36'!
emptyInput


	^ReadStream on: '
'
! !

!ImportTest methodsFor: 'test data' stamp: 'NB 6/27/2023 23:46:09'!
invalidInputWithACustomerRecordWithLessThanFiveFields

	^ ReadStream on: 'C,Pepe'! !

!ImportTest methodsFor: 'test data' stamp: 'NB 6/27/2023 23:47:54'!
invalidInputWithACustomerRecordWithMoreThanFiveFields

	^ ReadStream on: 'C,Pepe,Sanchez,D,22333444,aaa'! !

!ImportTest methodsFor: 'test data' stamp: 'NB 6/27/2023 23:48:04'!
invalidInputWithAnAddressRecordWithLessThanSixFields

	^ ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin'! !

!ImportTest methodsFor: 'test data' stamp: 'NB 6/27/2023 23:49:13'!
invalidInputWithAnAddressRecordWithMoreThanSixFields

	^ ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs,aaa'! !

!ImportTest methodsFor: 'test data' stamp: 'NB 6/27/2023 23:49:41'!
invalidInputWithOnlyAnAddressRecord

	^ ReadStream on: 'A,San Martin,3322,Olivos,1636,BsAs'! !

!ImportTest methodsFor: 'test data' stamp: 'NB 6/27/2023 23:47:12'!
invalidInputWithWrongAddressRecordIdentification

	^ ReadStream on: 'C,Pepe,Sanchez,D,22333444
AAA,San Martin,3322,Olivos,1636,BsAs'! !

!ImportTest methodsFor: 'test data' stamp: 'NB 6/27/2023 23:45:22'!
invalidInputWithWrongCustomerRecordIdentification

	^ ReadStream on: 'CCC,Pepe,Sanchez,D,22333444'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 18:08:08'!
validImportData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 17:55:46'!
isAt: aStreetName

	^streetName = aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !


!Address methodsFor: 'town' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !


!Address methodsFor: 'initialization' stamp: 'am 6/26/2023 19:36:43'!
initializeStreetName: aStreetName streetNumber: aStreetNumber town: aTown zipCode: aZipCode province: aProvince 
	
	streetName := aStreetName.
	streetNumber := aStreetNumber.
	town := aTown.
	zipCode := aZipCode.
	province := aProvince.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Address class' category: 'CustomerImporter'!
Address class
	instanceVariableNames: ''!

!Address class methodsFor: 'instance creation' stamp: 'am 6/26/2023 19:36:12'!
streetName: aStreetName streetNumber: aStreetNumber town: aTown zipCode: aZipCode province: aProvince 
	^self new initializeStreetName: aStreetName streetNumber: aStreetNumber town: aTown zipCode: aZipCode province: aProvince ! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 17:55:17'!
addressAt: aStreetName ifNone: aNoneBlock

	^addresses detect: [ :address | address isAt: aStreetName ] ifNone: aNoneBlock ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !


!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !


!Customer methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !

!Customer methodsFor: 'initialization' stamp: 'am 6/26/2023 19:32:58'!
initializeFirstName: aFirstName lastName: aLastName identificationType: anIdentificationType identificationNumber: anIdentificationNumber 
	firstName := aFirstName.
	lastName := aLastName.
	identificationType := anIdentificationType.
	identificationNumber := anIdentificationNumber.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Customer class' category: 'CustomerImporter'!
Customer class
	instanceVariableNames: ''!

!Customer class methodsFor: 'instance creation' stamp: 'am 6/26/2023 19:32:44'!
firstName: aFirstName lastName: aLastName identificationType: anIdentificationType identificationNumber: anIdentificationNumber 
	
	^self new initializeFirstName: aFirstName lastName: aLastName identificationType: anIdentificationType identificationNumber: anIdentificationNumber ! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'session readStream customer line record'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'am 6/26/2023 20:32:34'!
initializeFrom: aReadStream into: aSession
	session := aSession.
	readStream := aReadStream.! !


!CustomerImporter methodsFor: 'assertions' stamp: 'NB 6/27/2023 23:30:29'!
assertAddressRecordSizeIsValid

	^ (record size = 6) ifFalse: [self error: self class cannotImportAnInputWithWrongAddressRecordLength ]! !

!CustomerImporter methodsFor: 'assertions' stamp: 'NB 6/27/2023 23:27:35'!
assertCustomerRecordSizeIsValid

	^ (record size = 5) ifFalse: [self error: self class cannotImportStreamWithWrongCustomerRecordLength]! !

!CustomerImporter methodsFor: 'assertions' stamp: 'NB 6/27/2023 23:31:01'!
assertCustomerWasImported

	^ customer ifNil: [self error: self class cannotImportAnAddressRecordWithoutACustomer]! !

!CustomerImporter methodsFor: 'assertions' stamp: 'NB 6/27/2023 23:34:27'!
assertRecordIsNotEmpty

	^ record isEmpty ifTrue: [self error: self class cannotImportEmptyStream]! !


!CustomerImporter methodsFor: 'testing' stamp: 'am 6/26/2023 21:02:16'!
hasLinesLeft

	line := readStream nextLine.
	^line notNil.! !

!CustomerImporter methodsFor: 'testing' stamp: 'NB 6/27/2023 23:08:12'!
isAddress

	^ record first = 'A'! !

!CustomerImporter methodsFor: 'testing' stamp: 'NB 6/27/2023 23:07:32'!
isCustomer

	^ record first = 'C'! !


!CustomerImporter methodsFor: 'evaluating - private' stamp: 'am 6/26/2023 21:01:57'!
createRecord

	^record := line findTokens: $,.! !

!CustomerImporter methodsFor: 'evaluating - private' stamp: 'NB 6/28/2023 00:09:30'!
importRecord

	self assertRecordIsNotEmpty.
	
	(self isCustomer) ifTrue: [ ^self importCustomer].
	(self isAddress) ifTrue: [ ^self importAddress].
	
	self error: self class cannotImportStreamWithInvalidRecordIdentification. ! !


!CustomerImporter methodsFor: 'customer' stamp: 'NB 6/27/2023 23:27:35'!
importCustomer

			self assertCustomerRecordSizeIsValid.
			
			customer := Customer 
				firstName: record second 
				lastName: record third 
				identificationType: record fourth 
				identificationNumber: record fifth.
			session persist: customer.! !


!CustomerImporter methodsFor: 'address' stamp: 'NB 6/27/2023 23:31:01'!
importAddress
	
	| newAddress |
			self assertAddressRecordSizeIsValid.
			
			self assertCustomerWasImported.
			
			newAddress := Address 
				streetName: record second 
				streetNumber: record third asNumber 
				town: record fourth 
				zipCode: record fifth asNumber	 
				province: record sixth. 
			customer addAddress: newAddress.! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'am 6/26/2023 20:40:26'!
value
	
	 [ self hasLinesLeft ] whileTrue: [
		self createRecord.
		self importRecord.].

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'am 6/26/2023 21:30:44'!
from: aReadStream into: aSession
	
	^self new initializeFrom: aReadStream into: aSession! !


!CustomerImporter class methodsFor: 'importing' stamp: 'am 6/26/2023 21:29:46'!
valueFrom: aReadStream into: aSession
aReadStream isEmpty ifTrue: [self error: self cannotImportEmptyStream].
	^(self from: aReadStream into: aSession) value! !


!CustomerImporter class methodsFor: 'error description' stamp: 'NB 6/27/2023 23:25:19'!
cannotImportAnAddressRecordWithoutACustomer
	
	^'Cannot import an address without a customer'.! !

!CustomerImporter class methodsFor: 'error description' stamp: 'am 6/26/2023 21:49:07'!
cannotImportAnInputWithWrongAddressRecordLength
	^'cannot import an input with wrong address record length'.! !

!CustomerImporter class methodsFor: 'error description' stamp: 'am 6/26/2023 21:26:24'!
cannotImportEmptyStream
	^'cannot import an empty stream'.! !

!CustomerImporter class methodsFor: 'error description' stamp: 'NB 6/28/2023 00:09:30'!
cannotImportStreamWithInvalidRecordIdentification
	^'cannot import stream with invalid record identification'.! !

!CustomerImporter class methodsFor: 'error description' stamp: 'am 6/26/2023 21:44:56'!
cannotImportStreamWithWrongCustomerRecordLength
	^'cannot import stream with wrong customer record length'! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 00:19:29'!
beginTransaction

	! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 19:17:36'!
commit

	(tables at: Customer ifAbsent: [#()]) do: [ :aCustomer | self persistAddressesOf: aCustomer ]
	! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 5/22/2022 00:19:29'!
close

	! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 19:29:06'!
objectsOfType: aType

	^ tables at: aType ifAbsent: [ #() ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
persistAddressesOf: anObjectWithAddresses

	anObjectWithAddresses addresses do: [ :anAddress | self persist: anAddress ]
	! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 5/22/2022 00:19:29'!
persist: anObject

	| table |

	self delay.
	table := tables at: anObject class ifAbsentPut: [ Set new ].

	self defineIdOf: anObject.
	table add: anObject.

	(anObject isKindOf: Customer) ifTrue: [ self persistAddressesOf: anObject ].! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
select: aCondition ofType: aType

	self delay.
	^(self objectsOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
selectAllOfType: aType

	self delay.
	^(self objectsOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !
