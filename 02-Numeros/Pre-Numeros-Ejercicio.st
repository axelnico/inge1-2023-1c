!classDefinition: #NumeroTest category: 'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo negativeOneHalf'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:08:06'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:09:48'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:09:55'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:04'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:25'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'NB 4/15/2023 17:54:55'!
test07FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := Fraccion with: (Entero with: 7) over: (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:11:26'!
test08FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'NB 4/15/2023 17:55:04'!
test09AparentFraccionesAreEqual

	self assert: oneHalf equals: (Fraccion with: two over: four)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:12:46'!
test10AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:26:23'!
test11MultiplyingFraccionesCanReturnAnEntero

	self assert: (twoFifth) * (fiveHalfs) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:13:21'!
test12AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:13:30'!
test13AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:14:16'!
test14NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/24/2020 02:23:47'!
test15NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'NB 4/15/2023 17:55:21'!
test16SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (Fraccion with: negativeOne over: negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NB 4/15/2023 17:55:27'!
test17SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (Fraccion with: one over: negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NB 4/15/2023 17:30:11'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := Fraccion with: one over: two.
	oneFifth := Fraccion with: one over: five.
	twoFifth := Fraccion with: two over: five.
	twoTwentyfifth := Fraccion with: two over: (Entero with: 25).
	fiveHalfs := Fraccion with: five over: two.
	negativeOneHalf := Fraccion with: negativeOne over: two
	! !


!classDefinition: #Numero category: 'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'NB 4/15/2023 17:20:37'!
* aMultiplier 

	self subclassResponsibility.
	! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NB 4/15/2023 17:50:42'!
+ anAdder 
	
	self subclassResponsibility .! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NB 4/15/2023 17:57:56'!
negated
	
	self subclassResponsibility .! !


!Numero methodsFor: 'testing' stamp: 'NB 4/15/2023 17:33:42'!
isNegative
	
	self subclassResponsibility .! !

!Numero methodsFor: 'testing' stamp: 'NB 4/15/2023 17:34:38'!
isOne

	self subclassResponsibility .! !

!Numero methodsFor: 'testing' stamp: 'NB 4/15/2023 17:35:26'!
isZero

	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:49:48'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !


!classDefinition: #Entero category: 'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'initialization' stamp: 'NB 4/16/2023 13:12:39'!
initializeWith: aValue
	value := aValue! !


!Entero methodsFor: 'testing' stamp: 'NB 4/15/2023 17:32:46'!
isNegative
	
	^value < 0.! !

!Entero methodsFor: 'testing' stamp: 'NB 4/15/2023 17:34:09'!
isOne

	^value = 1.! !

!Entero methodsFor: 'testing' stamp: 'NB 4/15/2023 17:35:00'!
isZero

	^value = 0.! !


!Entero methodsFor: 'comparing' stamp: 'NB 4/16/2023 12:59:09'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue]
		! !

!Entero methodsFor: 'comparing' stamp: 'NB 4/16/2023 13:01:38'!
hash

	^value hash.
		! !


!Entero methodsFor: 'arithmetic operations' stamp: 'SM 4/15/2023 19:52:28'!
* aMultiplier
	^aMultiplier multiplySelfToTheInteger: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'SM 4/15/2023 20:00:05'!
+ anAdder 
	^anAdder addSelfToTheInteger: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'NB 4/15/2023 18:00:41'!
// aDivisor 
	
	^self class with: value // aDivisor integerValue.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'SM 4/15/2023 20:03:53'!
addSelfToAFraccion: aFraccionToBeAdden
	^self error: 'Tipo de número no soportado'.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'SM 4/15/2023 19:58:26'!
addSelfToTheInteger:anAdder
		^self class with: value + anAdder integerValue.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'NB 4/15/2023 18:01:59'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue).! !

!Entero methodsFor: 'arithmetic operations' stamp: 'SM 4/15/2023 20:06:06'!
multiplySelfToTheFraccion: aFraccion
	^self error: 'Tipo de número no soportado'! !

!Entero methodsFor: 'arithmetic operations' stamp: 'SM 4/15/2023 19:49:24'!
multiplySelfToTheInteger: ainteger	
	^self class with: value * ainteger	 integerValue.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'NB 4/15/2023 17:57:29'!
negated
	
	^self * (self class with: -1).! !

!Entero methodsFor: 'arithmetic operations' stamp: 'NB 4/15/2023 18:03:00'!
printOn: aStream
		
	aStream print: value.
	! !


!Entero methodsFor: 'accessing' stamp: 'NB 4/16/2023 13:13:44'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'NB 4/15/2023 17:25:37'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	^self new initializeWith: aValue! !


!classDefinition: #Fraccion category: 'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'initialization' stamp: 'NB 4/16/2023 13:12:49'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'testing' stamp: 'NB 4/15/2023 17:33:17'!
isNegative
	
	^denominator < 0.! !

!Fraccion methodsFor: 'testing' stamp: 'NB 4/15/2023 17:34:27'!
isOne

	^false.! !

!Fraccion methodsFor: 'testing' stamp: 'NB 4/15/2023 17:35:14'!
isZero

	^false.! !


!Fraccion methodsFor: 'arithmetic operations' stamp: 'SM 4/15/2023 19:54:57'!
* aMultiplier	^aMultiplier multiplySelfToTheFraccion: self.
	
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'SM 4/15/2023 20:05:28'!
+ anAdder
	^anAdder addSelfToAFraccion: self.
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'SM 4/15/2023 20:03:16'!
addSelfToAFraccion: aFraccionToBeAdden
		| newNumerator newDenominator |
		newNumerator := 
			(numerator * aFraccionToBeAdden denominator) + (denominator * aFraccionToBeAdden numerator).
		newDenominator := denominator * aFraccionToBeAdden denominator.
		^ self class with: newNumerator over: newDenominator.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'SM 4/15/2023 19:59:09'!
addSelfToTheInteger:anInteger
	self error: 'Tipo de número no soportado'! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'SM 4/15/2023 19:51:05'!
multiplySelfToTheFraccion: aFraccion
	^self class with: (numerator * aFraccion numerator) over: (denominator * aFraccion denominator)! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'SM 4/15/2023 20:04:07'!
multiplySelfToTheInteger: aFraccion
	^self error: 'Tipo de número no soportado'! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'NB 4/15/2023 17:59:29'!
negated
	
	^self class with: numerator * (Entero with: -1) over: denominator.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'NB 4/15/2023 18:03:22'!
printOn: aStream
	
	aStream 
			print: numerator;
			nextPut: $/;
			print: denominator.! !


!Fraccion methodsFor: 'accessing' stamp: 'NB 4/16/2023 13:14:17'!
denominator

	^denominator.! !

!Fraccion methodsFor: 'accessing' stamp: 'NB 4/16/2023 13:14:27'!
numerator

	^numerator.! !


!Fraccion methodsFor: 'comparing' stamp: 'NB 4/16/2023 13:00:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator)]! !

!Fraccion methodsFor: 'comparing' stamp: 'NB 4/16/2023 13:01:58'!
hash
	
	^(numerator hash / denominator hash) hash.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'instance creation' stamp: 'NB 4/15/2023 17:26:15'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend isZero ifTrue: [ ^aDividend ].
	
	aDivisor isNegative ifTrue: [ ^self with: aDividend negated over: aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^self new initializeWith: numerator over: denominator! !
