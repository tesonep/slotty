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

{ #category : #'code generation' }
LazyInitializedSlot >> emitStore: aMethodBuilder [

	aMethodBuilder storeInstVar: index
]

{ #category : #'code generation' }
LazyInitializedSlot >> emitValue: methodBuilder [

	methodBuilder 
		pushInstVar: index;
		pushDup;
		pushLiteral: nil;
		send: #==;
		jumpAheadTo: #nilValue if: false;
		popTop;
		pushLiteralVariable: #slot -> self;
		pushReceiver;
		send: #readOnlyWrapperFor:;
		jumpAheadTarget: #nilValue.
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
	^ self wrapperFor: anObject orValue: obj.
]

{ #category : #'meta-object-protocol' }
LazyInitializedSlot >> readOnlyWrapperFor: anObject [
	^ ReadOnlyWrapper new
		slot: self;
		sharedValue: defaultValue;
		creationBlock: initializationBlock;
		target: anObject;
		yourself
]

{ #category : #'meta-object-protocol' }
LazyInitializedSlot >> wrapperFor: anObject orValue: obj [
	^ obj ifNil: [ self readOnlyWrapperFor: anObject ]
]
