Class {
	#name : #LazyInitializedSlotTest,
	#superclass : #TestCase,
	#instVars : [
		'testClass'
	],
	#category : #'Slot-Extensions'
}

{ #category : #tests }
LazyInitializedSlotTest >> setUp [

 super setUp.

 testClass := Object subclass: #OrderedCollectionTestClass
	slots: { #anSlot => (LazyInitializedSlot default: [ OrderedCollection new ] initializationBlock: [ OrderedCollection new ]) }
	classVariables: {  }
	package: 'Slot-Extensions'.
	

 testClass compile: 'anSlot ^ anSlot'.
]

{ #category : #tests }
LazyInitializedSlotTest >> tearDown [
	
	testClass ifNotNil: #removeFromSystem.
	super tearDown.
]

{ #category : #tests }
LazyInitializedSlotTest >> testReferenceToProxyIsUpdated [
	| x r |
	x := testClass new.
	
	self assert: (x instVarAt: 1) isNil.
	r := x anSlot.
	
	self assert: x anSlot isEmpty.	
	self assert: x anSlot equals: r.

	x anSlot add: 12.
	
	self assert: r isEmpty not.	
	self assert: x anSlot equals: r.

]

{ #category : #tests }
LazyInitializedSlotTest >> testReturningAlwaysTheSame [
	| x r |
	x := testClass new.
	
	self assert: (x instVarAt: 1) isNil.
	r := x anSlot.
	
	self assert: x anSlot isEmpty.	
	self assert: x anSlot equals: r.

]

{ #category : #tests }
LazyInitializedSlotTest >> testSimpleAdding [
	| x |
	x := testClass new.
	
	self assert: (x instVarAt: 1) isNil.
	self assert: x anSlot isEmpty.
	
	self assert: (x anSlot add: 12) equals: 12.
	self deny: x anSlot isEmpty
]

{ #category : #tests }
LazyInitializedSlotTest >> testValidatesCleanBlocks [

	| a b |

	a := b := 1.

	self should: [ testClass := Object
		subclass: #OrderedCollectionTestClass
		slots: {(#anSlot => (LazyInitializedSlot default: [ a ] initializationBlock: [ OrderedCollection new ]))}
		classVariables: {}
		package: 'Slot-Extensions' ] raise: Error.
	
	self should: [ testClass := Object
		subclass: #OrderedCollectionTestClass
		slots: {(#anSlot => (LazyInitializedSlot default: [ 2 ] initializationBlock: [ b ]))}
		classVariables: {}
		package: 'Slot-Extensions' ] raise: Error.
]
