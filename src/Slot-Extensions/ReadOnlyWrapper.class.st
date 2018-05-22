Class {
	#name : #ReadOnlyWrapper,
	#superclass : #Object,
	#instVars : [
		'slot',
		'target',
		'sharedValue',
		'creationBlock'
	],
	#category : #'Slot-Extensions'
}

{ #category : #accessing }
ReadOnlyWrapper >> = another [
	^ self species = another species and: [ target = another target and: [ slot = another slot ] ]
]

{ #category : #accessing }
ReadOnlyWrapper >> creationBlock [
	^ creationBlock
]

{ #category : #accessing }
ReadOnlyWrapper >> creationBlock: anObject [
	creationBlock := anObject
]

{ #category : #accessing }
ReadOnlyWrapper >> doesNotUnderstand: aMessage [ 
	| newInstance |
	
	^ [ aMessage sendTo: sharedValue ] on: ModificationForbidden do: [
		
		newInstance := OrderedCollection new.	
		slot write: newInstance to: target.
	
		(self class allInstances select: [ :e | e = self ])
			do: [ :e | e becomeForward: newInstance ].
	
		^ aMessage sendTo: newInstance
   ].
]

{ #category : #accessing }
ReadOnlyWrapper >> sharedValue [
	^ sharedValue
]

{ #category : #accessing }
ReadOnlyWrapper >> sharedValue: anObject [
	sharedValue := anObject
]

{ #category : #accessing }
ReadOnlyWrapper >> slot [
	^ slot
]

{ #category : #accessing }
ReadOnlyWrapper >> slot: anObject [
	slot := anObject
]

{ #category : #accessing }
ReadOnlyWrapper >> target [
	^ target
]

{ #category : #accessing }
ReadOnlyWrapper >> target: anObject [
	target := anObject
]
