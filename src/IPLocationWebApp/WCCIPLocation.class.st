Class {
	#name : #WCCIPLocation,
	#superclass : #WCComponent,
	#traits : 'InstanceComponentHolder',
	#classTraits : 'InstanceComponentHolder classTrait',
	#instVars : [
		'client'
	],
	#pools : [
		'PjDomGlobals'
	],
	#category : #IPLocationWebApp
}

{ #category : #rendering }
WCCIPLocation >> _getLocationHash [
	<javascript:'return window.location.hash'>
]

{ #category : #rendering }
WCCIPLocation >> getLocationHash [
	^ (self _getLocationHash splitOn: '/') allButFirst
]

{ #category : #rendering }
WCCIPLocation >> lookupIp: inputIP do: aBlock [
client
		       getUrl:
		       'https://ipinfo.io/' , inputIP , '?token=4ab8b8f87a94b1'
		       do: aBlock
]

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
					html div
						class: 'card-body';
						with: [ 
							html div
								class: 'mb-3';
								with: [ 
									html div
										class: ' form-floating';
										with: [ 
											html textInput
												class: 'form-control';
												placeholder: '8.8.8.8';
												id: 'inputIP'.
											html label
												for: 'inputIP';
												with: 'Lookup IP' ] ].
							html div
								class: 'mb-3';
								with: [ 
									html button
										class: 'btn btn-primary';
										id: 'sumitButton';
										with: 'Go!' ] ].
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
										with: '...' ] ].
					WCCMap for: self on: html named: #map.
					html div
						class: 'card-body';
						with: [ html preformatted id: 'errorMessage' ] ] ]
]

{ #category : #rendering }
WCCIPLocation >> start [

	client := PjHttpClient new.
	self initializeComponentHolder.


	(self getElementById: #sumitButton)
		addEventListener: #click
		block: [
			self
				lookupIp: (self getElementById: #inputIP) value
				do: [ :responseText :status |
					self updateIpLoc: responseText status: status ] ].
	(self getElementById: #inputIP) value:
		(self getLocationHash at: 1 ifAbsent: [ '' ]).
	self
		lookupIp: (self getElementById: #inputIP) value
		do: [ :responseText :status |
			self updateIpLoc: responseText status: status ]
]

{ #category : #rendering }
WCCIPLocation >> updateIpLoc: responseText status: status [

| response |
					response := PhxJsonReader materializeJsonString: responseText.
					status = 200
						ifTrue: [
							| posArray pos |
							(self getElementById: #inputIP) value: response ip.
							(self getElementById: #cardRoot) classList remove:
								'text-bg-danger'.
							(self getElementById: #errorMessage) innerHTML: ''.
							(self getElementById: #country) innerHTML: response country.
							(self getElementById: #city) innerHTML: response city.
							(self getElementById: #timezone) innerHTML: response timezone.
							posArray := response loc splitOn: ','.
							pos := (posArray at: 1) asNumber @ (posArray at: 2) asNumber.
							(self componentNamed: #map) setView: pos.
							(self componentNamed: #map) addMarker: pos ]
						ifFalse: [
							(self getElementById: #cardRoot) classList add:
								'text-bg-danger'.
							(self getElementById: #country) innerHTML: '...'.
							(self getElementById: #city) innerHTML: '...'.
							(self getElementById: #timezone) innerHTML: '...'.
							(self getElementById: #errorMessage) innerHTML:
								(JSON stringify: response with: nil and: 4) ]
]
