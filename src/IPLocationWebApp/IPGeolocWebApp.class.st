Class {
	#name : #IPGeolocWebApp,
	#superclass : #PjFileBasedWebApp,
	#traits : 'StaticComponentHolder',
	#classTraits : 'StaticComponentHolder classTrait',
	#category : #IPLocationWebApp
}

{ #category : #adding }
IPGeolocWebApp class >> addComponent: aWCCIPLocation named: aString [ 
	<pharoJsSkip>
	self addStaticComponent: aWCCIPLocation named: aString
]

{ #category : #accessing }
IPGeolocWebApp class >> appClasses [

	<pharoJsSkip>
	^ super appClasses , { WCCIPLocation }
]

{ #category : #accessing }
IPGeolocWebApp class >> bridgeClientClass [
	<pharoJsSkip>
	
	^ PjZnHostedBrowserBridgeClient
]

{ #category : #accessing }
IPGeolocWebApp class >> exporterClass [
	<pharoJsSkip>
	
	^ PjFileExporterWithIndexHtml
]

{ #category : #accessing }
IPGeolocWebApp class >> generateHtmlUsing: html [

	<pharoJsSkip>
	WCCIPLocation for: self on: html named: #ipGeoloc
]

{ #category : #accessing }
IPGeolocWebApp class >> updateHtmlRoot: root [

	<pharoJsSkip>
	root stylesheet url:
		'https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css'.
	root stylesheet url:
		'https://unpkg.com/leaflet@1.9.4/dist/leaflet.css'.
	root javascript url:
		'https://unpkg.com/leaflet@1.9.4/dist/leaflet.js'
]

{ #category : #'initialize-release' }
IPGeolocWebApp >> initialize [

	super initialize.
	self initializeComponentHolder  
]
