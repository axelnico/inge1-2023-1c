!classDefinition: #I category: 'Natural Numbers'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Natural Numbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Natural Numbers'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'Operadores Aritmeticos' stamp: 'NB 3/28/2023 19:57:33'!
* aNaturalNumber
	^ aNaturalNumber.! !

!I class methodsFor: 'Operadores Aritmeticos' stamp: 'NB 3/27/2023 20:36:40'!
+ aNaturalNumber
	^ aNaturalNumber next.! !

!I class methodsFor: 'Operadores Aritmeticos' stamp: 'NB 3/30/2023 20:47:32'!
/ aNaturalNumber
	^ aNaturalNumber divideFrom: self.! !

!I class methodsFor: 'Operadores Aritmeticos' stamp: 'NB 3/29/2023 22:27:32'!
divideFrom: aNumber
	
	^aNumber.! !

!I class methodsFor: 'Operadores Aritmeticos' stamp: 'NB 3/27/2023 20:03:44'!
next
	^II.! !

!I class methodsFor: 'Operadores Aritmeticos' stamp: 'NB 3/29/2023 22:23:32'!
substractFrom: aNumber
	
	^aNumber previous.! !


!classDefinition: #II category: 'Natural Numbers'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Natural Numbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Natural Numbers'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'Operaciones Aritmeticas' stamp: 'NB 3/29/2023 22:17:11'!
* aNumber
	
	^aNumber + (aNumber * self previous).! !

!II class methodsFor: 'Operaciones Aritmeticas' stamp: 'NB 3/27/2023 20:51:08'!
+ aNumber
	
	^previous + aNumber next.! !

!II class methodsFor: 'Operaciones Aritmeticas' stamp: 'NB 3/29/2023 22:55:40'!
- aNumber
	
	^aNumber substractFrom: self.! !

!II class methodsFor: 'Operaciones Aritmeticas' stamp: 'NB 3/29/2023 22:28:44'!
/ aNumber
	
	aNumber = self ifTrue: [^I].
	^aNumber divideFrom: self.! !

!II class methodsFor: 'Operaciones Aritmeticas' stamp: 'NB 3/29/2023 22:26:52'!
divideFrom: aNumber

	^I + (aNumber - self / self).! !

!II class methodsFor: 'Operaciones Aritmeticas' stamp: 'NB 3/30/2023 21:45:17'!
next

	next ifNil: [
		next := II createChildNamed: (self name, 'I').
		next previous: self.
	].
	^next. ! !

!II class methodsFor: 'Operaciones Aritmeticas' stamp: 'NB 3/27/2023 21:33:03'!
previous

	^previous.! !

!II class methodsFor: 'Operaciones Aritmeticas' stamp: 'NB 3/29/2023 22:33:17'!
previous: aNumber

	previous:= aNumber.! !

!II class methodsFor: 'Operaciones Aritmeticas' stamp: 'NB 3/29/2023 22:46:10'!
substractFrom: aNumber

	^aNumber previous -  self previous! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'NB 4/2/2023 15:21:18'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: 'Natural Numbers'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Natural Numbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Natural Numbers'!
III class
	instanceVariableNames: ''!

!III class methodsFor: '--** private fileout/in **--' stamp: 'NB 4/2/2023 15:21:18'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !


!classDefinition: #IIII category: 'Natural Numbers'!
II subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Natural Numbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'Natural Numbers'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: '--** private fileout/in **--' stamp: 'NB 4/2/2023 15:21:18'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIII.
	previous := III.! !


!classDefinition: #IIIII category: 'Natural Numbers'!
II subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Natural Numbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: 'Natural Numbers'!
IIIII class
	instanceVariableNames: ''!

!IIIII class methodsFor: '--** private fileout/in **--' stamp: 'NB 4/2/2023 15:21:18'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIII.
	previous := IIII.! !


!classDefinition: #IIIIII category: 'Natural Numbers'!
II subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Natural Numbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIII class' category: 'Natural Numbers'!
IIIIII class
	instanceVariableNames: ''!

!IIIIII class methodsFor: '--** private fileout/in **--' stamp: 'NB 4/2/2023 15:21:18'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := IIIII.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!
IIIIII initializeAfterFileIn!