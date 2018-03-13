# ADIwg ISO Translator internal data structure

# History:
# version 2
#  Stan Smith 2017-09-28 add altitude to bounding box for fgdc
#  Stan Smith 2017-09-28 add description to geographicExtent for fgdc
#  Stan Smith 2017-04-22 removed 'intObj = ' from new object definitions
#  Stan Smith 2017-02-15 added newResourceType
#  Stan Smith 2017-02-09 added newMetadataRepository
#  Stan Smith 2017-01-20 refactored newDataDictionary
#  Stan Smith 2016-11-10 added computedBbox to newGeographicExtent, newGeometryCollection
#  Stan Smith 2016-11-10 added computedBbox to newGeometryFeature, newFeatureCollection
#  Stan Smith 2016-11-02 added newSchema
#  Stan Smith 2016-10-30 added newAllocation, newFunding
#  Stan Smith 2016-10-25 added newFeatureCollection
#  Stan Smith 2016-10-25 added newGeoJson
#  Stan Smith 2016-10-25 added newGeometryCollection
#  Stan Smith 2016-10-25 added newGeometryFeature
#  Stan Smith 2016-10-25 added newGeometryObject
#  Stan Smith 2016-10-25 added newGeometryProperties
#  Stan Smith 2016-10-23 renamed newResourceMaint to newMaintenance
#  Stan Smith 2016-10-21 added newDistribution
#  Stan Smith 2016-10-21 renamed newDistOrder to newOrderProcess
#  Stan Smith 2016-10-21 renamed newDigitalTransOption to newTransferOption
#  Stan Smith 2016-10-20 deleted newDictionaryInfo, move element to newDataDictionary
#  Stan Smith 2016-10-19 added newSpatialRepresentation
#  Stan Smith 2016-10-19 added newGeorectifiedInfo
#  Stan Smith 2016-10-19 added newVectorInfo, newVectorObject
#  Stan Smith 2016-10-18 deleted newCoverageInfo, newCoverageItem
#  Stan Smith 2016-10-18 added newAttributeGroup
#  Stan Smith 2016-10-18 deleted newClassedData, newClassedDataItem
#  Stan Smith 2016-10-17 added elements to newLineage
#  Stan Smith 2016-10-17 added elements to newDataSource
#  Stan Smith 2016-10-16 removed newResolution
#  Stan Smith 2016-10-16 added newMeasure
#  Stan Smith 2016-10-16 added newSpatialResolution
#  Stan Smith 2016-10-15 renamed newDataProcess Step to newProcessStep
#  Stan Smith 2016-10-15 added newConstraints object
#  Stan Smith 2016-10-15 added constraint object to newSecurityConstraint
#  Stan Smith 2016-10-15 added constraint object to newLegalConstraint
#  Stan Smith 2016-10-15 added newConstraint object
#  Stan Smith 2016-10-15 added newRelease object
#  Stan Smith 2016-10-14 added newScope object
#  Stan Smith 2016-10-14 added newTimeInterval object
#  Stan Smith 2016-10-13 added newScopeDescription object
#  Stan Smith 2016-10-13 added attributes to newCitation for mdJson 2.0
#  Stan Smith 2016-10-13 renamed newResourceId to newIdentifier, dropped identifierType
#  Stan Smith 2016-10-12 renamed newBrowseGraphic to newGraphic, added graphicConstraint []
#  Stan Smith 2016-10-12 added newSeries object
#  Stan Smith 2016-10-12 added newDate object
#  Stan Smith 2016-10-11 renamed newDataUsage to newResourceUsage
#  Stan Smith 2016-10-09 add newParty
#  Stan Smith 2016-10-08 removed dateType from dateTime object
#  Stan Smith 2016-10-01 made phone service types an array
#  Stan Smith 2016-10-03 added duration object

# version 1
#  Stan Smith 2015-07-23 added gridInfo, gridDimension for 1.3.0
#  Stan Smith 2015-07-28 added locale for 1.3.0
#  Stan Smith 2015-08-19 added coverageInfo, imageInfo, sensorInfo, coverageItem,
#             ... classifiedData, and classedDataItem for 1.3.0
#  Stan Smith 2015-09-18 extended distributionInfo sections for 1.3.0

# version 0
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
#  Stan Smith 2014-04-23 added protocol and doi to online resource
#  Stan Smith 2014-04-24 added schema to newBase
#  Stan Smith 2014-04-24 renamed newDataId to newResourceInfo
#  Stan Smith 2014-04-24 reorganized newMetadata, newResourceInfo
#  Stan Smith 2014-04-24 added newMetadataInfo
#  Stan Smith 2014-04-25 modified newCitation for json schema 0.3.0
#  Stan Smith 2014-04-25 added resource Ids to newCitation
#  Stan Smith 2014-04-30 reorganized geometry blocks for json schema 0.3.0
#  Stan Smith 2014-05-02 added associatedResource
#  Stan Smith 2014-05-02 added additionalDocument
#  Stan Smith 2014-05-28 modified resourceId & responsibleParty for schema 0.5.0
#  Stan Smith 2014-08-15 modified citation, onlineResource, resourceId for 0.6.0
#  Stan Smith 2014-09-03 added spatialReferenceSystems for name, EPSG, and WKT for 0.6.0
#  Stan Smith 2014-11-06 added resourceType to resourceInfo for 0.9.0
#  Stan Smith 2014-11-06 removed metadataScope from metadataInfo for 0.9.0
#  Stan Smith 2014-11-06 added newAdditionalDocumentation
#  Stan Smith 2014-12-01 added data dictionary
#  Stan Smith 2015-02-17 add entity and attribute alias
#  Stan Smith 2015-02-17 added support for multiple data dictionaries

class InternalMetadata

   # initialize Boolean - false
   # initialize scalar - nil
   # initialize hash - {}
   # initialize array - []

   def initialize
   end


   # base -----------------------------------
   def newBase
      {
         schema: {},
         contacts: [],
         metadata: {},
         dataDictionaries: [],
         metadataRepositories: []
      }
   end

   def newMetadata
      {
         metadataInfo: {},
         resourceInfo: {},
         lineageInfo: [],
         distributorInfo: [],
         associatedResources: [],
         additionalDocuments: [],
         funding: []
      }
   end

   def newSchema
      {
         name: nil,
         version: nil
      }
   end


   # contacts--------------------------------
   def newAddress
      {
         addressTypes: [],
         description: nil,
         deliveryPoints: [],
         city: nil,
         adminArea: nil,
         postalCode: nil,
         country: nil
      }
   end

   def newContact
      {
         contactId: nil,
         isOrganization: false,
         name: nil,
         positionName: nil,
         memberOfOrgs: [],
         logos: [],
         phones: [],
         addresses: [],
         eMailList: [],
         onlineResources: [],
         hoursOfService: [],
         contactInstructions: nil,
         contactType: nil
      }
   end

   def newPhone
      {
         phoneName: nil,
         phoneNumber: nil,
         phoneServiceTypes: []
      }
   end


   # common ---------------------------------
   def newCitation
      {
         title: nil,
         alternateTitles: [],
         dates: [],
         edition: nil,
         responsibleParties: [],
         presentationForms: [],
         identifiers: [],
         series: {},
         otherDetails: [],
         onlineResources: [],
         browseGraphics: []
      }
   end

   def newGraphic
      {
         graphicName: nil,
         graphicDescription: nil,
         graphicType: nil,
         graphicConstraints: [],
         graphicURI: []
      }
   end

   def newIdentifier
      # handles MD_Identifier (ISO 19115-2 & -1)
      # handles RS_ Identifier (ISO 19115-2)
      # handles gmlIdentifier
      {
         identifier: nil,
         namespace: nil,
         version: nil,
         description: nil,
         citation: {}
      }
   end

   def newLocale
      {
         languageCode: nil,
         countryCode: nil,
         characterEncoding: nil
      }
   end

   def newMaintenance
      {
         frequency: nil,
         dates: [],
         scopes: [],
         notes: [],
         contacts: []
      }
   end

   def newOnlineResource
      {
         olResURI: nil,
         olResProtocol: nil,
         olResName: nil,
         olResDesc: nil,
         olResFunction: nil
      }
   end

   def newResourceType
      {
         type: nil,
         name: nil
      }
   end

   def newSeries
      {
         seriesName: nil,
         seriesIssue: nil,
         issuePage: nil
      }
   end


   # constraint -----------------------------
   def newConstraint
      {
         type: nil,
         useLimitation: [],
         scope: {},
         graphic: [],
         reference: [],
         releasability: {},
         responsibleParty: [],
         legalConstraint: {},
         securityConstraint: {}
      }
   end

   def newLegalConstraint
      {
         accessCodes: [],
         useCodes: [],
         otherCons: []
      }
   end

   def newSecurityConstraint
      {
         classCode: nil,
         userNote: nil,
         classSystem: nil,
         handling: nil
      }
   end

   def newRelease
      {
         addressee: [],
         statement: nil,
         disseminationConstraint: []
      }
   end

   def newResourceUsage
      {
         specificUsage: nil,
         temporalExtents: [],
         userLimitation: nil,
         limitationResponses: [],
         identifiedIssue: {},
         additionalDocumentation: [],
         userContacts: []
      }
   end


   # coverage description -------------------
   def newCoverageDescription
      {
         coverageName: nil,
         coverageDescription: nil,
         processingLevelCode: {},
         attributeGroups: [],
         imageDescription: {}
      }
   end

   def newAttributeGroup
      {
         attributeContentTypes: [],
         attributes: []
      }
   end

   def newAttribute
      {
         sequenceIdentifier: nil,
         sequenceIdentifierType: nil,
         attributeDescription: nil,
         attributeIdentifiers: [],
         minValue: nil,
         maxValue: nil,
         units: nil,
         scaleFactor: nil,
         offset: nil,
         meanValue: nil,
         numberOfValues: nil,
         standardDeviation: nil,
         bitsPerValue: nil,
         boundMin: nil,
         boundMax: nil,
         boundUnits: nil,
         peakResponse: nil,
         toneGradations: nil,
         bandBoundaryDefinition: nil,
         nominalSpatialResolution: nil,
         transferFunctionType: nil,
         transmittedPolarization: nil,
         detectedPolarization: nil
      }
   end

   def newImageDescription
      {
         illuminationElevationAngle: nil,
         illuminationAzimuthAngle: nil,
         imagingCondition: nil,
         imageQualityCode: {},
         cloudCoverPercent: nil,
         compressionQuantity: nil,
         triangulationIndicator: false,
         radiometricCalibrationAvailable: false,
         cameraCalibrationAvailable: false,
         filmDistortionAvailable: false,
         lensDistortionAvailable: false
      }
   end


   # data dictionary ------------------------
   def newDataDictionary
      {
         description: nil,
         subjects: [],
         citation: {},
         recommendedUses: [],
         locales: [],
         responsibleParty: {},
         dictionaryFunctionalLanguage: nil,
         includedWithDataset: false,
         domains: [],
         entities: []
      }
   end

   def newDictionaryDomain
      {
         domainId: nil,
         domainName: nil,
         domainCode: nil,
         domainDescription: nil,
         domainReference: {},
         domainItems: []
      }
   end

   def newDomainItem
      {
         itemName: nil,
         itemValue: nil,
         itemDefinition: nil,
         itemReference: {}
      }
   end

   def newEntity
      {
         entityId: nil,
         entityName: nil,
         entityCode: nil,
         entityAlias: [],
         entityDefinition: nil,
         entityReferences: [],
         primaryKey: [],
         indexes: [],
         attributes: [],
         foreignKeys: [],
         fieldSeparatorCharacter: nil,
         numberOfHeaderLines: nil,
         quoteCharacter: nil
      }
   end

   def newEntityIndex
      {
         indexCode: nil,
         duplicate: false,
         attributeNames: []
      }
   end

   def newEntityAttribute
      {
         attributeName: nil,
         attributeCode: nil,
         attributeAlias: [],
         attributeDefinition: nil,
         attributeReference: {},
         dataType: nil,
         allowNull: false,
         mustBeUnique: false,
         unitOfMeasure: nil,
         measureResolution: nil,
         isCaseSensitive: false,
         fieldWidth: nil,
         missingValue: nil,
         domainId: nil,
         minValue: nil,
         maxValue: nil,
         valueRange: [],
         timePeriod: []
      }
   end

   def newEntityForeignKey
      {
         fkLocalAttributes: [],
         fkReferencedEntity: nil,
         fkReferencedAttributes: []
      }
   end

   def newValueRange
      {
         minRangeValue: nil,
         maxRangeValue: nil
      }
   end


   # date-time ------------------------------
   def newDate
      {
         date: nil,
         dateResolution: nil,
         dateType: nil,
         description: nil
      }
   end

   def newDateTime
      {
         dateTime: nil,
         dateResolution: nil
      }
   end


   # distribution ---------------------------
   def newDistribution
      {
         description: nil,
         liabilityStatement: nil,
         distributor: []
      }
   end

   def newDistributor
      {
         contact: {},
         orderProcess: [],
         transferOptions: []
      }
   end

   def newOrderProcess
      {
         fees: nil,
         plannedAvailability: {},
         orderingInstructions: nil,
         turnaround: nil
      }
   end

   def newTransferOption
      {
         unitsOfDistribution: nil,
         transferSize: nil,
         onlineOptions: [],
         offlineOptions: [],
         transferFrequency: {},
         distributionFormats: []
      }
   end

   def newMedium
      {
         mediumSpecification: {},
         density: nil,
         units: nil,
         numberOfVolumes: nil,
         mediumFormat: [],
         note: nil,
         identifier: {}
      }
   end

   def newResourceFormat
      {
         formatSpecification: {},
         amendmentNumber: nil,
         compressionMethod: nil,
         technicalPrerequisite: nil
      }
   end


   # funding --------------------------------
   def newAllocation
      {
         id: nil,
         amount: nil,
         currency: nil,
         sourceId: nil,
         recipientId: nil,
         matching: false,
         onlineResources: [],
         comment: nil
      }
   end

   def newFunding
      {
         description: nil,
         timePeriod: {},
         allocations: []
      }
   end


   # graphic extent --------------------------
   def newExtent
      {
         description: nil,
         geographicExtents: [],
         temporalExtents: [],
         verticalExtents: []
      }
   end

   def newGeographicExtent
      {
         description: nil,
         containsData: true,
         identifier: {},
         boundingBox: {},
         geographicElements: [],
         nativeGeoJson: [],
         computedBbox: {}
      }
   end

   def newBoundingBox
      {
         westLongitude: nil,
         eastLongitude: nil,
         southLatitude: nil,
         northLatitude: nil,
         minimumAltitude: nil,
         maximumAltitude: nil,
         unitsOfAltitude: nil
      }
   end

   def newGeometryObject
      {
         type: nil,
         coordinates: [],
         nativeGeoJson: {}
      }
   end

   def newGeometryCollection
      {
         type: nil,
         bbox: [],
         geometryObjects: [],
         computedBbox: [],
         nativeGeoJson: {}
      }
   end

   def newGeometryProperties
      {
         featureNames: [],
         description: nil,
         identifiers: [],
         featureScope: nil,
         acquisitionMethod: nil
      }
   end

   def newGeometryFeature
      {
         type: nil,
         id: nil,
         bbox: [],
         geometryObject: {},
         properties: {},
         computedBbox: [],
         nativeGeoJson: {}
      }
   end

   def newFeatureCollection
      {
         type: nil,
         bbox: [],
         features: [],
         computedBbox: [],
         nativeGeoJson: {}
      }
   end


   # keyword --------------------------------
   def newKeyword
      {
         keywords: [],
         keywordType: nil,
         thesaurus: {}
      }
   end

   def newKeywordObject
      {
         keyword: nil,
         keywordId: nil
      }
   end


   # lineage --------------------------------
   def newLineage
      {
         statement: nil,
         resourceScope: {},
         lineageCitation: [],
         dataSources: [],
         processSteps: []
      }
   end

   def newProcessStep
      {
         stepId: nil,
         description: nil,
         rationale: nil,
         timePeriod: {},
         processors: [],
         references: [],
         stepSources: [],
         stepProducts: [],
         scope: {}
      }
   end

   def newDataSource
      {
         sourceId: nil,
         description: nil,
         sourceCitation: {},
         metadataCitation: [],
         spatialResolution: {},
         referenceSystem: {},
         sourceSteps: [],
         scope: {}
      }
   end


   # metadata info --------------------------
   def newMetadataInfo
      {
         metadataIdentifier: {},
         parentMetadata: {},
         defaultMetadataLocale: {},
         otherMetadataLocales: [],
         metadataContacts: [],
         metadataDates: [],
         metadataLinkages: [],
         metadataConstraints: [],
         metadataMaintenance: {},
         alternateMetadataReferences: [],
         metadataStatus: nil,
         extensions: []
      }
   end


   # resource info --------------------------
   def newResourceInfo
      {
         resourceTypes: [],
         citation: {},
         abstract: nil,
         shortAbstract: nil,
         purpose: nil,
         credits: [],
         timePeriod: {},
         status: [],
         pointOfContacts: [],
         spatialReferenceSystems: [],
         spatialRepresentationTypes: [],
         spatialRepresentations: [],
         spatialResolutions: [],
         temporalResolutions: [],
         extents: [],
         coverageDescriptions: [],
         taxonomy: {},
         graphicOverviews: [],
         resourceFormats: [],
         keywords: [],
         resourceUsages: [],
         constraints: [],
         defaultResourceLocale: {},
         otherResourceLocales: [],
         resourceMaintenance: [],
         environmentDescription: nil,
         supplementalInfo: nil
      }
   end


   # responsibility -------------------------
   def newResponsibility
      {
         roleName: nil,
         roleExtents: [],
         parties: []
      }
   end

   def newParty
      {
         contactId: nil,
         contactIndex: nil,
         contactType: nil,
         organizationMembers: []
      }
   end


   # scope ----------------------------------
   def newScope
      {
         scopeCode: nil,
         scopeDescriptions: [],
         extents: []
      }
   end

   def newScopeDescription
      {
         dataset: nil,
         attributes: nil,
         features: nil,
         other: nil
      }
   end


   # spatial reference ----------------------
   def newSpatialReferenceSystem
      {
         systemType: nil,
         systemIdentifier: {},
         systemWKT: nil,
         systemParameterSet: {}
      }
   end

   def newReferenceSystemParameterSet
      {
         projection: {},
         geodetic: {},
         verticalDatum: {}
      }
   end

   def newProjection
      {
         projectionIdentifier: {},
         gridSystem: nil,
         gridSystemName: nil,
         gridZone: nil,
         projection: nil,
         projectionName: nil,
         standardParallel1: nil,
         standardParallel2: nil,
         longitudeOfCentralMeridian: nil,
         latitudeOfProjectionOrigin: nil,
         falseEasting: nil,
         falseNorthing: nil,
         falseEastingNorthingUnits: nil,
         scaleFactorAtEquator: nil,
         heightOfProspectivePointAboveSurface: nil,
         longitudeOfProjectionCenter: nil,
         latitudeOfProjectionCenter: nil,
         scaleFactorAtCenterLine: nil,
         scaleFactorAtCentralMeridian: nil,
         straightVerticalLongitudeFromPole: nil,
         scaleFactorAtProjectionOrigin: nil,
         azimuthAngle: nil,
         azimuthMeasurePointLongitude: nil,
         obliqueLinePoints: [],
         landsatNumber: nil,
         landsatPath: nil,
         localPlanarDescription: nil,
         localPlanarGeoreference: nil,
         otherGridDescription: nil,
         otherProjectionDescription: nil
      }
   end

   def newObliqueLinePoint
      {
         azimuthLineLatitude: nil,
         azimuthLineLongitude: nil
      }
   end

   def newGeodetic
      {
         datumIdentifier: {},
         datumName: nil,
         ellipsoidIdentifier: {},
         ellipsoidName: nil,
         semiMajorAxis: nil,
         axisUnits: nil,
         denominatorOfFlatteningRatio: nil
      }
   end

   def newVerticalDatum
      {
         datumIdentifier: {},
         datumName: nil,
         isDepthSystem: false,
         encodingMethod: nil,
         verticalResolution: nil,
         unitOfMeasure: nil
      }

   end


   # spatial representation -----------------
   def newSpatialRepresentation
      {
         gridRepresentation: {},
         vectorRepresentation: {},
         georectifiedRepresentation: {},
         georeferenceableRepresentation: {}
      }
   end

   def newGridInfo
      {
         numberOfDimensions: nil,
         dimension: [],
         cellGeometry: nil,
         transformationParameterAvailable: false
      }
   end

   def newDimension
      {
         dimensionType: nil,
         dimensionTitle: nil,
         dimensionDescription: nil,
         dimensionSize: nil,
         resolution: {}
      }
   end

   def newVectorInfo
      {
         topologyLevel: nil,
         vectorObject: []
      }
   end

   def newVectorObject
      {
         objectType: nil,
         objectCount: nil
      }
   end

   def newGeorectifiedInfo
      {
         gridRepresentation: {},
         checkPointAvailable: false,
         checkPointDescription: nil,
         cornerPoints: [],
         centerPoint: [],
         pointInPixel: nil,
         transformationDimensionDescription: nil,
         transformationDimensionMapping: nil
      }
   end

   def newGeoreferenceableInfo
      {
         gridRepresentation: {},
         controlPointAvailable: false,
         orientationParameterAvailable: false,
         orientationParameterDescription: nil,
         georeferencedParameter: nil,
         parameterCitation: []
      }
   end


   # spatial resolution ----------------------
   def newSpatialResolution
      {
         scaleFactor: nil,
         measure: {},
         coordinateResolution: {},
         bearingDistanceResolution: {},
         geographicResolution: {},
         levelOfDetail: nil
      }
   end

   def newMeasure
      {
         type: nil,
         value: nil,
         unitOfMeasure: nil
      }
   end

   def newCoordinateResolution
      {
         abscissaResolutionX: nil,
         ordinateResolutionY: nil,
         unitOfMeasure: nil
      }
   end

   def newBearingDistanceResolution
      {
         distanceResolution: nil,
         distanceUnitOfMeasure: nil,
         bearingResolution: nil,
         bearingUnitOfMeasure: nil,
         bearingReferenceDirection: nil,
         bearingReferenceMeridian: nil
      }
   end

   def newGeographicResolution
      {
         latitudeResolution: nil,
         longitudeResolution: nil,
         unitOfMeasure: nil
      }
   end


   # taxonomy -------------------------------
   def newTaxonomy
      {
         taxonSystem: [],
         generalScope: nil,
         idReferences: [],
         observers: [],
         idProcedure: nil,
         idCompleteness: nil,
         vouchers: [],
         taxonClass: {}
      }
   end

   def newTaxonSystem
      {
         citation: {},
         modifications: nil
      }
   end

   def newTaxonVoucher
      {
         specimen: nil,
         repository: {}
      }
   end

   def newTaxonClass
      {
         taxonId: nil,
         taxonRank: nil,
         taxonValue: nil,
         commonNames: [],
         subClasses: []
      }
   end


   # temporal extent ------------------------
   def newTemporalExtent
      {
         timeInstant: {},
         timePeriod: {}
      }
   end

   def newTimeInstant
      {
         timeId: nil,
         description: nil,
         identifier: {},
         instantNames: [],
         timeInstant: {},
         geologicAge: {}
      }
   end

   def newTimePeriod
      {
         timeId: nil,
         description: nil,
         identifier: {},
         periodNames: [],
         startDateTime: {},
         endDateTime: {},
         startGeologicAge: {},
         endGeologicAge: {},
         timeInterval: {},
         duration: {}
      }
   end

   def newGeologicAge
      {
         ageTimeScale: nil,
         ageEstimate: nil,
         ageUncertainty: nil,
         ageExplanation: nil,
         ageReferences: []
      }
   end

   def newDuration
      {
         years: nil,
         months: nil,
         days: nil,
         hours: nil,
         minutes: nil,
         seconds: nil
      }
   end

   def newTimeInterval
      {
         interval: nil,
         units: nil
      }
   end


   # vertical extent ------------------------
   def newVerticalExtent
      {
         description: nil,
         minValue: nil,
         maxValue: nil,
         crsId: {}
      }
   end


   # miscellaneous---------------------------
   def newAssociatedResource
      {
         resourceTypes: [],
         associationType: nil,
         initiativeType: nil,
         resourceCitation: {},
         metadataCitation: {}
      }
   end

   def newAdditionalDocumentation
      {
         resourceTypes: [],
         citation: []
      }
   end

   def newMetadataExtension
      {
         onLineResource: {},
         name: nil,
         shortName: nil,
         definition: nil,
         obligation: nil,
         dataType: nil,
         maxOccurrence: nil,
         parentEntities: [],
         rule: nil,
         rationales: [],
         sourceOrganization: nil,
         sourceURI: nil,
         sourceRole: nil
      }
   end

   def newMetadataRepository
      {
         repository: nil,
         citation: {},
         metadataStandard: nil
      }
   end

   # ----------------------------------------
   # ----------------------------------------

end
