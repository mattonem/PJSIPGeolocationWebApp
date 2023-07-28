Class {
	#name : #BaselineOfIPLocationWebApp,
	#superclass : #BaselineOf,
	#category : #BaselineOfIPLocationWebApp
}

{ #category : #baselines }
BaselineOfIPLocationWebApp >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'Camping'
			with: [ spec repository: 'github://mattonem/WildCamping' ].
		spec baseline: 'PjHttpClient' 
			with: [ spec repository: 'github://mattonem/RestClientApp:master' ].

		spec package: #IPLocationWebApp ]
]
