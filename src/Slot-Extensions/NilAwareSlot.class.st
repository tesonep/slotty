Class {
	#name : #NilAwareSlot,
	#superclass : #Slot,
	#instVars : [
		'index',
		'nilMapSlot',
		'valuesSlot',
		'cachedNilMap',
		'cachedIndex'
	],
	#category : #'Slot-Extensions'
}

{ #category : #'accessing slots' }
NilAwareSlot class >> nilMapSlotName [
	
	^ #_nilMap
]

{ #category : #'accessing slots' }
NilAwareSlot class >> valuesSlotName [
	
	^ #_valuesNotNil
]

{ #category : #'meta-object-protocol' }
NilAwareSlot >> doWrite: aValue to: anObject [ 
	| nilMap newValues oldValues usedIndexes|

	"Using the original nilMap I calculate the used indexes and the original values."
	nilMap := (self nilMapSlot read: anObject) ifNil: [0].
	usedIndexes := self usedIndexesOf: nilMap.
	oldValues := (self valuesSlot read: anObject) ifNil: [#()].

	"I update the nilMap with the used bit, and create a new values"
	nilMap := nilMap bitAt: index put: 1.
	newValues := Array new: (self usedIndexesOf: nilMap) size.

	"Copy the oldValues and add the modified variable"
	oldValues with: usedIndexes do: [ :v :i | newValues at: (self translateIndex: i using: nilMap) put: v ].
	newValues at: (self translateIndexUsing: nilMap) put: aValue.

	"Store the state"
	self nilMapSlot write: nilMap to: anObject.
	self valuesSlot write: newValues to: anObject.

	^ aValue.
]

{ #category : #accessing }
NilAwareSlot >> index [
	^ index
]

{ #category : #accessing }
NilAwareSlot >> index: anObject [
	index := anObject
]

{ #category : #testing }
NilAwareSlot >> isVirtual [
	^ true
]

{ #category : #'meta-object-protocol' }
NilAwareSlot >> layoutChanged: aClass [
	super layoutChanged: aClass.

	nilMapSlot := nil.
	valuesSlot := nil.

	(aClass allSlots select: [ :each | each isKindOf: NilAwareSlot ]) doWithIndex: [:each :anIndex | each index: anIndex ].

	(aClass classLayout hasSlotNamed: self class nilMapSlotName)
		ifTrue: [ ^ self ]. 

	aClass classInstaller update: aClass to: [ :builder |
		builder
			fillFor: aClass;
			slots: ((aClass slots copyWith:(self class nilMapSlotName => BaseSlot default: 0)) copyWith:(self class valuesSlotName => BaseSlot default: nil))].			
			

]

{ #category : #'accessing slots' }
NilAwareSlot >> nilMapSlot [
	^ nilMapSlot ifNil: [ nilMapSlot := self owningClass slotNamed: self class nilMapSlotName ]
]

{ #category : #'meta-object-protocol' }
NilAwareSlot >> read: anObject [
	| nilMap values |
	nilMap := (self nilMapSlot read: anObject) ifNil: [0].
	index ifNil: [ ^nil ].
	(nilMap bitAt: index) = 0 ifTrue: [ ^nil ].
	
	values := self valuesSlot read: anObject.
	
	^ values at: (self translateIndexUsing: nilMap).
	
]

{ #category : #utils }
NilAwareSlot >> translateIndex: anIndex using: aNilMap [ 
	
	^ (1 to: anIndex) sumNumbers: [ :i | aNilMap bitAt: i]
]

{ #category : #utils }
NilAwareSlot >> translateIndexUsing: aNilMap [ 
	
	(cachedNilMap = aNilMap) 
		ifTrue: [ ^ cachedIndex ]. 
	
	cachedNilMap := aNilMap.
	^ cachedIndex := self translateIndex: index using: aNilMap
]

{ #category : #utils }
NilAwareSlot >> usedIndexesOf: aBitMap [ 
	| used remaining idx |	
	used := OrderedCollection new.

	remaining := aBitMap.
	idx := 1.
	
	[ remaining = 0 ] whileFalse: [ 
		(remaining bitAt: idx) = 1 ifTrue: [ used add: idx ].
		remaining := remaining bitAt: idx put: 0.
		idx := idx + 1.
	].

	^ used asArray.
]

{ #category : #'accessing slots' }
NilAwareSlot >> valuesSlot [

	^ valuesSlot ifNil: [ valuesSlot := self owningClass slotNamed: self class valuesSlotName ]
]

{ #category : #'meta-object-protocol' }
NilAwareSlot >> write: aValue to: anObject [
	
	^ aValue ifNil: [ self writeNilTo: anObject ] ifNotNil: [ self doWrite: aValue to: anObject ].
]

{ #category : #'meta-object-protocol' }
NilAwareSlot >> writeNilTo: anObject [

	| nilMap values |
	nilMap := (self nilMapSlot read: anObject) ifNil: [0].
	(nilMap bitAt: index) = 0 ifTrue: [^ nil].

	values := self valuesSlot read: anObject.
	values at: (self translateIndexUsing: nilMap) put: nil.

	nilMap := nilMap bitAt: index put: 0.
	self nilMapSlot write: nilMap to: anObject.


	values := values copyWithout: nil.	
	values size = 0 ifTrue: [ values := nil ].
	
  	self valuesSlot write: values to: anObject.
		
	^ nil.
]
