Class {
	#name : #VHSMovieAdhoc,
	#superclass : #Object,
	#instVars : [
		'values'
	],
	#category : #'SlottyExample-adhoc'
}

{ #category : #'as yet unclassified' }
VHSMovieAdhoc >> additionalLanguages [ ^ values at: #additionalLanguages
]

{ #category : #'as yet unclassified' }
VHSMovieAdhoc >> additionalLanguages:aValue [ ^ values at: #additionalLanguages put: aValue
]

{ #category : #'as yet unclassified' }
VHSMovieAdhoc >> awards [ ^ values at: #awards
]

{ #category : #'as yet unclassified' }
VHSMovieAdhoc >> awards:aValue [ ^ values at: #awards put: aValue
]

{ #category : #'as yet unclassified' }
VHSMovieAdhoc >> budget [ ^ values at: #budget
]

{ #category : #'as yet unclassified' }
VHSMovieAdhoc >> budget:aValue [ ^ values at: #budget put: aValue
]

{ #category : #'as yet unclassified' }
VHSMovieAdhoc >> cast [ ^ values at: #cast
]

{ #category : #'as yet unclassified' }
VHSMovieAdhoc >> cast:aValue [ ^ values at: #cast put: aValue
]

{ #category : #'as yet unclassified' }
VHSMovieAdhoc >> certificate [ ^ values at: #certificate
]

{ #category : #'as yet unclassified' }
VHSMovieAdhoc >> certificate:aValue [ ^ values at: #certificate put: aValue
]

{ #category : #'as yet unclassified' }
VHSMovieAdhoc >> country [ ^ values at: #country
]

{ #category : #'as yet unclassified' }
VHSMovieAdhoc >> country:aValue [ ^ values at: #country put: aValue
]

{ #category : #'as yet unclassified' }
VHSMovieAdhoc >> countryIncomes [ ^ values at: #countryIncomes
]

{ #category : #'as yet unclassified' }
VHSMovieAdhoc >> countryIncomes:aValue [ ^ values at: #countryIncomes put: aValue
]

{ #category : #'as yet unclassified' }
VHSMovieAdhoc >> director [ ^ values at: #director
]

{ #category : #'as yet unclassified' }
VHSMovieAdhoc >> director:aValue [ ^ values at: #director put: aValue
]

{ #category : #'as yet unclassified' }
VHSMovieAdhoc >> filmingLocations [ ^ values at: #filmingLocations
]

{ #category : #'as yet unclassified' }
VHSMovieAdhoc >> filmingLocations:aValue [ ^ values at: #filmingLocations put: aValue
]

{ #category : #'as yet unclassified' }
VHSMovieAdhoc >> genres [ ^ values at: #genres
]

{ #category : #'as yet unclassified' }
VHSMovieAdhoc >> genres:aValue [ ^ values at: #genres put: aValue
]

{ #category : #initialization }
VHSMovieAdhoc >> initialize [
	values := Dictionary new
]

{ #category : #'as yet unclassified' }
VHSMovieAdhoc >> internationalReleaseDates [ ^ values at: #internationalReleaseDates
]

{ #category : #'as yet unclassified' }
VHSMovieAdhoc >> internationalReleaseDates:aValue [ ^ values at: #internationalReleaseDates put: aValue
]

{ #category : #'as yet unclassified' }
VHSMovieAdhoc >> internationalTitles [ ^ values at: #internationalTitles
]

{ #category : #'as yet unclassified' }
VHSMovieAdhoc >> internationalTitles:aValue [ ^ values at: #internationalTitles put: aValue
]

{ #category : #'as yet unclassified' }
VHSMovieAdhoc >> language [ ^ values at: #language
]

{ #category : #'as yet unclassified' }
VHSMovieAdhoc >> language:aValue [ ^ values at: #language put: aValue
]

{ #category : #'as yet unclassified' }
VHSMovieAdhoc >> plotKeywords [ ^ values at: #plotKeywords
]

{ #category : #'as yet unclassified' }
VHSMovieAdhoc >> plotKeywords:aValue [ ^ values at: #plotKeywords put: aValue
]

{ #category : #'as yet unclassified' }
VHSMovieAdhoc >> plotSummary [ ^ values at: #plotSummary
]

{ #category : #'as yet unclassified' }
VHSMovieAdhoc >> plotSummary:aValue [ ^ values at: #plotSummary put: aValue
]

{ #category : #'as yet unclassified' }
VHSMovieAdhoc >> producer [ ^ values at: #producer
]

{ #category : #'as yet unclassified' }
VHSMovieAdhoc >> producer:aValue [ ^ values at: #producer put: aValue
]

{ #category : #'as yet unclassified' }
VHSMovieAdhoc >> releaseDate [ ^ values at: #releaseDate
]

{ #category : #'as yet unclassified' }
VHSMovieAdhoc >> releaseDate:aValue [ ^ values at: #releaseDate put: aValue
]

{ #category : #'as yet unclassified' }
VHSMovieAdhoc >> runtime [ ^ values at: #runtime
]

{ #category : #'as yet unclassified' }
VHSMovieAdhoc >> runtime:aValue [ ^ values at: #runtime put: aValue
]

{ #category : #'as yet unclassified' }
VHSMovieAdhoc >> title [ ^ values at: #title
]

{ #category : #'as yet unclassified' }
VHSMovieAdhoc >> title:aValue [ ^ values at: #title put: aValue
]

{ #category : #'as yet unclassified' }
VHSMovieAdhoc >> worldwideIncomes [ ^ values at: #worldwideIncomes
]

{ #category : #'as yet unclassified' }
VHSMovieAdhoc >> worldwideIncomes:aValue [ ^ values at: #worldwideIncomes put: aValue
]
