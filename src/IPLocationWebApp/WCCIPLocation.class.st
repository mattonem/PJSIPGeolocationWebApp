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

	html div
		class: 'container';
		with: [ :cont | 
			cont div
				class: 'card';
				id: 'cardRoot';
				with: [ :card | 
					card div
						class: 'card-header';
						with: 'Where is my IP'.

					html unorderedList
						class: 'list-group list-group-flush';
						with: [ 
							html listItem
								class: 'list-group-item';
								with: [ 
									html span with: 'IP: '.
									html span
										id: #ip;
										with: '...' ].
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
										with: '...' ] ].
					html div
						class: 'card-body';
						with: [ html preformatted id: 'errorMessage' ] ] ]
]

{ #category : #rendering }
WCCIPLocation >> start [

	| client req |
	client := PjHttpClient new.
	client onLoad: [ :aClient | 
		| response |
		response := PhxJsonReader materializeJsonString:
			            aClient currentTarget responseText.
		aClient currentTarget status = 200
			ifTrue: [ 
				(self getElementById: #ip) innerHTML: response ip.
				(self getElementById: #country) innerHTML: response country.
				(self getElementById: #city) innerHTML: response city.
				(self getElementById: #timezone) innerHTML: response timezone ]
			ifFalse: [ 
				(self getElementById: #cardRoot) classList add: 'text-bg-danger'.
				(self getElementById: #errorMessage) innerHTML:
					(JSON stringify: response with: nil and: 4) ] ].
	req := client
		       method: 'GET'
		       url: 'https://ipinfo.io?token=4ab8b8f87a94b1'.
	req send: ''
]
