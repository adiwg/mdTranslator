# ADIwg ISO Translator internal data structure

# History:
# version 2
#   Stan Smith 2016-10-20 deleted newDictionaryInfo, move element to newDataDictionary
#   Stan Smith 2016-10-19 added newSpatialRepresentation
#   Stan Smith 2016-10-19 added newGeorectifiedInfo
#   Stan Smith 2016-10-19 added newVectorInfo, newVectorObject
#   Stan Smith 2016-10-18 deleted newCoverageInfo, newCoverageItem
#   Stan Smith 2016-10-18 added newAttributeGroup
#   Stan Smith 2016-10-18 deleted newClassedData, newClassedDataItem
#   Stan Smith 2016-10-17 added elements to newLineage
#   Stan Smith 2016-10-17 added elements to newDataSource
#   Stan Smith 2016-10-16 removed newResolution
#   Stan Smith 2016-10-16 added newMeasure
#   Stan Smith 2016-10-16 added newSpatialResolution
#   Stan Smith 2016-10-15 renamed newDataProcess Step to newProcessStep
#   Stan Smith 2016-10-15 added newConstraints object
#   Stan Smith 2016-10-15 added constraint object to newSecurityConstraint
#   Stan Smith 2016-10-15 added constraint object to newLegalConstraint
#   Stan Smith 2016-10-15 added newConstraint object
#   Stan Smith 2016-10-15 added newRelease object
#   Stan Smith 2016-10-14 added newScope object
#   Stan Smith 2016-10-14 added newTimeInterval object
#   Stan Smith 2016-10-13 added newScopeDescription object
#   Stan Smith 2016-10-13 added attributes to newCitation for mdJson 2.0
#   Stan Smith 2016-10-13 renamed newResourceId to newIdentifier, dropped identifierType
#   Stan Smith 2016-10-12 renamed newBrowseGraphic to newGraphic, added graphicConstraint []
#   Stan Smith 2016-10-12 added newSeries object
#   Stan Smith 2016-10-12 added newDate object
#   Stan Smith 2016-10-11 renamed newDataUsage to newResourceUsage
#   Stan Smith 2016-10-09 add newParty
#   Stan Smith 2016-10-08 removed dateType from dateTime object
#   Stan Smith 2016-10-01 made phone service types an array
#   Stan Smith 2016-10-03 added duration object

# version 1
#   Stan Smith 2015-07-23 added gridInfo, gridDimension for 1.3.0
#   Stan Smith 2015-07-28 added locale for 1.3.0
#   Stan Smith 2015-08-19 added coverageInfo, imageInfo, sensorInfo, coverageItem,
#                     ... classifiedData, and classedDataItem for 1.3.0
#   Stan Smith 2015-09-18 extended distributionInfo sections for 1.3.0

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

    def newDate
        intObj = {
            date: nil,
            dateResolution: nil,
            dateType: nil
        }
    end

    def newDateTime
        intObj = {
            dateTime: nil,
            dateResolution: nil
        }
    end

    def newContact
        intObj = {
            contactId: nil,
            isOrganization: false,
            name: nil,
            position: nil,
            memberOfOrgs: [],
            logos: [],
            phones: [],
            address: {},
            onlineRes: [],
            hoursOfService: [],
            contactInstructions: nil,
            contactType: false
        }
    end

    def newPhone
        intObj = {
            phoneName: nil,
            phoneNumber: nil,
            phoneServiceTypes: []
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
            roleName: nil,
            timePeriod: {},
            party: []
        }
    end

    def newParty
        intObj = {
            contactId: nil,
            contactIndex: nil,
            contactType: nil,
            organizationMembers: []
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
            citAltTitle: [],
            citDate: [],
            citEdition: nil,
            citResponsibleParty: [],
            citPresentationForms: [],
            citIdentifiers: [],
            citSeries: {},
            citOtherDetails: [],
            citOlResources: [],
            citGraphics: []
        }
    end

    def newIdentifier
        # handles both MD_Identifier and RS_Identifier (ISO 19115-2)
        intObj = {
            identifier: nil,
            identifierNamespace: nil,
            identifierVersion: nil,
            identifierDescription: nil,
            identifierCitation: {}
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

    def newConstraints
        intObj = {
            constraints: [],
            legalConstraints: [],
            securityConstraints: []
        }
    end

    def newConstraint
        intObj = {
            useLimitation: [],
            scope: {},
            graphic: [],
            reference: [],
            releasability: {},
            responsibleParty: []
        }
    end

    def newLegalConstraint
        intObj = {
            constraint: {},
            accessCodes: [],
            useCodes: [],
            otherCodes: []
        }
    end

    def newSecurityConstraint
        intObj = {
            constraint: {},
            classCode: nil,
            userNote: nil,
            classSystem: nil,
            handling: nil
        }
    end

    def newRelease
        intObj = {
            addressee: [],
            statement: nil,
            disseminationConstraint: []
        }
    end

    def newDistributor
        intObj = {
            distContact: {},
            distOrderProcs: [],
            distFormats: [],
            distTransOptions: []
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
            distFormats: [],
            transferSize: nil,
            transferSizeUnits: nil,
            online: [],
            offline: {}
        }
    end

    def newMedium
        intObj = {
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
        intObj = {
            formatSpecification: {},
            amendmentNumber: nil,
            compressionMethod: nil
        }
    end

    def newGraphic
        intObj = {
            graphicName: nil,
            graphicDescription: nil,
            graphicType: nil,
            graphicConstraint: [],
            graphicURI: []
        }
    end

    def newSpatialReferenceSystem
        intObj = {
            systemType: nil,
            systemIdentifier: {}
        }
    end

    def newSpatialResolution
        intObj = {
            type: nil,
            scaleFactor: nil,
            measure: {},
            levelOfDetail: nil
        }
    end

    def newMeasure
        intObj = {
            type: nil,
            value: nil,
            unitOfMeasure: nil
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
            elementType: nil,
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
            identifier: nil,
            periodNames: [],
            startDateTime: {},
            endDateTime: {},
            timeInterval: {}
        }
    end

    def newDuration
        intObj = {
            years: nil,
            months: nil,
            days: nil,
            hours: nil,
            minutes: nil,
            seconds: nil
        }
    end

    def newTimeInterval
        intObj = {
            interval: nil,
            units: nil
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

    def newResourceUsage
        intObj = {
            specificUsage: nil,
            userLimitation: nil,
            limitationResponses: [],
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

    def newDataQuality
        intObj = {
            dataScope: nil,
            dataLineage: {}
        }
    end

    def newLineage
        intObj = {
            statement: nil,
            resourceScope: {},
            lineageCitation: [],
            dataSources: [],
            processSteps: []
        }
    end

    def newProcessStep
        intObj = {
            stepId: nil,
            description: nil,
            rationale: nil,
            timePeriod: {},
            processors: [],
            references: []
        }
    end

    def newDataSource
        intObj = {
            description: nil,
            sourceCitation: {},
            metadataCitation: [],
            spatialResolution: {},
            referenceSystem: {},
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
            resourceType: nil,
            associationType: nil,
            initiativeType: nil,
            resourceCitation: {},
            metadataCitation: {}
        }
    end

    def newAdditionalDocumentation
        intObj = {
            resourceType: nil,
            citation: []
        }
    end

    def newDataDictionary
        intObj = {
            citation: {},
            description: nil,
            resourceType: nil,
            language: nil,
            includedWithDataset: false,
            domains: [],
            entities: []
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

    def newSpatialRepresentation
        intObj = {
            type: nil,
            gridRepresentation: {},
            vectorRepresentation: {},
            georectifiedRepresentation: {},
            georeferencableRepresentation: {}
        }
    end

    def newGridInfo
        intObj = {
            numberOfDimensions: nil,
            dimension: [],
            cellGeometry: nil,
            transformParamsAvailability: false
        }
    end

    def newDimension
        intObj = {
            dimensionType: nil,
            dimensionTitle: nil,
            dimensionDescription: nil,
            dimensionSize: nil,
            resolution: {}
        }
    end

    def newVectorInfo
        intObj = {
            topologyLevel: nil,
            vectorObject: []
        }
    end

    def newVectorObject
        intObj = {
            objectType: nil,
            objectCount: nil
        }
    end

    def newGeorectifiedInfo
        intObj = {
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

    def newGeoreferencableInfo
        intObj = {
            gridRepresentation: {},
            controlPointAvailability: false,
            orientationParameterAvailability: false,
            orientationParameterDescription: nil,
            georeferencedParameter: nil,
            parameterCitation: []
        }
    end

    def newContentInfo
        intObj = {
            coverageName: nil,
            coverageDescription: nil,
            processingLevelCode: {},
            attributeGroup: [],
            imageDescription: {}
        }
    end

    def newAttributeGroup
        intObj = {
            attributeContentType: [],
            attributeDescription: nil,
            sequenceIdentifier: nil,
            sequenceIdentifierType: nil,
            attributeIdentifier: [],
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
            nominalSpatialResolution: {},
            transferFunctionType: nil,
            transmittedPolarization: nil,
            detectedPolarization: nil
        }
    end

    def newImageDescription
        intObj = {
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

    def newSeries
        intObj = {
            seriesName: nil,
            seriesIssue: nil,
            issuePage: nil
        }
    end

    def newScope
        intObj = {
            scopeCode: nil,
            scopeDescription: [],
            timePeriod: []
        }
    end

    def newScopeDescription
        intObj = {
            type: nil,
            description: nil
        }
    end

end
