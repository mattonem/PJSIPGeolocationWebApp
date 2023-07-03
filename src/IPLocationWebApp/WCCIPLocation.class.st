Class {
	#name : #WCCIPLocation,
	#superclass : #WCComponent,
	#pools : [
		'PjDomGlobals'
	],
	#category : #IPLocationWebApp
}

{ #category : #rendering }
WCCIPLocation >> renderHtmlOn: html [

	html unorderedList
		class: 'list-group list-group-flush';
		with: [ 
			html listItem
				class: 'list-group-item';
				with: [ 
					html span with: 'Country: '.
					html span
						id: #country;
						with: '...' ].
			html listItem
				class: 'list-group-item';
				with: [ 
					html span with: 'City: '.
					html span
						id: #city;
						with: '...' ].
			html listItem
				class: 'list-group-item';
				with: [ 
					html span with: 'Timezone: '.
					html span
						id: #timezone;
						with: '...' ] ]
]

{ #category : #rendering }
WCCIPLocation >> start [

	| client req |
	client := PjHttpClient new.
	client onLoad: [ :aClient | 
		| response |
		response := PhxJsonReader materializeJsonString:
			            aClient currentTarget responseText.
		(self getElementById: #country) innerHTML: response country.
		(self getElementById: #city) innerHTML: response city.
		(self getElementById: #timezone) innerHTML: response timezone ].
	req := client method: 'GET' url: 'https://ipinfo.io?token=4ab8b8f87a94b1'.
	req send: ''
]
