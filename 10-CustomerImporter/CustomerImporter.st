!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'database' stamp: 'NB 6/25/2023 15:58:04'!
findCustomerIdentifiedBy: anIdentificationType withIdentificationNumber: anIdentificationNumber 

	|resultSet|
	
	resultSet:= session select: [:aCustomer | 
					aCustomer identificationType = anIdentificationType 
					and: [ aCustomer identificationNumber = anIdentificationNumber]  ]  ofType: Customer.
	^ resultSet anyOne
	
	! !


!ImportTest methodsFor: 'import' stamp: 'NB 6/25/2023 16:28:54'!
importCustomers: aStream

	(CustomerImporter from: aStream with: session) value! !


!ImportTest methodsFor: 'tests' stamp: 'NB 6/25/2023 16:18:48'!
test01Import


	self importCustomers: (UniFileStream new open: 'input.txt' forWrite: false) .
	
	self assertAmountOfCustomersImportedIsCorrect.
	
	self assertCustomerPepeAndHisAddressesWereImportedCorrectly.
	
	self assertCustomerJuanAndHisAddressesWereImportedCorrectly.
	
	! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'NB 6/22/2023 20:34:45'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'NB 6/22/2023 20:35:36'!
tearDown

	session commit.
	session close! !


!ImportTest methodsFor: 'assertions' stamp: 'NB 6/25/2023 15:47:34'!
assertAddressOfCustomer: aCustomer named: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince     

	
	| address |
	
	address:= aCustomer addressNamed: aStreetName ifNone: [self fail].
	
	self assert: aStreetName equals: address streetName.
	self assert: aNumber equals: address streetNumber .
	self assert: aTown equals: address town .
	self assert: aZipCode equals: address zipCode .
	self assert: aProvince equals: address province .
	! !

!ImportTest methodsFor: 'assertions' stamp: 'NB 6/25/2023 16:10:00'!
assertAddressOfJuanWasImportedCorrectly: customerJuan

	self assertCustomerJuanHasOnlyOneAddressImported: customerJuan.
	
	self assertAddressOfCustomer: customerJuan named: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001  province: 'CABA'.
! !

!ImportTest methodsFor: 'assertions' stamp: 'NB 6/25/2023 16:07:51'!
assertAddressesOfCustomerPepeWereImportedCorrectly: customerPepe

	self assertCustomerPepeHasOnlyTwoAddressesImported: customerPepe.

	self assertAddressOfCustomer: customerPepe named: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	
	self assertAddressOfCustomer: customerPepe named: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'! !

!ImportTest methodsFor: 'assertions' stamp: 'NB 6/22/2023 21:19:57'!
assertAmountOfCustomersImportedIsCorrect

	^ self assert: 2 equals: (session selectAllOfType: Customer) size! !

!ImportTest methodsFor: 'assertions' stamp: 'NB 6/25/2023 16:54:59'!
assertCustomer: aCustomer hasFirstName: aFirstName lastName: aLastName 

	self assert: aLastName equals: aCustomer lastName.
	
	self assert: aFirstName equals: aCustomer firstName! !

!ImportTest methodsFor: 'assertions' stamp: 'NB 6/25/2023 16:11:18'!
assertCustomerJuanAndHisAddressesWereImportedCorrectly
	
	
	| customerJuan  |
	
	customerJuan:= self findCustomerIdentifiedBy: 'C' withIdentificationNumber: '23-25666777-9'.
	
	self assertCustomer: customerJuan hasFirstName: 'Juan' lastName: 'Perez'.

	self assertAddressOfJuanWasImportedCorrectly: customerJuan .
	! !

!ImportTest methodsFor: 'assertions' stamp: 'NB 6/22/2023 21:46:17'!
assertCustomerJuanHasOnlyOneAddressImported: customerJuan

	^ self assert: 1 equals: customerJuan addressesSize! !

!ImportTest methodsFor: 'assertions' stamp: 'NB 6/25/2023 16:07:42'!
assertCustomerPepeAndHisAddressesWereImportedCorrectly
	
	
	| customerPepe |
	
	customerPepe:= self findCustomerIdentifiedBy: 'D' withIdentificationNumber: '22333444'. 
	
	self assertCustomer: customerPepe hasFirstName: 'Pepe' lastName: 'Sanchez'.
	
	self assertAddressesOfCustomerPepeWereImportedCorrectly: customerPepe.
! !

!ImportTest methodsFor: 'assertions' stamp: 'NB 6/22/2023 21:46:01'!
assertCustomerPepeHasOnlyTwoAddressesImported: customerPepe

	^ self assert: 2 equals: customerPepe addressesSize.! !


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


!Address methodsFor: 'street' stamp: 'NB 6/25/2023 15:13:20'!
isAt: aStreetName

	^streetName  = aStreetName.! !

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


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'NB 6/25/2023 15:42:19'!
addressNamed: aStreetName ifNone: aNoneBlock 

	^addresses detect: [:anAddress | anAddress isAt: aStreetName] ifNone: aNoneBlock.! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !

!Customer methodsFor: 'addresses' stamp: 'NB 6/22/2023 21:43:55'!
addressesSize

	^ addresses size! !


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


!Customer methodsFor: 'importing' stamp: 'NB 6/22/2023 20:33:54'!
importCustomers

	"
	self importCustomers
	"
	| inputStream session newCustomer line |

	inputStream := UniFileStream new open: 'input.txt' forWrite: false.
	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.

	line := inputStream nextLine.
	[ line notNil ] whileTrue: [
		(line beginsWith: 'C') ifTrue: [ | customerData |
			customerData := line findTokens: $,.
			newCustomer := Customer new.
			newCustomer firstName: customerData second.
			newCustomer lastName: customerData third.
			newCustomer identificationType: customerData fourth.
			newCustomer identificationNumber: customerData fourth.
			session persist: newCustomer ].

		(line beginsWith: 'A') ifTrue: [ | addressData newAddress |
			addressData := line findTokens: $,.
			newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: addressData second.
			newAddress streetNumber: addressData third asNumber .
			newAddress town: addressData fourth.
			newAddress zipCode: addressData fifth asNumber .
			newAddress province: addressData fourth ].

		line := inputStream nextLine. ].

	session commit.
	session close.

	inputStream close.
	! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'session readStream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'NB 6/25/2023 16:28:03'!
initializeFrom: aReadStream with: aSession
	session := aSession.
	readStream := aReadStream.! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'NB 6/25/2023 16:28:03'!
value

	"
	self importCustomers
	"
	|  newCustomer line |

	line := readStream nextLine.
	[ line notNil ] whileTrue: [
		(line beginsWith: 'C') ifTrue: [ | customerData |
			customerData := line findTokens: $,.
			newCustomer := Customer new.
			newCustomer firstName: customerData second.
			newCustomer lastName: customerData third.
			newCustomer identificationType: customerData fourth.
			newCustomer identificationNumber: customerData fifth.
			session persist: newCustomer ].

		(line beginsWith: 'A') ifTrue: [ | addressData newAddress |
			addressData := line findTokens: $,.
			newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: addressData second.
			newAddress streetNumber: addressData third asNumber .
			newAddress town: addressData fourth.
			newAddress zipCode: addressData fifth asNumber .
			newAddress province: addressData sixth ].

		line := readStream nextLine. ].

	readStream close.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'NB 6/25/2023 16:29:02'!
from: aReadStream with: aSession

	^self new initializeFrom: aReadStream with: aSession! !


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
