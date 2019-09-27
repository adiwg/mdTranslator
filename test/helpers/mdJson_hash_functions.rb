
require 'adiwg/mdtranslator/internal/module_dateTimeFun'

class MdJsonHashWriter

   def build_additionalDocumentation
      hDoc = additionalDocumentation
      return hDoc
   end

   def build_associatedResource(associationType = nil, title = nil)
      hAssocRes = associatedResource
      hAssocRes[:associationType] = associationType unless associationType.nil?
      hAssocRes[:resourceCitation][:title] = title unless title.nil?
      return hAssocRes
   end

   def build_attributeGroup
      hAttGroup = attributeGroup
      return hAttGroup
   end

   def build_bearingResolution(distRes = nil, distUnit = nil, bearRes = nil, bearUnit = nil, direct = nil, meridian = nil)
      hResolution = {}
      hBearRes = {}
      distRes ? hBearRes[:distanceResolution] = distRes : hBearRes[:distanceResolution] = 9.99
      distUnit ? hBearRes[:distanceUnitOfMeasure] = distUnit : hBearRes[:distanceUnitOfMeasure] = 'unit of measure'
      bearRes ? hBearRes[:bearingResolution] = bearRes : hBearRes[:bearingResolution] = 9.99
      bearUnit ? hBearRes[:bearingUnitOfMeasure] = bearUnit : hBearRes[:bearingUnitOfMeasure] = 'bearing units'
      direct ? hBearRes[:bearingReferenceDirection] = direct : hBearRes[:bearingReferenceDirection] = 'bearing direction'
      meridian ? hBearRes[:bearingReferenceMeridian] = meridian : hBearRes[:bearingReferenceMeridian] = 'bearing meridian'
      hResolution[:bearingDistanceResolution] = hBearRes
      return hResolution
   end

   def build_citation(title, contactId = nil)
      hCitation = citation
      hCitation[:title] = title
      unless contactId.nil?
         hCitation[:responsibleParty][0][:party][0][:contactId] = contactId
      end
      return hCitation
   end

   def build_coordinateResolution(x = nil, y = nil, measure = nil)
      hResolution = {}
      hCoordResolution = {}
      x ? hCoordResolution[:abscissaResolutionX] = x : hCoordResolution[:abscissaResolutionX] = 9.99
      y ? hCoordResolution[:ordinateResolutionY] = y : hCoordResolution[:ordinateResolutionY] = 9.99
      measure ? hCoordResolution[:unitOfMeasure] = measure : hCoordResolution[:unitOfMeasure] = 'unit of measure'
      hResolution[:coordinateResolution] = hCoordResolution
      return hResolution
   end

   def build_coverageDescription
      hCoverage = coverageDescription
      return hCoverage
   end
   
   def build_dataDictionary
      hDictionary = dataDictionary
      return hDictionary
   end

   def build_date(dateTime, type = 'none')
      hDate = date
      hDate[:date] = dateTime
      hDate[:dateType] = type
      return hDate
   end

   def build_dictionaryDomain(id = nil, common = nil, code = nil, description = nil)
      hDomain = dictionaryDomain
      hDomain[:domainId] = id unless id.nil?
      hDomain[:commonName] = common unless common.nil?
      hDomain[:codeName] = code unless code.nil?
      hDomain[:description] = description unless description.nil?
      return hDomain
   end

   def build_distribution(description = nil, liability = nil)
      hDistribution = distribution
      hDistribution[:description] = description unless description.nil?
      hDistribution[:liabilityStatement] = liability unless liability.nil?
      return hDistribution
   end

   def build_distributor(contactId)
      hDistributor = distributor
      hResParty = build_responsibleParty('distributor', [contactId])
      hDistributor[:contact] = hResParty
      return hDistributor
   end

   def build_duration(year: nil, mon: nil, day: nil, hour: nil, min: nil, sec: nil)
      hDuration = {}
      hDuration[:years] = year
      hDuration.delete(:years) if year.nil?
      hDuration[:months] = mon
      hDuration.delete(:months) if mon.nil?
      hDuration[:days] = day
      hDuration.delete(:days) if day.nil?
      hDuration[:hours] = hour
      hDuration.delete(:hours) if hour.nil?
      hDuration[:minutes] = min
      hDuration.delete(:minutes) if min.nil?
      hDuration[:seconds] = sec
      hDuration.delete(:seconds) if sec.nil?
      return hDuration
   end

   def build_entity(id = nil, common = nil, code = nil, definition = nil, aPK = nil)
      hEntity = entity
      hEntity[:entityId] = id unless id.nil?
      hEntity[:commonName] = common unless common.nil?
      hEntity[:codeName] = code unless code.nil?
      hEntity[:definition] = definition unless definition.nil?
      hEntity[:primaryKeyAttributeCodeName] = aPK unless aPK.nil?
      return hEntity
   end

   def build_entityAttribute(common = nil, code = nil, definition = nil)
      hAttribute = entityAttribute
      hAttribute[:commonName] = common unless common.nil?
      hAttribute[:codeName] = code unless code.nil?
      hAttribute[:definition] = definition unless definition.nil?
      return hAttribute
   end

   def build_extent(description = nil)
      hExtent = extent
      hExtent[:description] = description unless description.nil?
      return hExtent
   end

   def build_feature(id, geometry, description = nil)
      hFeature = feature
      hFeature[:id] = id
      hFeature[:geometry] = point if geometry == 'point'
      hFeature[:geometry] = lineString if geometry == 'line'
      hFeature[:geometry] = polygon if geometry == 'polygon'
      hFeature[:geometry] = multiPoint if geometry == 'multiPoint'
      hFeature[:geometry] = multiLineString if geometry == 'multiLine'
      hFeature[:geometry] = multiPolygon if geometry == 'multiPolygon'
      hFeature[:properties][:description] = description unless description.nil?
      return hFeature
   end

   def build_featureCollection
      return featureCollection
   end

   def build_funding(id = nil, amount = nil, description = nil)
      hFunding = funding
      hFunding[:allocation][0][:sourceAllocationId] = id unless id.nil?
      hFunding[:allocation][0][:amount] = amount unless amount.nil?
      hFunding[:description] = description unless description.nil?
      return hFunding
   end
   
   def build_geoJson
      aGeoJson = []
      aGeoJson << point
      aGeoJson << lineString
      aGeoJson << polygon
      aGeoJson << multiPoint
      aGeoJson << multiLineString
      aGeoJson << multiPolygon
      hGeoCollection = geometryCollection
      hGeoCollection[:geometries] << point
      hGeoCollection[:geometries] << point
      aGeoJson << hGeoCollection
      hFeature = feature
      hFeature[:id] = 'FID001'
      hFeature[:bbox] = [1, 2, 3, 4]
      hFeature[:geometry] = point
      hFeature[:properties] = properties
      aGeoJson << hFeature
      hFeatCollection = featureCollection
      hFeatCollection[:bbox] = [1, 2, 3, 4]
      hFeatCollection[:features] << hFeature
      hFeatCollection[:features] << hFeature
      aGeoJson << hFeatCollection
      return aGeoJson
   end

   def build_geologicAge
      hGeologicAge = geologicAge
      return hGeologicAge
   end

   def build_geometryCollection
      hCollection = geometryCollection
      return hCollection
   end

   def build_graphic(name = nil, description = nil, type = nil)
      hGraphic = graphic
      hGraphic[:fileName] = name unless name.nil?
      hGraphic[:fileDescription] = description unless description.nil?
      hGraphic[:fileType] = type unless type.nil?
      return hGraphic
   end

   def build_geographicResolution
      hResolution = {}
      hResolution[:geographicResolution] = geographicResolution
      return hResolution
   end

   def build_georectifiedRepresentation
      hGeoRec = georectified
      hGrid = build_gridRepresentation
      hGeoRec[:gridRepresentation] = hGrid
      return hGeoRec
   end

   def build_georeferenceableRepresentation
      hGeoRef = georeferenceable
      hGrid = build_gridRepresentation
      hGeoRef[:gridRepresentation] = hGrid
      return hGeoRef
   end

   def build_gridRepresentation(dimensions = nil, geometry = nil)
      hGrid = gridRepresentation
      hGrid[:numberOfDimensions] = dimensions unless dimensions.nil?
      hGrid[:cellGeometry] = geometry unless geometry.nil?
      hGrid[:dimension] << dimension
      hGrid[:dimension] << dimension
      return hGrid
   end

   def build_identifier(id = nil, namespace = nil, version = nil, description = nil)
      hIdentifier = identifier
      hIdentifier[:identifier] = id unless id.nil?
      hIdentifier[:namespace] = namespace unless namespace.nil?
      hIdentifier[:version] = version unless version.nil?
      hIdentifier[:description] = description unless description.nil?
      return hIdentifier
   end

   def build_keywords(title = nil, theme = nil)
      hKeywords = keywords
      hKeywords[:keywordType] = theme unless theme.nil?
      hKeywords[:thesaurus][:title] = title unless title.nil?
      return hKeywords
   end

   def build_keywords_full
      hKeywords = keywords
      add_keyword(hKeywords, 'keyword one', 'KEYID001')
      add_keyword(hKeywords, 'keyword two')
      return hKeywords
   end

   def build_legalConstraint(aAccess = [], aUse = [], aOther = [])
      hCon = legalConstraint
      hCon[:legal][:accessConstraint] = aAccess unless aAccess.empty?
      hCon[:legal][:useConstraint] = aUse unless aUse.empty?
      hCon[:legal][:otherConstraint] = aOther unless aOther.empty?
      return hCon
   end

   def build_leProcessStep(id, description = nil, hTimePeriod = nil)
      hStep = processStep
      hStep[:stepId] = id
      hStep[:description] = description unless description.nil?
      hStep[:timePeriod] = hTimePeriod unless hTimePeriod.nil?
      hStep[:report] << processStepReport
      return hStep
   end

   def build_leProcessStep_full
      hProcess = processStep
      hProcess[:timePeriod] = build_timePeriod('TP001', 'process time', '2018-06-22')
      hProcess[:processor] << build_responsibleParty('processor', %w(CID003))
      hProcess[:processor] << build_responsibleParty('processor', %w(CID003))
      hProcess[:stepSource] << build_leSource('SRC001')
      hProcess[:stepSource] << build_leSource('SRC002')
      hProcess[:stepProduct] << build_leSource('SRC003')
      hProcess[:stepProduct] << build_leSource('SRC004')
      hProcess[:reference] << citation_title
      hProcess[:reference] << citation_title
      hProcess[:scope] = scope
      hProcess[:processingInformation] = processing
      hProcess[:report] << processStepReport
      hProcess[:report] << processStepReport
      return hProcess
   end

   def build_leSource(id, description = nil, resolution = nil, hScope = nil)
      hSource = source
      hSource[:sourceId] = id
      hSource[:sourceCitation] =  citation
      hSource[:description] = description unless description.nil?
      unless resolution.nil?
         hResolution = {}
         hResolution[:scaleFactor] = resolution
         hSource[:spatialResolution] = hResolution
      end
      hSource[:scope] = hScope unless hScope.nil?
      return hSource
   end

   def build_leSource_full
      hSource = source
      hSource[:metadataCitation] << citation_title
      hSource[:metadataCitation] << citation_title
      hSource[:sourceProcessStep] << build_leProcessStep('PS001', 'process step one')
      hSource[:sourceProcessStep] << build_leProcessStep('PS002', 'process step two')
      return hSource
   end

   def build_lineage
      hLineage = lineage
      return hLineage
   end

   def build_lineage_full
      hLineage = lineage
      hLineage[:processStep] << build_liProcessStep('step one', 'lineage step one')
      hLineage[:processStep] << build_leProcessStep('step two', 'lineage step two')
      hLineage[:source] << build_liSource('source one', 'lineage source one')
      hLineage[:source] << build_leSource('source two', 'lineage source two')
      return hLineage
   end

   def build_liProcessStep(id, description = nil, hTimePeriod = nil)
      hStep = processStep
      hStep[:stepId] = id
      hStep[:description] = description unless description.nil?
      hStep[:timePeriod] = hTimePeriod unless hTimePeriod.nil?
      hStep.delete(:stepProduct)
      hStep.delete(:processingInformation)
      hStep.delete(:report)
      return hStep
   end

   def build_liProcessStep_full
      hProcess = build_leProcessStep_full
      hProcess.delete(:stepProduct)
      hProcess.delete(:processingInformation)
      hProcess.delete(:report)
      return hProcess
   end

   def build_liSource(id, description = nil, resolution = nil, hScope = nil)
      hSource = source
      hSource[:sourceId] = id
      hSource[:sourceCitation] =  citation
      hSource[:description] = description unless description.nil?
      unless resolution.nil?
         hResolution = {}
         hResolution[:scaleFactor] = resolution
         hSource[:spatialResolution] = hResolution
      end
      hSource[:scope] = hScope unless hScope.nil?
      hSource.delete(:processedLevel)
      hSource.delete(:resolution)
      return hSource
   end

   def build_liSource_full
      hSource = build_leSource_full
      hSource.delete(:processedLevel)
      hSource.delete(:resolution)
      return hSource
   end

   def build_locale(language = nil, character = nil, country = nil)
      hLocale = locale
      hLocale[:language] = language unless language.nil?
      hLocale[:characterSet] = character unless character.nil?
      hLocale[:country] = country unless country.nil?
      return hLocale
   end

   def build_maintenance
      hMaintenance = maintenance
      return hMaintenance
   end
   
   def build_measure(type = nil, value = nil, units = nil)
      hMeasure = measure
      hMeasure[:type] = type unless type.nil?
      hMeasure[:value] = value unless value.nil?
      hMeasure[:unitOfMeasure] = units unless units.nil?
      return hMeasure
   end

   def build_metadata_full
      hMetadata = metadata
      hMetadata[:metadataInfo] = build_metadataInfo_full
      hMetadata[:resourceInfo] = build_resourceInfo_full
      hMetadata[:resourceLineage] << build_lineage
      hMetadata[:resourceLineage] << build_lineage
      hMetadata[:resourceDistribution] << build_distribution
      hMetadata[:resourceDistribution] << build_distribution
      hMetadata[:associatedResource] << build_associatedResource
      hMetadata[:associatedResource] << build_associatedResource
      hMetadata[:additionalDocumentation] << build_additionalDocumentation
      hMetadata[:additionalDocumentation] << build_additionalDocumentation
      hMetadata[:funding] << build_funding
      hMetadata[:funding] << build_funding
      removeEmptyObjects(hMetadata)
      return hMetadata
   end

   def build_metadataInfo_full
      hMetadataInfo = metadataInfo
      hMetadataInfo[:metadataIdentifier] = build_identifier('metadata info identifier')
      hMetadataInfo[:parentMetadata] = build_citation('parent metadata title')
      hMetadataInfo[:defaultMetadataLocale] = locale
      hMetadataInfo[:otherMetadataLocale] << locale
      hMetadataInfo[:otherMetadataLocale] << locale
      hMetadataInfo[:metadataContact] << build_responsibleParty('metadata contact one', ['CID001'])
      hMetadataInfo[:metadataContact] << build_responsibleParty('metadata contact two', ['CID002'])
      hMetadataInfo[:metadataDate] << build_date('2018-06-21', 'metadata date one')
      hMetadataInfo[:metadataDate] << build_date('2018-06-21', 'metadata date two')
      hMetadataInfo[:metadataOnlineResource] << build_onlineResource('https://adiwg.ord/1')
      hMetadataInfo[:metadataOnlineResource] << build_onlineResource('https://adiwg.ord/2')
      hMetadataInfo[:metadataConstraint] << build_useConstraint
      hMetadataInfo[:metadataConstraint] << build_legalConstraint
      hMetadataInfo[:alternateMetadataReference] << build_citation('alternate metadata title one')
      hMetadataInfo[:alternateMetadataReference] << build_citation('alternate metadata title two')
      hMetadataInfo[:metadataMaintenance] = build_maintenance
      return hMetadataInfo
   end

   def build_metadataRepository(repo = nil, standard = nil)
      hRepo = metadataRepository
      hRepo[:repository] = repo unless repo.nil?
      hRepo[:standard] = standard unless standard.nil?
      return hRepo
   end

   def build_onlineResource(uri)
      hResource = onlineResource
      hResource[:uri] = uri
      return hResource
   end

   def build_organization_full(contactId = nil, name = nil)
      hContact = organization_full
      hContact[:contactId] = contactId unless contactId.nil?
      hContact[:name] = name unless name.nil?
      return hContact
   end

   def build_parameterSet(addProj = false, addGeo = false, addVert = false)
      hParamSet = referenceSystemParameterSet
      hParamSet[:projection] = projection if addProj
      hParamSet[:geodetic] = geodetic if addGeo
      hParamSet[:verticalDatum] = verticalDatum if addVert
      hParamSet.delete(:projection) unless addProj
      hParamSet.delete(:geodetic) unless addGeo
      hParamSet.delete(:verticalDatum) unless addVert
      return hParamSet
   end

   def build_person_full(contactId = nil, name = nil)
      hContact = person_full
      hContact[:contactId] = contactId unless contactId.nil?
      hContact[:name] = name unless name.nil?
      return hContact
   end

   def build_processing_full
      hProcessing = processing
      hProcessing[:softwareReference] = citation_title
      hProcessing[:documentation] << citation_title
      hProcessing[:documentation] << citation_title
      hProcessing[:algorithm] << algorithm
      hProcessing[:algorithm] << algorithm
      return hProcessing
   end

   def build_projection(id, name = nil, description = nil, complete = false)
      if complete
         hProjection = projection
         return hProjection
      end
      hProjection = {}
      hProjectionId = {}
      hProjection[:projectionIdentifier] =  hProjectionId
      hProjectionId[:identifier] = id
      hProjectionId[:name] = name unless name.nil?
      hProjectionId[:description] = description unless description.nil?
      return hProjection
   end

   def build_resourceFormat(title = nil, amendment = nil, compMethod = nil, prereq = nil)
      hFormat = resourceFormat
      hFormat[:formatSpecification][:title] = title unless title.nil?
      hFormat[:amendmentNumber] = amendment unless amendment.nil?
      hFormat[:compressionMethod] = compMethod unless compMethod.nil?
      hFormat[:technicalPrerequisite] = prereq unless prereq.nil?
      return hFormat
   end

   def build_resourceInfo_full
      hResourceInfo = resourceInfo
      hResourceInfo[:resourceType] << resourceType
      hResourceInfo[:resourceType] << resourceType
      hResourceInfo[:citation] = build_citation('resource info citation title')
      hResourceInfo[:timePeriod] = build_timePeriod('TID001', 'resource time period', '2018-06-21')
      hResourceInfo[:pointOfContact] << build_responsibleParty('pointOfContact', ['CID001'])
      hResourceInfo[:pointOfContact] << build_responsibleParty('pointOfContact', ['CID002'])
      hResourceInfo[:spatialReferenceSystem] << build_spatialReference('wkt')
      hResourceInfo[:spatialReferenceSystem] << build_spatialReference('wkt')
      hResourceInfo[:spatialRepresentation] << build_spatialRepresentation('grid', build_gridRepresentation)
      hResourceInfo[:spatialRepresentation] << build_spatialRepresentation('grid', build_gridRepresentation)
      hResourceInfo[:spatialResolution] << build_spatialResolution('factor')
      hResourceInfo[:spatialResolution] << build_spatialResolution('factor')
      hResourceInfo[:temporalResolution] << duration
      hResourceInfo[:temporalResolution] << duration
      hResourceInfo[:extent] << build_extent('extent one')
      hResourceInfo[:extent] << build_extent('extent two')
      hResourceInfo[:coverageDescription] << build_coverageDescription
      hResourceInfo[:coverageDescription] << build_coverageDescription
      hResourceInfo[:taxonomy] << taxonomy
      hResourceInfo[:taxonomy] << taxonomy
      hResourceInfo[:graphicOverview] << build_graphic('graphic one')
      hResourceInfo[:graphicOverview] << build_graphic('graphic two')
      hResourceInfo[:resourceFormat] << build_resourceFormat('resource format one')
      hResourceInfo[:resourceFormat] << build_resourceFormat('resource format two')
      hResourceInfo[:keyword] << build_keywords('keywords one', 'theme one')
      add_keyword(hResourceInfo[:keyword][0], 'keyword one', 'KWID001')
      hResourceInfo[:keyword] << build_keywords('keywords two', 'theme two')
      add_keyword(hResourceInfo[:keyword][1], 'keyword two', 'KWID002')
      hResourceInfo[:resourceUsage] << build_resourceUsage(usage: 'resource usage one')
      hResourceInfo[:resourceUsage] << build_resourceUsage(usage:'resource usage two')
      hResourceInfo[:constraint] << build_useConstraint
      hResourceInfo[:constraint] << build_legalConstraint
      hResourceInfo[:otherResourceLocale] << locale
      hResourceInfo[:otherResourceLocale] << locale
      hResourceInfo[:resourceMaintenance] << maintenance
      hResourceInfo[:resourceMaintenance] << maintenance
      return hResourceInfo
   end

   def build_resourceUsage(usage: nil, startDT: '2018-05-02', endDT: nil, aContacts: ['CID004'], timeID: 'TP001')
      hUsage = resourceUsage
      hUsage[:specificUsage] = usage unless usage.nil?
      hTimePeriod = build_timePeriod(timeID, 'usage one', startDT, endDT)
      hUsage[:temporalExtent] << { timePeriod: hTimePeriod }
      hUsage[:userContactInfo] << build_responsibleParty('pointOfContact', aContacts)
      return hUsage
   end

   def build_resourceUsage_full
      hUsage = resourceUsage
      hTimePeriod = build_timePeriod('TP001', 'usage time', '2018-06-24')
      hUsage[:temporalExtent] << { timePeriod: hTimePeriod }
      hTimePeriod = build_timePeriod('TP002', 'usage time', '2019-05-15')
      hUsage[:temporalExtent] << { timePeriod: hTimePeriod }
      hUsage[:additionalDocumentation] << citation_title
      hUsage[:userContactInfo] << build_responsibleParty('pointOfContact', ['CID001'])
      hUsage[:userContactInfo] << build_responsibleParty('pointOfContact', ['CID003'])
      return hUsage
   end

   def build_responsibleParty(role, aParties)
      hResponsibleParty = responsibleParty
      hResponsibleParty[:role] = role
      aParties.each do |contactId|
         hParty = party
         hParty[:contactId] = contactId
         hResponsibleParty[:party] << hParty
      end
      return hResponsibleParty
   end

   def build_scope(scopeCode = nil)
      hScope = scope
      hScope[:scopeCode] = scopeCode unless scopeCode.nil?
      return hScope
   end

   def build_scope_full
      hScope = scope
      hScope[:scopeDescription] << scopeDescription
      hScope[:scopeDescription] << scopeDescription
      hScope[:scopeExtent] << extent
      hScope[:scopeExtent] << extent
      return hScope
   end

   def build_securityConstraint(classification = nil, system = nil, handling = nil, note = nil)
      hCon = securityConstraint
      hCon[:security][:classification] = classification unless classification.nil?
      hCon[:security][:classificationSystem] = system unless system.nil?
      hCon[:security][:handlingDescription] = handling unless handling.nil?
      hCon[:security][:userNote] = note unless note.nil?
      return hCon
   end

   def build_spatialReference(type = nil, hIdentifier = nil, hParameters = nil, wkt = nil)
      hSpatialRef = spatialReferenceSystem
      hSpatialRef[:referenceSystemType] = type unless type.nil?
      hSpatialRef[:referenceSystemWKT] = wkt unless wkt.nil?
      hSpatialRef[:referenceSystemIdentifier] = hIdentifier
      hSpatialRef[:referenceSystemParameterSet] = hParameters
      hSpatialRef.delete(:referenceSystemIdentifier) if hIdentifier.nil?
      hSpatialRef.delete(:referenceSystemParameterSet) if hParameters.nil?
      hSpatialRef.delete(:referenceSystemWKT) if wkt.nil?
      return hSpatialRef
   end

   def build_spatialReference_full
      hSpaceRef = spatialReferenceSystem
      hSpaceRef[:referenceSystemIdentifier] = identifier
      hSpaceRef[:referenceSystemParameterSet] = build_parameterSet(true, true, true)
      return hSpaceRef
   end

   def build_spatialRepresentation(type, hObj)
      hSpaceRep = {}
      hSpaceRep[:gridRepresentation] = hObj if type == 'grid'
      hSpaceRep[:vectorRepresentation] = hObj if type == 'vector'
      hSpaceRep[:georectifiedRepresentation] = hObj if type == 'georectified'
      hSpaceRep[:georeferenceableRepresentation] = hObj if type == 'georeferenceable'
      return hSpaceRep
   end

   def build_spatialRepresentation_full
      hSpaceRep = []
      hSpaceRep << {gridRepresentation: build_gridRepresentation}
      hSpaceRep << {vectorRepresentation: build_vectorRepresentation}
      hSpaceRep[1][:vectorRepresentation][:vectorObject] << vectorObject
      hSpaceRep[1][:vectorRepresentation][:vectorObject] << vectorObject
      hSpaceRep << {georectifiedRepresentation: build_georectifiedRepresentation}
      hSpaceRep << {georeferenceableRepresentation: build_georeferenceableRepresentation}
      return hSpaceRep
   end

   def build_spatialResolution(type)
      hResolution = {}
      hResolution[:scaleFactor] = 9999 if type == 'factor'
      hResolution[:levelOfDetail] = 'level of detail' if type == 'detail'
      hResolution[:measure] = measure if type == 'measure'
      hResolution[:coordinateResolution] = coordinateResolution if type == 'coordinate'
      hResolution[:bearingDistanceResolution] = bearingDistanceResolution if type == 'bearing'
      hResolution[:geographicResolution] = geographicResolution if type == 'geographic'
      return hResolution
   end

   def build_spatialResolution_full
      aResolution = []
      aResolution << build_spatialResolution('factor')
      aResolution << build_spatialResolution('measure')
      aResolution << build_spatialResolution('detail')
      aResolution << build_spatialResolution('coordinate')
      aResolution << build_spatialResolution('bearing')
      aResolution << build_spatialResolution('geographic')
      return aResolution
   end

   def build_taxonomy
      hTaxonomy = taxonomy
      return hTaxonomy
   end

   def build_taxonomy_full(withAddress = false)
      hTaxonomy = taxonomy
      hTaxonomy[:taxonomicSystem] << taxonSystem
      hTaxonomy[:identificationReference] << citation
      hTaxonomy[:observer] << build_responsibleParty('observer', ['CID004'])
      hTaxonomy[:voucher] << build_taxonVoucher
      hTaxonomy[:taxonomicClassification] << taxonClass
      useContactAddress(hTaxonomy) if withAddress
      removeEmptyObjects(hTaxonomy)
      return hTaxonomy

   end
   
   def build_taxonomyClassification_full
      hTaxClass = taxonClass
      add_taxonClass(hTaxClass, 'level two', 'name two')
      hLevel2 = hTaxClass[:subClassification][0]
      add_taxonClass(hLevel2, 'level three', 'name three')
      hLevel3 = hLevel2[:subClassification][0]
      add_taxonClass(hLevel3, 'level four 1', 'name four 1')
      add_taxonClass(hLevel3, 'level four 2', 'name four 2', ['common four 2A'])
      hLevel40 = hLevel3[:subClassification][0]
      hLevel41 = hLevel3[:subClassification][1]
      add_taxonClass(hLevel40, 'level five 1', 'name five 1', ['common five 1A','common five 1B'])
      add_taxonClass(hLevel41, 'level five 2', 'name five 2')
      removeEmptyObjects(hTaxClass)
      return hTaxClass
   end

   def build_taxonSystem(title, contactId, modifications = nil)
      hTaxSystem = taxonSystem
      hTaxSystem[:citation][:title] = title
      hTaxSystem[:citation][:responsibleParty][0][:party][0][:contactId] = contactId
      hTaxSystem[:modifications] = modifications unless modifications.nil?
      return hTaxSystem
   end

   def build_taxonVoucher(specimen = nil, aContacts = nil)
      hVoucher = taxonVoucher
      hVoucher[:specimen] = specimen unless specimen.nil?
      aContacts = ['CID004'] if aContacts.nil?
      hVoucher[:repository] = build_responsibleParty('custodian', aContacts)
      return hVoucher
   end

   def build_timeInstant(id = nil, description = nil, startDT = nil)
      hTimeInstant = timeInstant
      hTimeInstant[:id] = id unless id.nil?
      hTimeInstant[:description] = description unless description.nil?
      hTimeInstant[:dateTime] = startDT unless startDT.nil?
      return hTimeInstant
   end
   
   def build_timeInstant_full
      hTimeInstant = build_timeInstant
      hTimeInstant[:geologicAge] = geologicAge
      hTimeInstant[:geologicAge][:ageReference] << citation_title
      return hTimeInstant
   end

   def build_timePeriod(id = nil, description = nil, startDT = nil, endDT = nil)
      hTimePeriod = timePeriod
      hTimePeriod[:id] = id unless id.nil?
      hTimePeriod[:description] = description unless description.nil?
      hTimePeriod[:startDateTime] = startDT unless startDT.nil?
      hTimePeriod[:endDateTime] = endDT unless endDT.nil?
      return hTimePeriod
   end

   def build_timePeriod_full
      hTimePeriod = build_timePeriod
      hTimePeriod[:startGeologicAge] = geologicAge
      hTimePeriod[:endGeologicAge] = geologicAge
      hTimePeriod[:timeInterval] = timeInterval
      hTimePeriod[:duration] = duration
      return hTimePeriod
   end

   def build_transferOption
      return transferOption
   end

   def build_transferOption_full
      hTranOption = build_transferOption
      hTranOption[:onlineOption] << build_onlineResource('https://adiwg.org/1')
      hTranOption[:onlineOption] << build_onlineResource('https://adiwg.org/2')
      hTranOption[:offlineOption] << medium
      hTranOption[:offlineOption] << medium
      hTranOption[:distributionFormat] << resourceFormat
      hTranOption[:distributionFormat] << resourceFormat
      return hTranOption
   end

   def build_useConstraint
      hCon = useConstraint
      return hCon
   end

   def build_vectorRepresentation(level = nil)
      hVector = vectorRepresentation
      hVector[:topologyLevel] = level unless level.nil?
      return hVector
   end

   def build_vectorRepresentation_full
      hVector = vectorRepresentation
      hVector[:vectorObject] << vectorObject
      hVector[:vectorObject] << vectorObject
      return hVector

   end

   # ---------------------------------------------------------------------------------

   def add_address(hContact, aAddType = nil)
      hAddress = address
      hAddress[:addressType] = aAddType unless aAddType.nil?
      hContact[:address] << hAddress
      return hContact
   end

   def add_allocation(hFunding, id = nil, amount = nil, currency = nil, comment = nil)
      hAllocation = allocation
      hAllocation[:sourceAllocationId] = id unless id.nil?
      hAllocation[:amount] = amount unless amount.nil?
      hAllocation[:currency] = currency unless currency.nil?
      hAllocation[:comment] = comment unless comment.nil?
      hFunding[:allocation] << hAllocation
      return hFunding
   end

   def add_altitudeBB(hBbox)
      hBbox[:minimumAltitude] = 250.0
      hBbox[:maximumAltitude] = 1500.0
      hBbox[:unitsOfAltitude] = 'meters'
      return hBbox
   end

   def add_attribute_dash1(hAttGroup, type)
      # types for ISO 19115-1 [ range | sample | mdBand | miBand ]
      hAttribute = attribute

      clear_sample = Proc.new {
         hAttribute[:maxValue] = ''
         hAttribute[:minValue] = ''
         hAttribute[:units] = ''
         hAttribute[:scaleFactor] = ''
         hAttribute[:offset] = ''
         hAttribute[:meanValue] = ''
         hAttribute[:numberOfValues] = ''
         hAttribute[:standardDeviation] = ''
         hAttribute[:bitsPerValue] = ''
      }
      clear_mdBand = Proc.new {
         hAttribute[:boundMin] = ''
         hAttribute[:boundMax] = ''
         hAttribute[:boundUnits] = ''
         hAttribute[:peakResponse] = ''
         hAttribute[:toneGradations] = ''
      }
      clear_miBand = Proc.new {
         hAttribute[:bandBoundaryDefinition] = ''
         hAttribute[:nominalSpatialResolution] = ''
         hAttribute[:transferFunctionType] = ''
         hAttribute[:transmittedPolarization] = ''
         hAttribute[:detectedPolarization] = ''
      }

      if type == 'range'
         clear_sample.call
         clear_mdBand.call
         clear_miBand.call
      end

      if type == 'sample'
         clear_mdBand.call
         clear_miBand.call
      end

      if type == 'mdBand'
         clear_miBand.call
      end

      hAttGroup[:attribute] << hAttribute
      return hAttGroup
   end

   def add_attribute_dash2(hAttGroup, type)
      # types for ISO 19115-2 [ range | mdBand | miBand ]
      hAttribute = attribute

      # remove non-ISO-2 elements
      hAttribute[:attributeIdentifier] = []
      hAttribute[:meanValue] = ''
      hAttribute[:numberOfValues] = ''
      hAttribute[:standardDeviation] = ''
      hAttribute[:boundMin] = ''
      hAttribute[:boundMax] = ''
      hAttribute[:boundUnits] = ''

      clear_mdBand = Proc.new {
         hAttribute[:peakResponse] = ''
         hAttribute[:toneGradations] = ''
         hAttribute[:maxValue] = ''
         hAttribute[:minValue] = ''
         hAttribute[:units] = ''
         hAttribute[:bitsPerValue] = ''
         hAttribute[:scaleFactor] = ''
         hAttribute[:offset] = ''
      }
      clear_miBand = Proc.new {
         hAttribute[:bandBoundaryDefinition] = ''
         hAttribute[:nominalSpatialResolution] = ''
         hAttribute[:transferFunctionType] = ''
         hAttribute[:transmittedPolarization] = ''
         hAttribute[:detectedPolarization] = ''
      }

      if type == 'range'
         clear_mdBand.call
         clear_miBand.call
      end

      if type == 'mdBand'
         clear_miBand.call
      end

      hAttGroup[:attribute] << hAttribute
      return hAttGroup
   end

   def add_bbox(hObj, north = nil, south = nil, west = nil, east = nil)
      hBbox = [60, 40, -160, -140]
      hBbox[0] = north unless north.nil?
      hBbox[1] = south unless south.nil?
      hBbox[2] = west unless west.nil?
      hBbox[3] = east unless east.nil?
      hObj[:bbox] = hBbox
      return hObj
   end

   def add_dataIndex(hEntity, code = nil, duplicate = false, attCode = nil)
      hIndex = index
      hIndex[:codeName] = code unless code.nil?
      hIndex[:allowDuplicates] = duplicate
      hIndex[:attributeCodeName] = attCode unless attCode.nil?
      hEntity[:index] << hIndex
      return hEntity
   end

   def add_dimension(hObj, type = nil, size = nil)
      hDimension = dimension
      hDimension[:dimensionType] = type unless type.nil?
      hDimension[:dimensionSize] = size unless size.nil?
      hObj[:dimension] << hDimension
      return hObj
   end

   def add_domainItem(hDomain, name = nil, value = nil, definition = nil)
      hDomItem = domainItem
      hDomItem[:name] = name unless name.nil?
      hDomItem[:value] = value unless value.nil?
      hDomItem[:definition] = definition unless definition.nil?
      hDomain[:domainItem] << hDomItem
      return hDomain
   end

   def add_duration(hTimePeriod, year = nil, mon = nil, day = nil, hour = nil, min = nil, sec = nil)
      hDuration = build_duration(year: year, mon: mon, day: day, hour: hour, min: min, sec: sec)
      hTimePeriod[:duration] = hDuration
      return hTimePeriod
   end

   def add_email(hContact, email)
      hContact[:electronicMailAddress] = [] unless hContact[:electronicMailAddress]
      hContact[:electronicMailAddress] << email
      return hContact
   end

   def add_falseNE(hProjection, northing = nil, easting = nil)
      hProjection[:falseEasting] = 9.9
      hProjection[:falseNorthing] = 9.9
      hProjection[:falseEasting] = easting unless easting.nil?
      hProjection[:falseNorthing] = northing unless northing.nil?
      return hProjection
   end

   def add_foreignKey(hEntity, aLocalAtt = nil, refEnt = nil, aRefAtt = nil)
      hFKey = foreignKey
      hFKey[:localAttributeCodeName] = aLocalAtt unless aLocalAtt.nil?
      hFKey[:referencedEntityCodeName] = refEnt unless refEnt.nil?
      hFKey[:referencedAttributeCodeName] = aRefAtt unless aRefAtt.nil?
      hEntity[:foreignKey] << hFKey
      return hEntity
   end

   def add_geodetic(hSpaceRef, datum = nil, ellipse = nil)
      hGeodetic = geodetic
      hGeodetic[:datumName] = datum unless datum.nil?
      hGeodetic[:ellipseName] = ellipse unless ellipse.nil?
      hSpaceRef[:referenceSystemParameterSet] = {}
      hSpaceRef[:referenceSystemParameterSet][:geodetic] = hGeodetic
      return hSpaceRef
   end

   def add_geographicExtent(hExtent)
      hGeoExt = geographicExtent
      hExtent[:geographicExtent] << hGeoExt
      return hExtent
   end

   def add_grid(hProjection, grid, zone = nil, name = nil, description = nil)
      hGridId = {}
      hGridId[:identifier] = grid
      hGridId[:name] = name unless name.nil?
      hGridId[:description] = description unless description.nil?
      hProjection[:gridIdentifier] = hGridId
      hProjection[:gridZone] = zone unless zone.nil?
      return hProjection
   end

   def add_heightPP(hProjection, height = nil)
      hProjection[:heightOfProspectivePointAboveSurface] = 99.9
      hProjection[:heightOfProspectivePointAboveSurface] = height unless height.nil?
      return hProjection
   end
   
   def add_imageDescription(hCoverage)
      hCoverage[:imageDescription] = imageDescription
      return hCoverage
   end
   
   def add_keyword(hKeywords, keyword, id = nil)
      hKeyword = {}
      hKeyword[:keyword] = keyword
      hKeyword[:keywordId] = id
      hKeyword.delete(:keywordId) if hKeyword[:keywordId].nil?
      hKeywords[:keyword] << hKeyword
      return hKeywords
   end

   def add_landsat(hProjection, number = nil)
      hProjection[:landsatNumber] = 9
      hProjection[:landsatNumber] = number unless number.nil?
      return hProjection
   end

   def add_landsatPath(hProjection, number = nil)
      hProjection[:landsatPath] = 9999
      hProjection[:landsatPath] = number unless number.nil?
      return hProjection
   end

   def add_latPC(hProjection, latPC = nil)
      hProjection[:latitudeOfProjectionCenter] = 99.9
      hProjection[:latitudeOfProjectionCenter] = latPC unless latPC.nil?
      return hProjection
   end

   def add_latPO(hProjection, latPO = nil)
      hProjection[:latitudeOfProjectionOrigin] = 99.9
      hProjection[:latitudeOfProjectionOrigin] = latPO unless latPO.nil?
      return hProjection
   end

   def add_localPlanar(hProjection)
      hProjection[:local] = local
      hProjection[:local][:fixedToEarth] = true
      return hProjection
   end

   def add_localSystem(hProjection)
      hProjection[:local] = local
      hProjection[:local][:fixedToEarth] = false
      return hProjection
   end

   def add_longCM(hProjection, longCM = nil)
      hProjection[:longitudeOfCentralMeridian] = 99.9
      hProjection[:longitudeOfCentralMeridian] = longCM unless longCM.nil?
      return hProjection
   end

   def add_longPC(hProjection, longPC = nil)
      hProjection[:longitudeOfProjectionCenter] = 99.9
      hProjection[:longitudeOfProjectionCenter] = longPC  unless longPC.nil?
      return hProjection
   end

   def add_obliqueLineAzimuth(hProjection, angle = nil, longitude = nil)
      hProjection[:azimuthAngle] = 99.9
      hProjection[:azimuthMeasurePointLongitude] = 99.9
      hProjection[:azimuthAngle] = angle unless angle.nil?
      hProjection[:azimuthMeasurePointLongitude] = longitude unless longitude.nil?
      return hProjection
   end

   def add_obliqueLinePoint(hProjection, latitude = nil, longitude = nil)
      hLinePoint = obliqueLinePoint
      hLinePoint[:obliqueLineLatitude] = latitude unless latitude.nil?
      hLinePoint[:obliqueLineLongitude] = longitude unless longitude.nil?
      hProjection[:obliqueLinePoint] = [] unless hProjection[:obliqueLinePoint]
      hProjection[:obliqueLinePoint] << hLinePoint
      return hProjection
   end

   def add_offlineOption(hTranOpt, reqOnly = false)
      hMedium = medium
      if reqOnly
         hMedium.delete(:mediumSpecification)
         hMedium.delete(:density)
         hMedium.delete(:units)
         hMedium.delete(:numberOfVolumes)
         hMedium.delete(:mediumFormat)
         hMedium.delete(:identifier)
      end
      hTranOpt[:offlineOption] << hMedium
      return hTranOpt
   end

   def add_onlineOption(hTranOpt, uri, reqOnly = false)
      hOnlineRes = build_onlineResource(uri)
      if reqOnly
         hOnlineRes.delete(:name)
         hOnlineRes.delete(:description)
         hOnlineRes.delete(:function)
         hOnlineRes.delete(:applicationProfile)
         hOnlineRes.delete(:protocol)
         hOnlineRes.delete(:protocolRequest)
      end
      hTranOpt[:onlineOption] << hOnlineRes
      return hTranOpt
   end

   def add_orderProcess(hDistributor)
      hDistributor[:orderProcess] << orderProcess
      return hDistributor
   end

   def add_otherGrid(hProjection, description = nil)
      if description.nil?
         hProjection[:gridIdentifier][:description] = 'Other Grid Coordinate System Description'
      else
         hProjection[:gridIdentifier][:description] = description
      end
      return hProjection
   end

   def add_otherProjection(hProjection, description = nil)
      if description.nil?
         hProjection[:projectionIdentifier][:description] = 'Other Projection Description'
      else
         hProjection[:projectionIdentifier][:description] = description
      end
      return hProjection
   end

   def add_phone(hContact, phoneNumber, aService)
      hPhone = phone
      hPhone[:phoneNumber] = phoneNumber
      hPhone[:service] = aService
      hContact[:phone] << hPhone
      return hContact
   end

   def add_properties(hFeature)
      hFeature[:properties] = properties
      return hFeature
   end

   def add_releasability(hCon)
      hRelease = releasability
      hCon[:releasability] = hRelease
      return hCon
   end

   def add_resourceFormat(hTransOpt, title = nil, prereq = nil)
      hFormat = resourceFormat
      hFormat[:formatSpecification][:title] = title unless title.nil?
      hFormat[:technicalPrerequisite] = prereq unless prereq.nil?
      hTransOpt[:distributionFormat] << hFormat
      return hTransOpt
   end

   def add_scaleFactorCL(hProjection, scale = nil)
      hProjection[:scaleFactorAtCenterLine] = 9.99
      hProjection[:scaleFactorAtCenterLine] = scale unless scale.nil?
      return hProjection
   end

   def add_scaleFactorCM(hProjection, factor = nil)
      hProjection[:scaleFactorAtCentralMeridian] = 9.99
      hProjection[:scaleFactorAtCentralMeridian] = factor unless factor.nil?
      return hProjection
   end

   def add_scaleFactorE(hProjection, factor = nil)
      hProjection[:scaleFactorAtEquator] = 9.99
      hProjection[:scaleFactorAtEquator] = factor unless factor.nil?
      return hProjection
   end

   def add_scaleFactorPO(hProjection, factor = nil)
      hProjection[:scaleFactorAtProjectionOrigin] = 9.99
      hProjection[:scaleFactorAtProjectionOrigin] = factor unless factor.nil?
      return hProjection
   end

   def add_series(hCitation, name = nil, issue = nil, page = nil)
      hSeries = series
      hSeries[:seriesName] = name unless name.nil?
      hSeries[:seriesIssue] = issue unless issue.nil?
      hSeries[:issuePage] = page unless page.nil?
      hCitation[:series] = hSeries
      return hCitation
   end

   def add_standardParallel(hProjection, num = 1, parallel1 = nil, parallel2 = nil)
      hProjection[:standardParallel1] = 99.9
      hProjection[:standardParallel1] = parallel1 unless parallel1.nil?
      if num == 2
         hProjection[:standardParallel2] = 99.9
         hProjection[:standardParallel2] = parallel2 unless parallel2.nil?
      end
      return hProjection
   end

   def add_straightFromPole(hProjection, longitude = nil)
      hProjection[:straightVerticalLongitudeFromPole] = 99.9
      hProjection[:straightVerticalLongitudeFromPole] = longitude unless longitude.nil?
      return hProjection
   end

   def add_taxonClass(hObject, level = nil, name = nil, aCommon = nil, id = nil)
      hTaxClass = taxonClass
      hTaxClass[:taxonomicSystemId] = id unless id.nil?
      hTaxClass[:taxonomicLevel] = level unless level.nil?
      hTaxClass[:taxonomicName] = name unless name.nil?
      hTaxClass[:commonName] = aCommon unless aCommon.nil?
      hObject[:subClassification] << hTaxClass
      return hObject
   end

   def add_temporalExtent(hExtent, id, type, dateTime = nil)
      if type == 'instant'
         hTempTime = build_timeInstant(id,nil, dateTime)
         hExtent[:temporalExtent] << {timeInstant: hTempTime}
      end
      if type == 'period'
         hTempTime = build_timePeriod(id,nil, dateTime)
         hExtent[:temporalExtent] << {timePeriod: hTempTime}
      end
      return hExtent
   end

   def add_timeInterval(hTimePeriod, interval = nil, units = nil)
      hInterval = timeInterval
      hInterval[:interval] = interval unless interval.nil?
      hInterval[:units] = units unless units.nil?
      hTimePeriod[:timeInterval] = hInterval
      return hTimePeriod
   end

   def add_useLimitation(hConstraint, limitation)
      hConstraint[:useLimitation] << limitation
      return hConstraint
   end

   def add_valueRange(hAttribute, min, max)
      hRange = valueRange
      hRange[:minRangeValue] = min.to_s
      hRange[:maxRangeValue] = max.to_s
      hAttribute[:valueRange] << hRange
      return hAttribute
   end

   def add_vectorObject(hVecRep, type, count = nil)
      hVecObj = {}
      hVecObj[:objectType] = type
      hVecObj[:objectCount] = count unless count.nil?
      hVecRep[:vectorObject] << hVecObj
      return hVecRep
   end

   def add_verticalDatum(hSpaceRef, isDepth = true)
      hSpaceRef[:referenceSystemParameterSet] = {}
      hSpaceRef[:referenceSystemParameterSet][:verticalDatum] = verticalDatum
      hDatum = hSpaceRef[:referenceSystemParameterSet][:verticalDatum]
      hDatum[:isDepthSystem] = isDepth
      if isDepth
         hDatum[:datumIdentifier][:identifier] = 'depth datum name'
      else
         hDatum[:datumIdentifier][:identifier] = 'altitude datum name'
      end
      return hSpaceRef
   end

   def add_verticalExtent(hExtent, description = nil, min = nil, max = nil)
      hVertExt = verticalExtent
      hVertExt[:description] = description unless description.nil?
      hVertExt[:minValue] = min unless min.nil?
      hVertExt[:maxValue] = max unless max.nil?
      hExtent[:verticalExtent] << hVertExt
      return hExtent
   end

   # ---------------------------------------------------------------------------------

   def removeEmptyObjects(obj)
      if obj.kind_of?(Hash)
         obj.each_pair do |key, value|
            if value.kind_of?(Array)
               if value.empty?
                  obj.delete(key)
               else
                  removeEmptyObjects(value)
               end
            end
            if value.kind_of?(Hash)
               if value.empty?
                  obj.delete(key)
               else
                  removeEmptyObjects(value)
               end
            end
         end
      end
      if obj.kind_of?(Array)
         obj.each_with_index do |item, index|
            if item.kind_of?(Array)
               if item.empty?
                  obj.delete_at(index)
               else
                  removeEmptyObjects(item)
               end
            end
            if item.kind_of?(Hash)
               if item.empty?
                  obj.delete_at(index)
               else
                  removeEmptyObjects(item)
               end
            end
         end
      end
      return obj
   end

   def useContactAddress(obj)
      if obj.kind_of?(Hash)
         obj.each_pair do |key, value|
            if key == 'contactId'.to_sym
               obj[:contactId] = 'CID001' if value == 'CID003'
               obj[:contactId] = 'CID002' if value == 'CID004'
            end
            if value.kind_of?(Array)
               if value.empty?
                  obj.delete(key)
               else
                  useContactAddress(value)
               end
            end
            if value.kind_of?(Hash)
               if value.empty?
                  obj.delete(key)
               else
                  useContactAddress(value)
               end
            end
         end
      end
      if obj.kind_of?(Array)
         obj.each_with_index do |item, index|
            if item.kind_of?(Array)
               if item.empty?
                  obj.delete_at(index)
               else
                  useContactAddress(item)
               end
            end
            if item.kind_of?(Hash)
               if item.empty?
                  obj.delete_at(index)
               else
                  useContactAddress(item)
               end
            end
         end
      end
      return obj
   end

end
