Class {
	#name : #NilAwareSlotTest,
	#superclass : #TestCase,
	#instVars : [
		'createdClasses'
	],
	#category : #'Slot-Extensions'
}

{ #category : #assertions }
NilAwareSlotTest >> assertNilMapOf: anObject equals: aValue [ 

	self assert: (self nilMapOf: anObject) equals: aValue.
]

{ #category : #assertions }
NilAwareSlotTest >> assertValuesOf: anObject equals: aValue [ 

	self assert: (self valuesOf: anObject) equals: aValue.
]

{ #category : #utils }
NilAwareSlotTest >> compileAccessors: slotNames into: aClass [ 

	slotNames do: [ :aName | aClass compile: aName , ' ^', aName. ].
	slotNames do: [ :aName | aClass compile: aName , ': aValue ', aName , ' := aValue' ].

]

{ #category : #'instance creation' }
NilAwareSlotTest >> newClass: aName superclass: aSuperclass with: slots [
	
	^ self newClass: aName superclass: aSuperclass with: slots uses: #()
]

{ #category : #'instance creation' }
NilAwareSlotTest >> newClass: aName superclass: aSuperclass with: slots uses: aComposition [
	
	^ self newClass: aName superclass: aSuperclass with: slots uses: aComposition category: 'Slot-Extensions-TestClasses' 
]

{ #category : #'instance creation' }
NilAwareSlotTest >> newClass: aName superclass: aSuperclass with: slots uses: aComposition category: category [
	| class |
	class := aSuperclass subclass: aName uses: aComposition slots: slots classVariables: #() poolDictionaries: '' category: category. 
	createdClasses add:class.
	
	^class.
]

{ #category : #'instance creation' }
NilAwareSlotTest >> newClass: aName with: slots [
	
	^ self newClass: aName superclass: Object with: slots uses: #()
]

{ #category : #utils }
NilAwareSlotTest >> nilMapOf: anObject [
	| slot |
	slot := anObject class slotNamed: NilAwareSlot nilMapSlotName.
	^ slot read: anObject
]

{ #category : #running }
NilAwareSlotTest >> setUp [
	super setUp.
	createdClasses := Set new.
]

{ #category : #running }
NilAwareSlotTest >> tearDown [
	createdClasses do:#removeFromSystem.
	super tearDown.
	

]

{ #category : #tests }
NilAwareSlotTest >> testEmptyInstanceInternals [

	| c1 obj slots slotNames |
	
	slotNames := #(a b c d e f g h i j k l m n o p q r s t u v w x y z).
	
	slots := slotNames collect: [ :aName | aName => NilAwareSlot ].
	c1 := self newClass: #C1 with: slots.
		
	self compileAccessors: slotNames into: c1.
	
	obj := c1 new.

	self assertValuesOf: obj equals: nil.
	self assertNilMapOf: obj equals: 0.
]

{ #category : #tests }
NilAwareSlotTest >> testSmallClassHavingSomeInternal [

	| c1 obj slots slotNames values|
	
	slotNames := #(a b c d e f g).
	values := { 1. nil. 2. nil. 3. nil. 4 }.
	
	slots := slotNames collect: [ :aName | aName => NilAwareSlot ].
	c1 := self newClass: #C1 with: slots.
		
	self compileAccessors: slotNames into: c1.
	
	obj := c1 new.

	slotNames doWithIndex: [ :aName :anIndex | obj perform: aName asMutator with: (values at: anIndex) ].	
	slotNames doWithIndex: [ :aName :anIndex | self assert: (obj perform: aName) equals: (values at: anIndex) ].	

	self assertValuesOf: obj equals: #(1 2 3 4).
	self assertNilMapOf: obj equals: 2r1010101.	
]

{ #category : #tests }
NilAwareSlotTest >> testSmallClassHavingValuesInternals [

	| c1 obj slots slotNames values|
	
	slotNames := #(a b c d e f g).
	values := slotNames collect: [ :x | Object new ].
	
	slots := slotNames collect: [ :aName | aName => NilAwareSlot ].
	c1 := self newClass: #C1 with: slots.
		
	self compileAccessors: slotNames into: c1.
	
	obj := c1 new.

	slotNames doWithIndex: [ :aName :anIndex | obj perform: aName asMutator with: (values at: anIndex) ].	

	self assertValuesOf: obj equals: values asArray.
	self assertNilMapOf: obj equals: 127.
	
	slotNames doWithIndex: [ :aName :anIndex | self assert: (obj perform: aName) equals: (values at: anIndex) ].	


]

{ #category : #tests }
NilAwareSlotTest >> testSmallClassInAValue [

	| c1 obj slots slotNames|
	
	slotNames := #(a b c d e f g).
	
	slots := slotNames collect: [ :aName | aName => NilAwareSlot ].
	c1 := self newClass: #C1 with: slots.
		
	self compileAccessors: slotNames into: c1.
	
	obj := c1 new.

	slotNames do: [ :aName | obj perform: aName asMutator with: 1 ].	
	slotNames do: [ :aName | self assert: (obj perform: aName) equals: 1 ].

]

{ #category : #tests }
NilAwareSlotTest >> testSmallClassInNil [

	| c1 obj slots slotNames|
	
	slotNames := #(a b c d e f g).
	
	slots := slotNames collect: [ :aName | aName => NilAwareSlot ].
	c1 := self newClass: #C1 with: slots.
		
	self compileAccessors: slotNames into: c1.
	
	obj := c1 new.
	
	slotNames do: [ :aName | self assert: (obj perform: aName) isNil ].

]

{ #category : #tests }
NilAwareSlotTest >> testSmallClassInNilAfterHavingValues [

	| c1 obj slots slotNames values|
	
	slotNames := #(a b c d e f g).
	values := slotNames collect: [ :x | Object new ].
	
	slots := slotNames collect: [ :aName | aName => NilAwareSlot ].
	c1 := self newClass: #C1 with: slots.
		
	self compileAccessors: slotNames into: c1.
	
	obj := c1 new.

	slotNames doWithIndex: [ :aName :anIndex | obj perform: aName asMutator with: (values at: anIndex) ].	
	slotNames doWithIndex: [ :aName :anIndex | self assert: (obj perform: aName) equals: (values at: anIndex) ].	

	slotNames doWithIndex: [ :aName :anIndex | obj perform: aName asMutator with: nil ].	
	slotNames do: [ :aName | self assert: (obj perform: aName) isNil ].

]

{ #category : #tests }
NilAwareSlotTest >> testSmallClassInNilAfterHavingValuesInRandomAccess [

	| c1 obj slots slotNames values|
	
	slotNames := #(a b c d e f g h i j k l m n o p q r s t u v w x y z).
	values := slotNames collect: [ :x | Object new ].
	
	slots := slotNames collect: [ :aName | aName => NilAwareSlot ].
	c1 := self newClass: #C1 with: slots.
		
	self compileAccessors: slotNames into: c1.
	
	obj := c1 new.

	slotNames shuffle do: [ :aName | obj perform: aName asMutator with: (values at: (slotNames indexOf: aName)) ].	
		
	slotNames doWithIndex: [ :aName :anIndex | self assert: (obj perform: aName) equals: (values at: anIndex) ].	
	slotNames shuffle do: [ :aName | obj perform: aName asMutator with: nil ].	
	slotNames do: [ :aName | self assert: (obj perform: aName) isNil ].

]

{ #category : #tests }
NilAwareSlotTest >> testSmallClassInNilAfterHavingValuesInternals [

	| c1 obj slots slotNames values|
	
	slotNames := #(a b c d e f g).
	values := slotNames collect: [ :x | Object new ].
	
	slots := slotNames collect: [ :aName | aName => NilAwareSlot ].
	c1 := self newClass: #C1 with: slots.
		
	self compileAccessors: slotNames into: c1.
	
	obj := c1 new.

	slotNames doWithIndex: [ :aName :anIndex | obj perform: aName asMutator with: (values at: anIndex) ].	
	slotNames doWithIndex: [ :aName :anIndex | self assert: (obj perform: aName) equals: (values at: anIndex) ].	

	slotNames doWithIndex: [ :aName :anIndex | obj perform: aName asMutator with: nil ].	

	self assertValuesOf: obj equals: nil.
	self assertNilMapOf: obj equals: 0.	
]

{ #category : #tests }
NilAwareSlotTest >> testSmallClassInNilInternals [

	| c1 obj slots slotNames|
	
	slotNames := #(a b c d e f g).
	
	slots := slotNames collect: [ :aName | aName => NilAwareSlot ].
	c1 := self newClass: #C1 with: slots.
		
	self compileAccessors: slotNames into: c1.
	
	obj := c1 new.
	
	self assertValuesOf: obj equals: nil.
	self assertNilMapOf: obj equals: 0.	
]

{ #category : #tests }
NilAwareSlotTest >> testSmallClassSimple [

	| c1 obj slots slotNames |
	
	slotNames := #(a b c d e f g).
	
	slots := slotNames collect: [ :aName | aName => NilAwareSlot ].
	c1 := self newClass: #C1 with: slots.
		
	self compileAccessors: slotNames into: c1.
	
	obj := c1 new.
	obj perform: #a: with: 1.

	self assertValuesOf: obj equals: #(1).
	self assertNilMapOf: obj equals: 1.	
]

{ #category : #tests }
NilAwareSlotTest >> testSmallClassSimple2 [

	| c1 obj slots slotNames |
	
	slotNames := #(a b c d e f g).
	
	slots := slotNames collect: [ :aName | aName => NilAwareSlot ].
	c1 := self newClass: #C1 with: slots.
		
	self compileAccessors: slotNames into: c1.
	
	obj := c1 new.
	obj perform: #a: with: 1.
	obj perform: #c: with: 2.

	self assertValuesOf: obj equals: #(1 2).
	self assertNilMapOf: obj equals: 5.	
]

{ #category : #tests }
NilAwareSlotTest >> testSmallClassSimpleWithHole [

	| c1 obj slots slotNames |
	
	slotNames := #(a b c d e f g).
	
	slots := slotNames collect: [ :aName | aName => NilAwareSlot ].
	c1 := self newClass: #C1 with: slots.
		
	self compileAccessors: slotNames into: c1.
	
	obj := c1 new.
	obj perform: #a: with: 1.
	obj perform: #e: with: 2.

	self assertValuesOf: obj equals: #(1 2).
	self assertNilMapOf: obj equals: 2r10001.	
]

{ #category : #tests }
NilAwareSlotTest >> testSmallClassWithDifferentValues [

	| c1 obj slots slotNames values |
	
	slotNames := #(a b c d e f g).
	values := slotNames collect: [ :x | Object new ].
	
	slots := slotNames collect: [ :aName | aName => NilAwareSlot ].
	c1 := self newClass: #C1 with: slots.
		
	self compileAccessors: slotNames into: c1.
	
	obj := c1 new.

	slotNames doWithIndex: [ :aName :anIndex | obj perform: aName asMutator with: (values at: anIndex) ].	
	slotNames doWithIndex: [ :aName :anIndex | self assert: (obj perform: aName) equals: (values at: anIndex) ].

]

{ #category : #tests }
NilAwareSlotTest >> testSmallClassWithDifferentValuesInSubclass [

	| c1 c2 obj slots slotNames values |
	
	slotNames := #(a b c d e f g h i j k l m n o p q r s t u v w x y z).
	values := slotNames collect: [ :x | Object new ].
	
	slots := slotNames collect: [ :aName | aName => NilAwareSlot ].

	c1 := self newClass: #C1 with: (slots copyFrom: 1 to: 5).
	c2 := self newClass: #C2 superclass: c1 with: (slots copyFrom: 6 to: slots size).
		
	self compileAccessors: slotNames into: c2.
	
	obj := c2 new.

	slotNames doWithIndex: [ :aName :anIndex | obj perform: aName asMutator with: (values at: anIndex) ].	
	slotNames doWithIndex: [ :aName :anIndex | self assert: (obj perform: aName) equals: (values at: anIndex) ].

]

{ #category : #utils }
NilAwareSlotTest >> valuesOf: anObject [
	| slot |
	slot := anObject class slotNamed: NilAwareSlot valuesSlotName.
	^ slot read: anObject
]
