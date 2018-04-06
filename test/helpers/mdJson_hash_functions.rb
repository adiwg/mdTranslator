
require 'adiwg/mdtranslator/internal/module_dateTimeFun'

class MdJsonHashWriter

   def build_associatedResource(associationType, title = nil)
      hAssocRes = associatedResource
      hAssocRes[:associationType] = associationType
      unless title.nil?
         hAssocRes[:resourceCitation][:title] = title
      end
      return hAssocRes
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

   def build_dataDictionary
      hDictionary = dataDictionary
      return hDictionary
   end

   def build_date(dateTime, type)
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

   def build_entity(id = nil, common = nil, code = nil, definition = nil)
      hEntity = entity
      hEntity[:entityId] = id unless id.nil?
      hEntity[:commonName] = common unless common.nil?
      hEntity[:codeName] = code unless code.nil?
      hEntity[:definition] = definition unless definition.nil?
      return hEntity
   end

   def build_entityAttribute(common = nil, code = nil, definition = nil)
      hAttribute = entityAttribute
      hAttribute[:commonName] = common unless common.nil?
      hAttribute[:codeName] = code unless code.nil?
      hAttribute[:definition] = definition unless definition.nil?
      return hAttribute
   end

   def build_feature(id, geometry, description = nil)
      hFeature = feature
      hFeature[:id] = id
      if geometry == 'polygon'
         hFeature[:geometry] = polygon
      end
      unless description.nil?
         hFeature[:properties][:description] = description
      end
      return hFeature
   end

   def build_geologicAge
      hGeologicAge = geologicAge
      return hGeologicAge
   end

   def build_graphic(name, description = nil, type = nil)
      hGraphic = graphic
      hGraphic[:fileName] = name
      unless description.nil?
         hGraphic[:fileDescription] = description
      end
      unless type.nil?
         hGraphic[:fileType] = type
      end
      return hGraphic
   end

   def build_geographicResolution
      hResolution = {}
      hResolution[:geographicResolution] = geographicResolution
      return hResolution
   end

   def build_gridRepresentation(dimensions, geometry)
      hGrid = gridRepresentation
      hGrid[:numberOfDimensions] = dimensions
      hGrid[:cellGeometry] = geometry
      return hGrid
   end

   def build_identifier(id, namespace = nil, version = nil, description = nil)
      hIdentifier = identifier
      hIdentifier[:identifier] = id
      unless namespace.nil?
         hIdentifier[:namespace] = namespace
      end
      unless version.nil?
         hIdentifier[:version] = version
      end
      unless description.nil?
         hIdentifier[:description] = description
      end
      return hIdentifier
   end

   def build_keywords(title, theme)
      hKeywords = keywords
      hKeywords[:keywordType] = theme
      hKeywords[:thesaurus][:title] = title
      return hKeywords
   end

   def build_legalConstraint
      hCon = constraint
      hCon[:type] = 'legal'
      hCon[:legal] = {
         accessConstraint: [],
         useConstraint: [],
         otherConstraint: []
      }
      return hCon
   end

   def build_locale(language = nil, character = nil, country = nil)
      hLocale = locale
      hLocale[:language] = language unless language.nil?
      hLocale[:characterSet] = character unless character.nil?
      hLocale[:country] = country
      return hLocale
   end

   def build_onlineResource(uri)
      hResource = onlineResource
      hResource[:uri] = uri
      return hResource
   end

   def build_organization(contactId, name)
      hContact = organization
      hContact[:contactId] = contactId
      hContact[:name] = name
      add_address(hContact, ['physical'])
      add_phone(hContact, '111-111-1111', ['voice'])
      return hContact
   end

   def build_person(contactId, name)
      hContact = person
      hContact[:contactId] = contactId
      hContact[:name] = name
      add_address(hContact, ['mailing'])
      add_phone(hContact, '111-111-1111', ['voice'])
      return hContact
   end

   def build_processStep(id, description = nil, hTimePeriod = nil)
      hStep = processStep
      hStep[:stepId] = id
      unless description.nil?
         hStep[:description] = description
      end
      unless hTimePeriod.nil?
         hStep[:timePeriod] = hTimePeriod
      end
      return hStep
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

   def build_securityConstraint(classification, system = nil, handling = nil, note = nil)
      hCon = constraint
      hCon[:type] = 'security'
      hCon[:security] = {
         classification: classification
      }
      unless system.nil?
         hCon[:security][:classificationSystem] = system
      end
      unless handling.nil?
         hCon[:security][:handlingDescription] = handling
      end
      unless note.nil?
         hCon[:security][:userNote] = note
      end
      return hCon
   end

   def build_source(id, description = nil, resolution = nil, hScope = nil)
      hSource = source
      hSource[:sourceId] = id
      hSource[:sourceCitation] =  citation
      unless description.nil?
         hSource[:description] = description
      end
      unless resolution.nil?
         hResolution = {}
         hResolution[:scaleFactor] = resolution
         hSource[:spatialResolution] = hResolution
      end
      unless hScope.nil?
         hSource[:scope] = hScope
      end
      return hSource
   end

   def build_spatialReference(type = nil, hIdentifier = nil, hParameters = nil)
      hSpatialRef = spatialReference
      if type.nil?
         hSpatialRef.delete(:referenceSystemType)
      else
         hSpatialRef[:referenceSystemType] = type
      end
      if hIdentifier.nil?
         hSpatialRef.delete(:referenceSystemIdentifier)
      else
         hSpatialRef[:referenceSystemIdentifier] = hIdentifier
      end
      if hParameters.nil?
         hSpatialRef.delete(:systemParameterSet)
      else
         hSpatialRef[:systemParameterSet] = hParameters
      end
      return hSpatialRef
   end

   def build_spatialRepresentation(type, hObj)
      hSpaceRep = {}
      if type == 'grid'
         hSpaceRep[:gridRepresentation] = hObj
      end
      if type == 'vector'
         hSpaceRep[:vectorRepresentation] = hObj
      end
      return hSpaceRep
   end

   def build_taxonSystem(title, contactId, modifications = nil)
      hTaxSystem = taxonSystem
      hTaxSystem[:citation][:title] = title
      hTaxSystem[:citation][:responsibleParty][0][:party][0][:contactId] = contactId
      unless modifications.nil?
         hTaxSystem[:modifications] = modifications
      end
      return hTaxSystem
   end

   def build_taxonVoucher(specimen, aContacts)
      hVoucher = taxonVoucher
      hVoucher[:specimen] = specimen
      hVoucher[:repository] = build_responsibleParty('custodian', aContacts)
      return hVoucher
   end

   def build_timePeriod(id, description = nil, startDT = nil, endDT = nil)
      hTimePeriod = timePeriod
      hTimePeriod[:id] = id
      unless description.nil?
         hTimePeriod[:description] = description
      end
      unless startDT.nil?
         hTimePeriod[:startDateTime] = startDT
      end
      unless endDT.nil?
         hTimePeriod[:endDateTime] = endDT
      end
      return hTimePeriod
   end

   def build_transferOption
      return transferOption
   end

   def build_vectorRepresentation(level = nil)
      hVector = vectorRepresentation
      if level.nil?
         hVector.delete(:topologyLevel)
      else
         hVector[:topologyLevel] = level
      end
      return hVector
   end

   # ---------------------------------------------------------------------------------

   def add_accessConstraint(hObj, constraint)
      hObj[:legal][:accessConstraint] << constraint
      return hObj
   end

   def add_address(hContact, aAddType)
      hAddress = address
      hAddress[:addressType] = aAddType
      hContact[:address] << hAddress
      return hContact
   end

   def add_altitudeBB(hBbox)
      hBbox[:minimumAltitude] = 250.0
      hBbox[:maximumAltitude] = 1500.0
      hBbox[:unitsOfAltitude] = 'meters'
      return hBbox
   end

   def add_dataIndex(hEntity, code = nil, duplicate = false, attCode = nil)
      hIndex = index
      hIndex[:codeName] = code unless code.nil?
      hIndex[:allowDuplicates] = duplicate
      if attCode.nil?
         hIndex[:attributeCodeName] = []
      else
         hIndex[:attributeCodeName] = attCode
      end
      hEntity[:index] << hIndex
      return hEntity
   end

   def add_dimension(hObj, type, size, title = nil, description = nil)
      hDimension = dimension
      hDimension[:dimensionType] = type
      hDimension[:dimensionSize] = size
      hDimension.delete(:resolution)
      if title.nil?
         hDimension.delete(:dimensionTitle)
      else
         hDimension[:dimensionTitle] = title
      end
      if description.nil?
         hDimension.delete(:dimensionDescription)
      else
         hDimension[:dimensionDescription] = description
      end
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

   def add_email(hContact, email)
      hContact[:electronicMailAddress] = [] unless hContact[:electronicMailAddress]
      hContact[:electronicMailAddress] << email
      return hContact
   end

   def add_falseNE(hSpaceRef, northing = nil, easting = nil)
      hParamSet = hSpaceRef[:referenceSystemParameterSet][:projection]
      hParamSet[:falseEasting] = 9.9
      hParamSet[:falseNorthing] = 9.9
      unless easting.nil?
         hParamSet[:falseEasting] = easting
      end
      unless northing.nil?
         hParamSet[:falseNorthing] = northing
      end
      return hSpaceRef
   end

   def add_featureCollection(hGeoElement)
      hGeoElement << featureCollection
      return hGeoElement
   end

   def add_foreignKey(hEntity, localAtt = nil, refEnt = false, refAtt = nil)
      hFKey = foreignKey
      hFKey[:localAttributeCodeName] = localAtt unless localAtt.nil?
      hFKey[:referencedEntityCodeName] = refEnt unless refEnt.nil?
      hFKey[:referencedAttributeCodeName] = refAtt unless refAtt.nil?
      hEntity[:foreignKey] << hFKey
      return hEntity
   end

   def add_geodetic(hSpaceRef, datum = nil, ellipse = nil)
      hSpaceRef[:referenceSystemParameterSet] = {}
      hSpaceRef[:referenceSystemParameterSet][:geodetic] = geodetic
      hGeodetic = hSpaceRef[:referenceSystemParameterSet][:geodetic]
      hGeodetic[:datumIdentifier][:identifier] = 'identifier'
      hGeodetic[:ellipsoidIdentifier][:identifier] = 'identifier'
      hGeodetic[:datumName] = datum unless datum.nil?
      hGeodetic[:ellipseName] = ellipse unless ellipse.nil?
      return hSpaceRef
   end

   def add_grid(hSpaceRef, grid, name = nil, zone = nil)
      hParamSet = hSpaceRef[:referenceSystemParameterSet][:projection]
      hParamSet[:gridSystem] = grid
      hParamSet[:gridSystemName] = name unless name.nil?
      hParamSet[:gridZone] = zone  unless zone.nil?
      return hSpaceRef
   end

   def add_heightPP(hSpaceRef, height = nil)
      hParamSet = hSpaceRef[:referenceSystemParameterSet][:projection]
      hParamSet[:heightOfProspectivePointAboveSurface] = 99.9
      unless height.nil?
         hParamSet[:heightOfProspectivePointAboveSurface] = height
      end
      return hSpaceRef
   end
   
   def add_keyword(hKeywords, keyword, id = nil)
      hKeyword = {}
      hKeyword[:keyword] = keyword
      unless id.nil?
         hKeyword[:keywordId] = id
      end
      hKeywords[:keyword] << hKeyword
      return hKeywords
   end

   def add_landsat(hSpaceRef, number = nil)
      hParamSet = hSpaceRef[:referenceSystemParameterSet][:projection]
      hParamSet[:landsatNumber] = 9
      hParamSet[:landsatNumber] = number unless number.nil?
      return hSpaceRef
   end

   def add_landsatPath(hSpaceRef, number = nil)
      hParamSet = hSpaceRef[:referenceSystemParameterSet][:projection]
      hParamSet[:landsatPath] = 9999
      hParamSet[:landsatPath] = number unless number.nil?
      return hSpaceRef
   end

   def add_latPC(hSpaceRef, latPC = nil)
      hParamSet = hSpaceRef[:referenceSystemParameterSet][:projection]
      hParamSet[:latitudeOfProjectionCenter] = 99.9
      unless latPC.nil?
         hParamSet[:latitudeOfProjectionCenter] = latPC
      end
      return hSpaceRef
   end

   def add_latPO(hSpaceRef, latPO = nil)
      hParamSet = hSpaceRef[:referenceSystemParameterSet][:projection]
      hParamSet[:latitudeOfProjectionOrigin] = 99.9
      unless latPO.nil?
         hParamSet[:latitudeOfProjectionOrigin] = latPO
      end
      return hSpaceRef
   end

   def add_localDesc(hSpaceRef, description = nil)
      hParamSet = hSpaceRef[:referenceSystemParameterSet][:projection]
      hParamSet[:localPlanarDescription] = 'local planar description'
      hParamSet[:localPlanarDescription] = description unless description.nil?
      return hSpaceRef
   end

   def add_localGeoInfo(hSpaceRef, geoRef = nil)
      hParamSet = hSpaceRef[:referenceSystemParameterSet][:projection]
      hParamSet[:localPlanarGeoreference] = 'local planar georeference information'
      hParamSet[:localPlanarGeoreference] = geoRef unless geoRef.nil?
      return hSpaceRef
   end

   def add_longCM(hSpaceRef, longCM = nil)
      hParamSet = hSpaceRef[:referenceSystemParameterSet][:projection]
      hParamSet[:longitudeOfCentralMeridian] = 99.9
      unless longCM.nil?
         hParamSet[:longitudeOfCentralMeridian] = longCM
      end
      return hSpaceRef
   end

   def add_longPC(hSpaceRef, longPC = nil)
      hParamSet = hSpaceRef[:referenceSystemParameterSet][:projection]
      hParamSet[:longitudeOfProjectionCenter] = 99.9
      unless longPC.nil?
         hParamSet[:longitudeOfProjectionCenter] = longPC
      end
      return hSpaceRef
   end

   def add_obliqueLineAzimuth(hSpaceRef, angle = nil, longitude = nil)
      hParamSet = hSpaceRef[:referenceSystemParameterSet][:projection]
      hParamSet[:azimuthAngle] = 99.9
      hParamSet[:azimuthMeasurePointLongitude] = 99.9
      hParamSet[:azimuthAngle] = angle unless angle.nil?
      hParamSet[:azimuthMeasurePointLongitude] = longitude unless longitude.nil?
      return hSpaceRef
   end

   def add_obliqueLinePoint(hSpaceRef, latitude = nil, longitude = nil)
      hParamSet = hSpaceRef[:referenceSystemParameterSet][:projection]
      hLinePoint = obliqueLinePoint
      hLinePoint[:azimuthLineLatitude] = latitude unless latitude.nil?
      hLinePoint[:azimuthLineLongitude] = longitude unless longitude.nil?
      hParamSet[:obliqueLinePoint] = [] unless hParamSet[:obliqueLinePoint]
      hParamSet[:obliqueLinePoint] << hLinePoint
      return hSpaceRef
   end

   def add_offlineOption(hTranOpt, noteOnly = false)
      hMedium = medium
      if noteOnly
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

   def add_onlineOption(hTranOpt, uri)
      hOnlineRes = build_onlineResource(uri)
      hTranOpt[:onlineOption] << hOnlineRes
      return hTranOpt
   end

   def add_orderProcess(hDistributor)
      hDistributor[:orderProcess] << orderProcess
      return hDistributor
   end

   def add_otherConstraint(hObj, constraint)
      hObj[:legal][:otherConstraint] << constraint
      return hObj
   end

   def add_otherProjection(hSpaceRef, other = nil)
      hParamSet = hSpaceRef[:referenceSystemParameterSet][:projection]
      hParamSet[:otherProjectionDescription] = 'other projection description'
      hParamSet[:otherProjectionDescription] = other unless other.nil?
      return hSpaceRef
   end

   def add_phone(hContact, phoneNumber, aService)
      hPhone = phone
      hPhone[:phoneNumber] = phoneNumber
      hPhone[:service] = aService
      hContact[:phone] << hPhone
      return hContact
   end

   def add_projection(hSpaceRef, projection, name = nil)
      hSpaceRef[:referenceSystemParameterSet] = {}
      hSpaceRef[:referenceSystemParameterSet][:projection] = {}
      hParamSet = hSpaceRef[:referenceSystemParameterSet][:projection]
      hParamSet[:projection] = projection
      unless name.nil?
         hParamSet[:projectionName] = name
      end
      return hSpaceRef
   end

   def add_resourceFormat(hTransOpt, title = nil, prereq = nil)
      hFormat = resourceFormat
      hFormat[:formatSpecification][:title] = title unless title.nil?
      hFormat[:technicalPrerequisite] = prereq unless prereq.nil?
      hTransOpt[:distributionFormat] << hFormat
      return hTransOpt
   end

   def add_scaleFactorCL(hSpaceRef, scale = nil)
      hParamSet = hSpaceRef[:referenceSystemParameterSet][:projection]
      hParamSet[:scaleFactorAtCenterLine] = 9.99
      hParamSet[:scaleFactorAtCenterLine] = scale unless scale.nil?
      return hSpaceRef
   end

   def add_scaleFactorCM(hSpaceRef, scale = nil)
      hParamSet = hSpaceRef[:referenceSystemParameterSet][:projection]
      hParamSet[:scaleFactorAtCentralMeridian] = 9.99
      hParamSet[:scaleFactorAtCentralMeridian] = scale unless scale.nil?
      return hSpaceRef
   end

   def add_scaleFactorE(hSpaceRef, scale = nil)
      hParamSet = hSpaceRef[:referenceSystemParameterSet][:projection]
      hParamSet[:scaleFactorAtEquator] = 9.99
      hParamSet[:scaleFactorAtEquator] = scale unless scale.nil?
      return hSpaceRef
   end

   def add_scaleFactorPO(hSpaceRef, scale = nil)
      hParamSet = hSpaceRef[:referenceSystemParameterSet][:projection]
      hParamSet[:scaleFactorAtProjectionOrigin] = 9.99
      hParamSet[:scaleFactorAtProjectionOrigin] = scale unless scale.nil?
      return hSpaceRef
   end

   def add_standardParallel(hSpaceRef, num = 1, parallel1 = nil, parallel2 = nil)
      hParamSet = hSpaceRef[:referenceSystemParameterSet][:projection]
      hParamSet[:standardParallel1] = 99.9
      unless parallel1.nil?
         hParamSet[:standardParallel1] = parallel1
      end
      if num == 2
         hParamSet[:standardParallel2] = 99.9
         unless parallel2.nil?
            hParamSet[:standardParallel2] = parallel2
         end
      end
      return hSpaceRef
   end

   def add_straightFromPole(hSpaceRef, longitude = nil)
      hParamSet = hSpaceRef[:referenceSystemParameterSet][:projection]
      hParamSet[:straightVerticalLongitudeFromPole] = 99.9
      hParamSet[:straightVerticalLongitudeFromPole] = longitude unless longitude.nil?
      return hSpaceRef
   end

   def add_taxonClass(hObject, rank, name, aCommon = [], id = nil)
      hTaxClass = taxonClass
      unless id.nil?
         hTaxClass[:taxonomicSystemId] = id
      end
      hTaxClass[:taxonomicRank] = rank
      hTaxClass[:latinName] = name
      unless aCommon.empty?
         hTaxClass[:commonName] = aCommon
      end
      hObject[:subClassification] << hTaxClass
      return hObject
   end

   def add_useConstraint(hObj, constraint)
      hObj[:legal][:useConstraint] << constraint
      return hObj
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
      unless count.nil?
         hVecObj[:objectCount] = count
      end
      hVecRep[:vectorObject] << hVecObj
      return hVecRep
   end

   def add_verticalDatum(hSpaceRef, isDepth = true)
      hSpaceRef[:referenceSystemParameterSet] = {}
      hSpaceRef[:referenceSystemParameterSet][:verticalDatum] = verticalDatum
      hDatum = hSpaceRef[:referenceSystemParameterSet][:verticalDatum]
      hDatum[:datumIdentifier][:identifier] = 'identifier'
      hDatum[:isDepthSystem] = isDepth
      if isDepth
         hDatum[:datumName] = 'depth datum name'
      else
         hDatum[:datumName] = 'altitude datum name'
      end
      return hSpaceRef
   end

end
