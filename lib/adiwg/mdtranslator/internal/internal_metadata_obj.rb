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
#   Stan Smith 2014-04-23 added protocol and doi to online resource
#   Stan Smith 2014-04-24 added schema to newBase
#   Stan Smith 2014-04-24 renamed newDataId to newResourceInfo
#   Stan Smith 2014-04-24 reorganized newMetadata, newResourceInfo
#   Stan Smith 2014-04-24 added newMetadataInfo
#   Stan Smith 2014-04-25 modified newCitation for json schema 0.3.0
#   Stan Smith 2014-04-25 added resource Ids to newCitation
#   Stan Smith 2014-04-30 reorganized geometry blocks for json schema 0.3.0
#   Stan Smith 2014-05-02 added associatedResource
#   Stan Smith 2014-05-02 added additionalDocument
#   Stan Smith 2014-05-28 modified resourceId & responsibleParty for schema 0.5.0
#   Stan Smith 2014-08-15 modified citation, onlineResource, resourceId for 0.6.0
#   Stan Smith 2014-09-03 added spatialReferenceSystems for name, EPSG, and WKT for 0.6.0
#   Stan Smith 2014-11-06 added resourceType to resourceInfo for 0.9.0
#   Stan Smith 2014-11-06 removed metadataScope from metadataInfo for 0.9.0
#   Stan Smith 2014-11-06 added newAdditionalDocumentation
#   Stan Smith 2014-12-01 added data dictionary
#   Stan Smith 2015-02-17 add entity and attribute alias
#   Stan Smith 2015-02-17 added support for multiple data dictionaries
#   Stan Smith 2015-07-23 added gridInfo, gridDimension for 1.3.0
#   Stan Smith 2015-07-28 added locale for 1.3.0
#   Stan Smith 2015-08-19 added coverageInfo, imageInfo, sensorInfo, coverageItem,
#                     ... classifiedData, and classedDataItem for 1.3.0

class InternalMetadata

    # initialize attribute values - nil
    # initialize arrays - []
    # initialize hashes - {}

    def initialize
    end

    def newBase
        intObj = {
            schema: {
                name: nil,
                version: nil
            },
            contacts: [],
            metadata: {},
            dataDictionary: []
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
        intObj = {
            contactId: nil,
            indName: nil,
            orgName: nil,
            position: nil,
            phones: [],
            address: {},
            onlineRes: [],
            contactInstructions: nil
        }
    end

    def newPhone
        intObj = {
            phoneServiceType: nil,
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
            metadataInfo: {},
            resourceInfo: {},
            distributorInfo: [],
            associatedResources: [],
            additionalDocuments: []
        }
    end

    def newMetadataInfo
        intObj = {
            metadataId: {},
            parentMetadata: {},
            metadataCustodians: [],
            metadataCreateDate: {},
            metadataUpdateDate: {},
            metadataLanguage: nil,
            metadataCharacterSet: nil,
            metadataLocales: [],
            metadataURI: nil,
            metadataStatus: nil,
            maintInfo: {},
            extensions: []
        }
    end

    def newRespParty
        intObj = {
            contactId: nil,
            roleName: nil
        }
    end

    def newOnlineResource
        intObj = {
            olResURI: nil,
            olResProtocol: nil,
            olResName: nil,
            olResDesc: nil,
            olResFunction: nil
        }
    end

    def newResourceInfo
        intObj = {
            resourceType: nil,
            citation: {},
            timePeriod: {},
            abstract: nil,
            shortAbstract: nil,
            hasMapLocation?: nil,
            hasDataAvailable?: nil,
            purpose: nil,
            credits: [],
            status: nil,
            pointsOfContact: [],
            resourceMaint: [],
            graphicOverview: [],
            resourceFormats: [],
            resourceLanguages: [],
            resourceCharacterSets: [],
            resourceLocales: [],
            descriptiveKeywords: [],
            resourceUses: [],
            useConstraints: [],
            legalConstraints: [],
            securityConstraints: [],
            taxonomy: {},
            spatialReferenceSystem: {},
            spatialRepresentationTypes: [],
            spatialResolutions: [],
            topicCategories: [],
            environmentDescription: nil,
            extents: [],
            gridInfo: [],
            coverageInfo: [],
            dataQualityInfo: [],
            supplementalInfo: nil
        }
    end

    def newCitation
        intObj = {
            citTitle: nil,
            citAltTitle: nil,
            citDate: [],
            citEdition: nil,
            citResourceIds: [],
            citResponsibleParty: [],
            citResourceForms: [],
            citOlResources: []
        }
    end

    def newResourceId
        # handles both MD_Identifier and RS_Identifier
        intObj = {
            identifier: nil,
            identifierType: nil,
            identifierNamespace: nil,
            identifierVersion: nil,
            identifierDescription: nil,
            identifierCitation: {}
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
            keyTheCitation: {}
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
            bGName: nil,
            bGDescription: nil,
            bGType: nil,
            bGURI: nil
        }
    end

    def newSpatialReferenceSystem
        intObj = {
            sRNames: [],
            sREPSGs: [],
            sRWKTs: []
        }
    end

    def newExtent
        intObj = {
            extDesc: nil,
            extGeoElements: [],
            extIdElements: [],
            extTempElements: [],
            extVertElements: []
        }
    end

    def newGeoElement
        intObj = {
            elementId: nil,
            elementIncludeData: nil,
            elementName: nil,
            elementDescription: nil,
            temporalElements: [],
            verticalElements: [],
            elementIdentifiers: [],
            elementScope: nil,
            elementAcquisition: nil,
            elementSrs: {},
            elementGeometry: {}
        }
    end

    def newSRS
        intObj = {
            srsName: nil,
            srsHref: nil,
            srsType: nil
        }
    end

    def newGeometry
        intObj = {
            geoType: nil,
            geometry: {},
            dimension: nil
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

    def newPolygonSet
        intObj = {
            exteriorRing: {},
            exclusionRings: []
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
            timeId: nil,
            description: nil,
            timePosition: {}
        }
    end

    def newTimePeriod
        intObj = {
            timeId: nil,
            description: nil,
            beginTime: {},
            endTime: {}
        }
    end

    def newVerticalElement
        intObj = {
            minValue: nil,
            maxValue: nil,
            crsURI: nil,
            crsTitle: nil
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
            stepId: nil,
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

    def newAssociatedResource
        intObj = {
            associationType: nil,
            initiativeType: nil,
            resourceType: nil,
            resourceCitation: {},
            metadataCitation: {}
        }
    end

    def newAdditionalDocumentation
        intObj = {
            resourceType: nil,
            citation: {}
        }
    end

    def newDataDictionary
        intObj = {
            dictionaryInfo: {},
            domains: [],
            entities: []
        }
    end

    def newDictionaryInfo
        intObj = {
            dictCitation: {},
            dictDescription: nil,
            dictResourceType: nil,
            dictLanguage: nil
        }
    end

    def newDictionaryDomain
        intObj = {
            domainId: nil,
            domainName: nil,
            domainCode: nil,
            domainDescription: nil,
            domainItems: []
        }
    end

    def newDomainItem
        intObj = {
            itemName: nil,
            itemValue: nil,
            itemDefinition: nil
        }
    end

    def newEntity
        intObj = {
            entityId: nil,
            entityName: nil,
            entityCode: nil,
            entityAlias: [],
            entityDefinition: nil,
            primaryKey: [],
            indexes: [],
            attributes: [],
            foreignKeys: []
        }
    end

    def newEntityIndex
        intObj = {
            indexCode: nil,
            duplicate: false,
            attributeNames: []
        }
    end

    def newEntityAttribute
        intObj = {
            attributeName: nil,
            attributeCode: nil,
            attributeAlias: [],
            attributeDefinition: nil,
            dataType: nil,
            allowNull: true,
            unitOfMeasure: nil,
            domainId: nil,
            minValue: nil,
            maxValue: nil
        }
    end

    def newEntityForeignKey
        intObj = {
            fkLocalAttributes: [],
            fkReferencedEntity: nil,
            fkReferencedAttributes: []
        }
    end

    def newGridInfo
        intObj = {
            dimensions: nil,
            dimensionInfo: [],
            dimensionGeometry: nil,
            dimensionTransformParams: false
        }
    end

    def newDimensionInfo
        intObj = {
            dimensionType: nil,
            dimensionTitle: nil,
            dimensionDescription: nil,
            dimensionSize: nil,
            resolution: nil,
            resolutionUnits: nil
        }
    end

    def newCoverageInfo
        intObj = {
            coverageType: nil,
            coverageName: nil,
            coverageDescription: nil,
            processingLevel: {},
            coverageItems: [],
            imageInfo: {}
        }
    end

    def newCoverageItem
        intObj = {
            itemName: nil,
            itemType: nil,
            itemDescription: nil,
            minValue: nil,
            maxValue: nil,
            units: nil,
            scaleFactor: nil,
            offset: nil,
            meanValue: nil,
            standardDeviation: nil,
            bitsPerValue: nil,
            classedData: {},
            sensorInfo: {}
        }
    end

    def newClassedData
        intObj = {
            numberOfClasses: nil,
            classedDataItems: []
        }
    end

    def newClassedDataItem
        intObj = {
            className: nil,
            classDescription: nil,
            classValue: nil
        }
    end

    def newImageInfo
        intObj = {
            illuminationElevationAngle: nil,
            illuminationAzimuthAngle: nil,
            imageCondition: nil,
            imageQuality: {},
            cloudCoverPercent: nil,
            compressionQuantity: nil,
            triangulationInfo: false,
            radiometricCalibrationInfo: false,
            cameraCalibrationInfo: false,
            filmDistortionInfo: false,
            lensDistortionInfo: false
        }
    end

    def newSensorInfo
        intObj = {
            toneGradations: nil,
            sensorMin: nil,
            sensorMax: nil,
            sensorUnits: nil,
            sensorPeakResponse: nil
        }
    end

    def newLocale
        intObj = {
            languageCode: nil,
            countryCode: nil,
            characterEncoding: nil
        }
    end

end