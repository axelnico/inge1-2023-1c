!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'am 6/26/2023 21:05:05'!
test01ImportValidInputWithTwoCustomers

	CustomerImporter valueFrom: self validImportData into: session.

	self assertImportedRightNumberOfCustomers.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly ! !

!ImportTest methodsFor: 'tests' stamp: 'am 6/26/2023 21:35:10'!
test02CannotImportAnEmptyInput
	
	
	self should: 
	[CustomerImporter valueFrom: (ReadStream on: '
') into: session.] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError| 
		self assert: 0 equals: (session selectAllOfType: Customer) size.
		self assert: CustomerImporter cannotImportEmptyStream equals: anError messageText ].
! !

!ImportTest methodsFor: 'tests' stamp: 'am 6/26/2023 21:38:13'!
test03CannotImportAnInputWithWrongRecordIdentification
	
	
	self should: 
	[CustomerImporter valueFrom: (ReadStream on: 'X,Pepe,Sanchez,D,22333444') into: session.] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError| 
		self assert: 0 equals: (session selectAllOfType: Customer) size.
		self assert: CustomerImporter cannotImportStreamWithInvalidRecorIdentification equals: anError messageText ].
! !

!ImportTest methodsFor: 'tests' stamp: 'am 6/26/2023 21:43:51'!
test04CannotImportAnInputWithWrongCustomerRecordLength
	
	
	self should: 
	[CustomerImporter valueFrom: (ReadStream on: 'C,Pepe') into: session.] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError| 
		self assert: 0 equals: (session selectAllOfType: Customer) size.
		self assert: CustomerImporter cannotImportStreamWithWrongCustomerRecordLength equals: anError messageText ].
! !

!ImportTest methodsFor: 'tests' stamp: 'am 6/26/2023 21:49:41'!
test05CannotImportAnInputWithWrongAddressRecordLength
	
	
	self should: 
	[CustomerImporter valueFrom: (ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin') into: session.] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError| 
		self assert: 1 equals: (session selectAllOfType: Customer) size.
		self assert: 0 equals: (session selectAllOfType: Address ) size.
		self assert: CustomerImporter cannotImportAnInputWithWrongAddressRecordLength equals: anError messageText ].
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

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:05'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


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

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 17:55:46'!
isAt: aStreetName

	^streetName = aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !


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
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


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


!CustomerImporter methodsFor: 'evaluating' stamp: 'am 6/26/2023 21:01:57'!
createRecord

	^record := line findTokens: $,.! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'am 6/26/2023 21:02:16'!
hasLinesLeft

	line := readStream nextLine.
	^line notNil.! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'am 6/26/2023 21:50:25'!
importAddress
	
	| newAddress |
			(record size < 6) ifTrue: [self error: self class cannotImportAnInputWithWrongAddressRecordLength ].
			newAddress := Address 
				streetName: record second 
				streetNumber: record third asNumber 
				town: record fourth 
				zipCode: record fifth asNumber	 
				province: record sixth. 
			customer addAddress: newAddress.! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'am 6/26/2023 21:46:21'!
importCustomer
			(record size < 4) ifTrue: [self error: self class cannotImportStreamWithWrongCustomerRecordLength].
			customer := Customer 
				firstName: record second 
				lastName: record third 
				identificationType: record fourth 
				identificationNumber: record fifth.
			session persist: customer.! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'am 6/26/2023 21:40:39'!
importRecord
	record isEmpty ifTrue: [self error: self class cannotImportEmptyStream].
	(self isCustomer) ifTrue: [ ^self importCustomer].
	(self isAddress) ifTrue: [ ^self importAddress].
	self error: self class cannotImportStreamWithInvalidRecorIdentification. ! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'am 6/26/2023 21:03:08'!
isAddress

	^ record first beginsWith: 'A'! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'am 6/26/2023 21:03:00'!
isCustomer

	^ record first beginsWith: 'C'! !

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


!CustomerImporter class methodsFor: 'error description' stamp: 'am 6/26/2023 21:49:07'!
cannotImportAnInputWithWrongAddressRecordLength
	^'cannot import an input with wrong address record length'.! !

!CustomerImporter class methodsFor: 'error description' stamp: 'am 6/26/2023 21:26:24'!
cannotImportEmptyStream
	^'cannot import an empty stream'.! !

!CustomerImporter class methodsFor: 'error description' stamp: 'am 6/26/2023 21:39:19'!
cannotImportStreamWithInvalidRecorIdentification
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
