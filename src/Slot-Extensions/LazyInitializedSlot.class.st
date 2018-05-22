Class {
	#name : #LazyInitializedSlot,
	#superclass : #IndexedSlot,
	#instVars : [
		'defaultValue',
		'initializationBlock'
	],
	#category : #'Slot-Extensions'
}

{ #category : #'instance creation' }
LazyInitializedSlot class >> default: aDefaultBlock initializationBlock: anInitializationBlock [ 

	(aDefaultBlock isClean) ifFalse: [ self error: 'Default value block should be clean (only using globally access variables)' ].
	(anInitializationBlock isClean) ifFalse: [ self error: 'Initialization block should be clean (only using globally access variables)' ].

	^ self new
		defaultValue: (aDefaultBlock value beReadOnlyObject; yourself);
		initializationBlock: anInitializationBlock;
		yourself.
]

{ #category : #accessing }
LazyInitializedSlot >> defaultValue [
	^ defaultValue
]

{ #category : #accessing }
LazyInitializedSlot >> defaultValue: anObject [
	defaultValue := anObject
]

{ #category : #printing }
LazyInitializedSlot >> definitionString [
	^ String
		streamContents: [ :s | 
			s
				nextPutAll: name printString;
				space;
				nextPutAll: '=>';
				space;
				nextPut: $(;
				nextPutAll: self class name;
				space;
				nextPutAll: 'default: ';
				nextPutAll: defaultValue asString;
				space;
				nextPutAll: 'initializationBlock: ';
				nextPutAll: initializationBlock printString;
				nextPut: $) ]
]

{ #category : #accessing }
LazyInitializedSlot >> initializationBlock [
	^ initializationBlock
]

{ #category : #accessing }
LazyInitializedSlot >> initializationBlock: anObject [
	initializationBlock := anObject
]

{ #category : #'meta-object-protocol' }
LazyInitializedSlot >> read: anObject [
	| obj |
	obj := super read: anObject.
	^ obj
		ifNil: [ 
				ReadOnlyWrapper new
					slot: self;
					sharedValue: defaultValue;
					creationBlock: initializationBlock;
					target: anObject;				
					yourself ]
		ifNotNil: [ obj ]
]
