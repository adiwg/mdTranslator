# ADIwg ISO Translator internal data structure

# History:
# 	Stan Smith 2013-08-09 original script
# 	Stan Smith 2013-08-10 adding methods as needed
# 	Stan Smith 2013-09-19 added keywords
# 	Stan Smith 2013-09-20 change '' to nil for value attributes
# 	Stan Smith 2013-09-23 added distributor
# 	Stan Smith 2013-09-24 added distributor order process
# 	Stan Smith 2013-09-24 added digital transfer options
# 	Stan Smith 2013-09-24 added data transfer medium
# 	Stan Smith 2013-10-17 added browse graphic
# 	Stan Smith 2013-10-21 added address (separated from contact)
# 	Stan Smith 2013-10-25 added extent
# 	Stan Smith 2013-10-25 added bounding box
# 	Stan Smith 2013-10-25 added point
# 	Stan Smith 2013-10-25 added multi point
# 	Stan Smith 2013-10-25 added line string
# 	Stan Smith 2013-10-25 added polygon
# 	Stan Smith 2013-10-25 added linear ring
# 	Stan Smith 2013-10-25 added temporal extent
# 	Stan Smith 2013-10-25 added time instant
# 	Stan Smith 2013-10-25 added time period
# 	Stan Smith 2013-10-25 added vertical extent
# 	Stan Smith 2013-10-30 added constraint
# 	Stan Smith 2013-10-31 added resource maintenance
# 	Stan Smith 2013-11-19 added usage
# 	Stan Smith 2013-11-19 added taxonomy
# 	Stan Smith 2013-11-20 added data quality
# 	Stan Smith 2013-11-20 modified citation
# 	Stan Smith 2013-12-16 added phone book

class InternalMetadata

	# initialize attribute values - nil
	# initialize arrays - []
	# initialize hashes - {}

	def initialize
	end

	def newBase
		intObj = {
			contacts: [],
			metadata: {}
		}
	end

	def newDateTime
		intObj = {
			dateTime: nil,
			dateType: nil,
			dateResolution: nil
		}
	end

	def newContact
		intObj =  {
			contactID: nil,
			indName: nil,
			orgName: nil,
			position: nil,
			voicePhones: [],
			faxPhones: [],
			smsPhones: [],
			address: {},
			onlineRes: [],
			contactInstructions: nil
		}
	end

	def newPhone
		intObj = {
			phoneName: nil,
			phoneNumber: nil
		}
	end

	def newAddress
		intObj = {
			deliveryPoints: [],
			city: nil,
			adminArea: nil,
			postalCode: nil,
			country: nil,
			eMailList: []
		}
	end

	def newMetadata
		intObj = {
			fileIdentifier: nil,
			parentIdentifier: nil,
			hierarchies: [],
			metadataCustodians: [],
			metadataDate: {},
			datasetURI: nil,
			referenceSystems: [],
			extensions: [],
			dataIdentification: {},
			distributorInfo: [],
			dataQualityInfo: [],
			maintInfo: {}
		}
	end

	def newContactById
		intObj = {
			contactID: nil,
			roleName: nil
		}
	end

	def newOnlineResource
		intObj = {
			olResLink: nil,
		    olResName: nil,
			olResDesc: nil,
			olResFunction: nil
		}
	end

	def newDataId
		intObj = {
			citation: {},
			abstract: nil,
			purpose: nil,
			credits: [],
			status: nil,
			pointsOfContact: [],
			resourceMaint: [],
			graphicOverview: [],
			resourceFormats: [],
			descriptiveKeywords: [],
			resourceUses: [],
			useLimitations: [],
			legalConstraints: [],
			securityConstraints: [],
			taxonomy: {},
			spatialRepTypes: [],
			spatialResolutions: [],
			contentLanguages: [],
			topicCategories: [],
			environDescription: nil,
			extents: [],
			supplementalInfo: nil
		}
	end

	def newCitation
		intObj = {
			citTitle: nil,
			citDate: [],
			citEdition: nil,
			citResParty: [],
			citForm: nil,
			citISBN: nil,
			citISSN: nil
		}
	end

	def newResourceFormat
		intObj = {
			formatName: nil,
			formatVersion: nil
		}
	end

	def newResourceMaint
		intObj = {
			maintFreq: nil,
			maintNotes: [],
			maintContacts: []
		}
	end

	def newKeyword
		intObj = {
			keyword: [],
			keywordType: nil,
			keyTheLink: nil,
			keyTheCitation: {}
		}
	end

	def newLegalCon
		intObj = {
			accessCons: [],
			useCons: [],
			otherCons: []
		}
	end

	def newSecurityCon
		intObj = {
			classification: nil,
			userNote: nil,
			classSystem: nil,
			handlingDesc: nil
		}
	end

	def newDistributor
		intObj = {
			distContact: {},
			distOrderProc: [],
			distFormat: [],
			distTransOption: []
		}
	end

	def newDistOrder
		intObj = {
			fees: nil,
			plannedDateTime: {},
			orderInstructions: nil,
			turnaround: nil
		}
	end

	def newDigitalTransOption
		intObj = {
			online: [],
			offline: {}
		}
	end

	def newMedium
		intObj = {
			mediumName: nil,
			mediumFormat: nil,
			mediumNote: nil
		}
	end

	def newBrowseGraphic
		intObj = {
			bGLink: nil,
			bGName: nil,
			bGDescription: nil,
			bGType: nil
		}
	end

	def newExtent
		intObj = {
			extDesc: nil,
			extGeoElements: [],
			extTempElements: [],
			extVertElements: []
		}
	end

	def newGeoElement
		intObj = {
			elementType: nil,
			elementExtent: nil,
			element: {}
		}
	end

	def newBoundingBox
		intObj = {
			westLong: nil,
			eastLong: nil,
			southLat: nil,
			northLat: nil
		}
	end

	def newMultiGeo
		intObj = {
			mGeoID: nil,
			mGeoDescription: nil,
			mGeoName: nil,
			mGeos: []
		}
	end

	def newPoint
		intObj = {
			pointID: nil,
			srsName: nil,
			srsDim: nil,
			temporalElements: [],
			pointDescription: nil,
			identifier: nil,
			identCodeSpace: nil,
			pointName: nil,
			pointRing: {}
		}
	end

	def newLineString
		intObj = {
			lineID: nil,
			srsName: nil,
			srsDim: nil,
			temporalElements: [],
			lineDescription: nil,
			lineName: nil,
			lineRing: {}
		}
	end

	def newPolygon
		intObj = {
			polygonID: nil,
			srsName: nil,
			srsDim: nil,
			polygonDescription: nil,
			polygonName: nil,
			exteriorRing: {},
			interiorRings: []
		}
	end

	def newTemporalElement
		intObj = {
			date: {},
			timeInstant: {},
			timePeriod: {}
		}
	end

	def newTimeInstant
		intObj = {
			timeID: nil,
			description: nil,
		    timePosition: {}
		}
	end

	def newTimePeriod
		intObj = {
			timeID: nil,
			description: nil,
			beginTime: {},
			endTime: {}
		}
	end

	def newVerticalElement
		intObj = {
			minValue: nil,
			maxValue: nil,
			crsLink: nil,
			crsTitle: nil
		}
	end

	def newLegalConstraint
		intObj = {
			accessCodes: [],
			useCodes: [],
			otherCons: []
		}
	end

	def newSecurityConstraint
		intObj = {
			classCode: nil,
			userNote: nil,
			classSystem: nil,
			handlingDesc: nil
		}
	end

	def newDataUsage
		intObj = {
			specificUsage: nil,
			userLimits: nil,
			userContacts: []
		}
	end

	def newTaxonSystem
		intObj = {
			taxClassSys: [],
			taxGeneralScope: nil,
			taxObservers: [],
			taxIdProcedures: nil,
			taxVoucher: {},
			taxClasses: []
		}
	end

	def newTaxonVoucher
		intObj = {
			specimen: nil,
			repository: {}
		}
	end

	def newTaxonClass
		intObj = {
			commonName: nil,
			taxRankName: nil,
			taxRankValue: nil
		}
	end

	def newResolution
		intObj = {
			equivalentScale: nil,
			distance: nil,
			distanceUOM: nil
		}
	end

	def newDataQuality
		intObj = {
			dataScope: nil,
			dataLineage: {}
		}
	end

	def newLineage
		intObj = {
			statement: nil,
			processSteps: [],
			dataSources: []
		}
	end

	def newDataProcessStep
		intObj = {
			stepID: nil,
			stepDescription: nil,
			stepRationale: nil,
			stepDateTime: {},
			stepProcessors: []
		}
	end

	def newDataSource
		intObj = {
			sourceDescription: nil,
			sourceCitation: {},
			sourceSteps: []
		}
	end

	def newMetadataExtension
		intObj = {
			onLineResource: {},
			extName: nil,
			extShortName: nil,
			extDefinition: nil,
			obligation: nil,
			dataType: nil,
			maxOccurrence: nil,
			parentEntities: [],
			rule: nil,
			rationales: [],
			extSources: []
		}
	end

end