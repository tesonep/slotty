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
ReadOnlyWrapper >> asString [
	^ self doesNotUnderstand: (Message selector: #asString arguments: {})
]

{ #category : #accessing }
ReadOnlyWrapper >> at: anIndex [
	^ self doesNotUnderstand: (Message selector: #at: arguments: {anIndex})
]

{ #category : #accessing }
ReadOnlyWrapper >> at: anIndex put: anObject [
	^ self
		doesNotUnderstand:
			(Message
				selector: #at:put:
				arguments:
					{anIndex.
					anObject})
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
		
		newInstance := slot initializationBlock value beWritableObject; yourself   .	
		slot write: newInstance to: target.
	
		(self class allInstances select: [ :e | e = self ])
			do: [ :e | e becomeForward: newInstance ].
	
		^ aMessage sendTo: newInstance
   ].
]

{ #category : #accessing }
ReadOnlyWrapper >> printString [
	^ self doesNotUnderstand: (Message selector: #printString arguments: {})
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
ReadOnlyWrapper >> size [
	^ self doesNotUnderstand: (Message selector: #size arguments: {})
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
