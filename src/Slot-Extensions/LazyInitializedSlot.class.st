Class {
	#name : #LazyInitializedSlot,
	#superclass : #IndexedSlot,
	#instVars : [
		'defaultValue',
		'initializationBlock',
		'baseSlot'
	],
	#category : #'Slot-Extensions'
}

{ #category : #'instance creation' }
LazyInitializedSlot class >> default: aDefaultBlock initializationBlock: anInitializationBlock [
	aDefaultBlock isClean
		ifFalse: [ self error: 'Default value block should be clean (only using globally access variables)' ].
	anInitializationBlock isClean
		ifFalse: [ self error: 'Initialization block should be clean (only using globally access variables)' ].
	^ self new
		defaultValue: aDefaultBlock ;
		initializationBlock: anInitializationBlock;
		yourself
]

{ #category : #'instance creation' }
LazyInitializedSlot class >> default: aDefaultBlock initializationBlock: anInitializationBlock baseSlot: aSlot [
	aDefaultBlock isClean
		ifFalse: [ self error: 'Default value block should be clean (only using globally access variables)' ].
	anInitializationBlock isClean
		ifFalse: [ self error: 'Initialization block should be clean (only using globally access variables)' ].
	^ self new
		defaultValue: aDefaultBlock ;
		initializationBlock: anInitializationBlock;
		baseSlot: aSlot;
		yourself
]

{ #category : #'instance creation' }
LazyInitializedSlot class >> default: aDefaultBlock initializationBlock: anInitializationBlock baseSlotClass: aSlotClass [

	^ self default: aDefaultBlock initializationBlock: anInitializationBlock baseSlot: aSlotClass new.
]

{ #category : #comparing }
LazyInitializedSlot >> = other [

	^ ((super = other and: [ defaultValue = other defaultValue ])
		and: [ initializationBlock = other initializationBlock ])
		and: [ baseSlot = other baseSlot ]
]

{ #category : #accessing }
LazyInitializedSlot >> baseSlot [
	^ baseSlot
]

{ #category : #accessing }
LazyInitializedSlot >> baseSlot: anObject [
	baseSlot := anObject
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
				nextPutAll: defaultValue printString;
				space;
				nextPutAll: 'initializationBlock: ';
				nextPutAll: initializationBlock printString;
				nextPut: $) ]
]

{ #category : #'code generation' }
LazyInitializedSlot >> emitStore: aMethodBuilder [

	baseSlot ifNotNil: [ ^ baseSlot emitStore: aMethodBuilder ].

	aMethodBuilder storeInstVar: index
]

{ #category : #'code generation' }
LazyInitializedSlot >> emitValue: methodBuilder [

	baseSlot 
		ifNil: [ 	methodBuilder pushInstVar: index ]
		ifNotNil: [ baseSlot emitValue: methodBuilder ].

	methodBuilder 
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

{ #category : #testing }
LazyInitializedSlot >> isVirtual [
	^ baseSlot isNotNil
]

{ #category : #'class building' }
LazyInitializedSlot >> layoutChanged: aClass [
	super layoutChanged: aClass.
	
	baseSlot ifNil: [ ^ self ].

	(aClass classLayout hasSlot: baseSlot)
		ifTrue: [ ^ self ]. 
		
	aClass addSlot: baseSlot

]

{ #category : #accessing }
LazyInitializedSlot >> name: aName [
	super name: aName.
	baseSlot ifNotNil: [	baseSlot name: ('_' , aName) asSymbol]
]

{ #category : #'meta-object-protocol' }
LazyInitializedSlot >> read: anObject [
	| obj |
	obj := baseSlot ifNil: [super read: anObject] ifNotNil: [ baseSlot read: anObject ].
	^ self wrapperFor: anObject orValue: obj.
]

{ #category : #'meta-object-protocol' }
LazyInitializedSlot >> readOnlyWrapperFor: anObject [
	^ ReadOnlyWrapper new
		slot: self;
		sharedValue:
			(defaultValue value
				beReadOnlyObject;
				yourself);
		creationBlock: initializationBlock;
		target: anObject;
		yourself
]

{ #category : #'meta-object-protocol' }
LazyInitializedSlot >> wrapperFor: anObject orValue: obj [
	^ obj ifNil: [ self readOnlyWrapperFor: anObject ]
]

{ #category : #'meta-object-protocol' }
LazyInitializedSlot >> write: aValue to: anObject [

	^ baseSlot ifNil: [super write: aValue to: anObject] ifNotNil: [ baseSlot write: aValue to: anObject ].
]
