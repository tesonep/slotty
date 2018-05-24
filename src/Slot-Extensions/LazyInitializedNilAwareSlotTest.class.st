Class {
	#name : #LazyInitializedNilAwareSlotTest,
	#superclass : #LazyInitializedSlotTest,
	#category : #'Slot-Extensions'
}

{ #category : #tests }
LazyInitializedNilAwareSlotTest >> slotDefinitions [

	^ { #anSlot => (LazyInitializedSlot default: [ OrderedCollection new ] initializationBlock: [ OrderedCollection new ] baseSlot: NilAwareSlot new) }
]
