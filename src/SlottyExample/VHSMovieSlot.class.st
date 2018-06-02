Class {
	#name : #VHSMovieSlot,
	#superclass : #Object,
	#instVars : [
		'#title => NilAwareSlot',
		'#internationalTitles => (LazyInitializedSlot default: [ OrderedCollection new ] initializationBlock: [ OrderedCollection new ] baseSlotClass: NilAwareSlot)',
		'#country => NilAwareSlot',
		'#language => NilAwareSlot',
		'#additionalLanguages => (LazyInitializedSlot default: [ OrderedCollection new ] initializationBlock: [ OrderedCollection new ] baseSlotClass: NilAwareSlot)',
		'#producer => NilAwareSlot',
		'#filmingLocations => (LazyInitializedSlot default: [ OrderedCollection new ] initializationBlock: [ OrderedCollection new ] baseSlotClass: NilAwareSlot)',
		'#plotSummary => NilAwareSlot',
		'#plotKeywords => (LazyInitializedSlot default: [ OrderedCollection new ] initializationBlock: [ OrderedCollection new ] baseSlotClass: NilAwareSlot)',
		'#genres => NilAwareSlot',
		'#certificate => NilAwareSlot',
		'#releaseDate => NilAwareSlot',
		'#internationalReleaseDates => (LazyInitializedSlot default: [ OrderedCollection new ] initializationBlock: [ OrderedCollection new ] baseSlotClass: NilAwareSlot)',
		'#budget => NilAwareSlot',
		'#worldwideIncomes => NilAwareSlot',
		'#countryIncomes => NilAwareSlot',
		'#runtime => NilAwareSlot',
		'#awards => (LazyInitializedSlot default: [ OrderedCollection new ] initializationBlock: [ OrderedCollection new ] baseSlotClass: NilAwareSlot)',
		'#cast => (LazyInitializedSlot default: [ OrderedCollection new ] initializationBlock: [ OrderedCollection new ] baseSlotClass: NilAwareSlot)',
		'#director => NilAwareSlot'
	],
	#category : #'SlottyExample-slot'
}

{ #category : #accessing }
VHSMovieSlot >> additionalLanguages [
	^ additionalLanguages
]

{ #category : #accessing }
VHSMovieSlot >> additionalLanguages: anObject [
	additionalLanguages := anObject
]

{ #category : #accessing }
VHSMovieSlot >> awards [
	^ awards
]

{ #category : #accessing }
VHSMovieSlot >> awards: anObject [
	awards := anObject
]

{ #category : #accessing }
VHSMovieSlot >> budget [
	^ budget
]

{ #category : #accessing }
VHSMovieSlot >> budget: anObject [
	budget := anObject
]

{ #category : #accessing }
VHSMovieSlot >> cast [
	^ cast
]

{ #category : #accessing }
VHSMovieSlot >> cast: anObject [
	cast := anObject
]

{ #category : #accessing }
VHSMovieSlot >> certificate [
	^ certificate
]

{ #category : #accessing }
VHSMovieSlot >> certificate: anObject [
	certificate := anObject
]

{ #category : #accessing }
VHSMovieSlot >> country [
	^ country
]

{ #category : #accessing }
VHSMovieSlot >> country: anObject [
	country := anObject
]

{ #category : #accessing }
VHSMovieSlot >> countryIncomes [
	^ countryIncomes
]

{ #category : #accessing }
VHSMovieSlot >> countryIncomes: anObject [
	countryIncomes := anObject
]

{ #category : #accessing }
VHSMovieSlot >> director [
	^ director
]

{ #category : #accessing }
VHSMovieSlot >> director: anObject [
	director := anObject
]

{ #category : #accessing }
VHSMovieSlot >> filmingLocations [
	^ filmingLocations
]

{ #category : #accessing }
VHSMovieSlot >> filmingLocations: anObject [
	filmingLocations := anObject
]

{ #category : #accessing }
VHSMovieSlot >> genres [
	^ genres
]

{ #category : #accessing }
VHSMovieSlot >> genres: anObject [
	genres := anObject
]

{ #category : #initialization }
VHSMovieSlot >> initialize [
	super initialize.
	self class initializeSlots: self.
]

{ #category : #accessing }
VHSMovieSlot >> internationalReleaseDates [
	^ internationalReleaseDates
]

{ #category : #accessing }
VHSMovieSlot >> internationalReleaseDates: anObject [
	internationalReleaseDates := anObject
]

{ #category : #accessing }
VHSMovieSlot >> internationalTitles [
	^ internationalTitles
]

{ #category : #accessing }
VHSMovieSlot >> internationalTitles: anObject [
	internationalTitles := anObject
]

{ #category : #accessing }
VHSMovieSlot >> language [
	^ language
]

{ #category : #accessing }
VHSMovieSlot >> language: anObject [
	language := anObject
]

{ #category : #accessing }
VHSMovieSlot >> plotKeywords [
	^ plotKeywords
]

{ #category : #accessing }
VHSMovieSlot >> plotKeywords: anObject [
	plotKeywords := anObject
]

{ #category : #accessing }
VHSMovieSlot >> plotSummary [
	^ plotSummary
]

{ #category : #accessing }
VHSMovieSlot >> plotSummary: anObject [
	plotSummary := anObject
]

{ #category : #accessing }
VHSMovieSlot >> producer [
	^ producer
]

{ #category : #accessing }
VHSMovieSlot >> producer: anObject [
	producer := anObject
]

{ #category : #accessing }
VHSMovieSlot >> releaseDate [
	^ releaseDate
]

{ #category : #accessing }
VHSMovieSlot >> releaseDate: anObject [
	releaseDate := anObject
]

{ #category : #accessing }
VHSMovieSlot >> runtime [
	^ runtime
]

{ #category : #accessing }
VHSMovieSlot >> runtime: anObject [
	runtime := anObject
]

{ #category : #accessing }
VHSMovieSlot >> title [
	^ title
]

{ #category : #accessing }
VHSMovieSlot >> title: anObject [
	title := anObject
]

{ #category : #accessing }
VHSMovieSlot >> worldwideIncomes [
	^ worldwideIncomes
]

{ #category : #accessing }
VHSMovieSlot >> worldwideIncomes: anObject [
	worldwideIncomes := anObject
]
