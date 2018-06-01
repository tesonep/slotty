Class {
	#name : #ReadOnlyWrapper,
	#superclass : #Object,
	#instVars : [
		'#slot',
		'#sharedValue',
		'#creationBlock',
		'#target => WeakSlot'
	],
	#classVars : [
		'#InstanceMap'
	],
	#category : #'Slot-Extensions'
}

{ #category : #accessing }
ReadOnlyWrapper class >> instanceMap [
	
	^ InstanceMap ifNil: [ InstanceMap := WeakIdentityKeyDictionary new ].
]

{ #category : #'instance creation' }
ReadOnlyWrapper class >> newForSlot: aSlot sharedValue: defaultValue creationBlock: initializationBlock target: target [

	| wrapper |
	wrapper := self wrapperFor: target slot: aSlot.
	
	wrapper ifNotNil: [ ^ wrapper ].
	
	wrapper := self new
		slot: aSlot;
		sharedValue: (defaultValue value beReadOnlyObject; yourself);
		creationBlock: initializationBlock;
		target: target;
		yourself.
		
	self wrapperFor: target slot: aSlot put: wrapper.
	
	^ wrapper
		 
	
	
]

{ #category : #wrappers }
ReadOnlyWrapper class >> removeWrapper: aSlot of: aTarget [ 
	
	| slots |
	slots := self instanceMap at: aTarget ifAbsent: [ ^ self ].
	slots removeKey: aSlot name.
	
	slots ifEmpty: [ self instanceMap removeKey: aTarget ].
]

{ #category : #'instance creation' }
ReadOnlyWrapper class >> replaceWrapper: aSlot of: aTarget with: aValue [
	| wrapper |

	wrapper := self wrapperFor: aTarget slot: aSlot.
	self removeWrapper: aSlot of: aTarget.

	wrapper becomeForward: aValue.

]

{ #category : #'instance creation' }
ReadOnlyWrapper class >> resetWrappers [
	InstanceMap := nil.
]

{ #category : #'instance creation' }
ReadOnlyWrapper class >> wrapperFor: aTarget slot: aSlot [ 
	
	| slots |
	slots := self instanceMap at: aTarget ifAbsent: [ ^ nil ].
	^ slots at: aSlot name ifAbsent: [ nil ].
]

{ #category : #'instance creation' }
ReadOnlyWrapper class >> wrapperFor: aTarget slot: aSlot put: wrapper [ 
	
	| slots |
	slots := self instanceMap at: aTarget ifAbsentPut: [ WeakIdentityValueDictionary new ].
	slots at: aSlot name put: wrapper.
]

{ #category : #accessing }
ReadOnlyWrapper >> = another [
	^ self species = another species
		and: [ target == another target and: [ slot == another slot ] ]
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
		
		newInstance := creationBlock value.

		target ifNotNil: [ slot basicWrite: newInstance to: target ].
	
		self class removeWrapper: slot of: target.		

		self becomeForward: newInstance.
	
		^ aMessage sendTo: newInstance
   ].
]

{ #category : #initialization }
ReadOnlyWrapper >> initialize [
	super initialize.
	self class initializeSlots: self.
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
