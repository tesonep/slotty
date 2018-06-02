Class {
	#name : #VHSPersonSlot,
	#superclass : #Object,
	#instVars : [
		'#name => NilAwareSlot',
		'#movies => (LazyInitializedSlot default: [ OrderedCollection new ] initializationBlock: [ OrderedCollection new ] baseSlotClass: NilAwareSlot)',
		'#birthday => NilAwareSlot'
	],
	#category : #'SlottyExample-slot'
}

{ #category : #initialization }
VHSPersonSlot >> initialize [
	super initialize.
	self class initializeSlots: self.
]
