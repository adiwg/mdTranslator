
require 'adiwg/mdtranslator/internal/module_dateTimeFun'

class FgdcWriterTD

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

   def build_date(dateTime, type)
      hDate = date
      hDate[:date] = dateTime
      hDate[:dateType] = type
      return hDate
   end

   def build_person(contactId, name)
      hContact = person
      hContact[:contactId] = contactId
      hContact[:name] = name
      add_address(hContact, ['mailing'])
      add_phone(hContact, '111-111-1111', ['voice'])
      return hContact
   end

   def build_organization(contactId, name)
      hContact = organization
      hContact[:contactId] = contactId
      hContact[:name] = name
      add_address(hContact, ['physical'])
      add_phone(hContact, '111-111-1111', ['voice'])
      return hContact
   end

   def build_associatedResource(associationType, title = nil)
      hAssocRes = associatedResource
      hAssocRes[:associationType] = associationType
      unless title.nil?
         hAssocRes[:resourceCitation][:title] = title
      end
      return hAssocRes
   end

   def build_onlineResource(uri)
      hResource = onlineResource
      hResource[:uri] = uri
      return hResource
   end

   def build_citation(title, contactId)
      hCitation = citation
      hCitation[:title] = title
      hCitation[:responsibleParty][0][:party][0][:contactId] = contactId
      return hCitation
   end

   def build_geologicAge
      hGeologicAge = geologicAge
      return hGeologicAge
   end

   def build_keywords(title, theme)
      hKeywords = keywords
      hKeywords[:keywordType] = theme
      hKeywords[:thesaurus][:title] = title
      return hKeywords
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

   def build_legalCon
      hCon = constraint
      hCon[:type] = 'legal'
      hCon[:legal] = {
         accessConstraint: [],
         useConstraint: [],
         otherConstraint: []
      }
      return hCon
   end

   def build_securityCon(classification, system = nil, handling = nil, note = nil)
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

   def add_accessConstraint(hObj, constraint)
      hObj[:legal][:accessConstraint] << constraint
      return hObj
   end

   def add_useConstraint(hObj, constraint)
      hObj[:legal][:useConstraint] << constraint
      return hObj
   end

   def add_otherConstraint(hObj, constraint)
      hObj[:legal][:otherConstraint] << constraint
      return hObj
   end

   def add_address(hContact, aAddType)
      hAddress = address
      hAddress[:addressType] = aAddType
      hContact[:address] << hAddress
      return hContact
   end

   def add_phone(hContact, phoneNumber, aService)
      hPhone = phone
      hPhone[:phoneNumber] = phoneNumber
      hPhone[:service] = aService
      hContact[:phone] << hPhone
      return hContact
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

   def add_altitudeBB(hBbox)
      hBbox[:minimumAltitude] = 250.0
      hBbox[:maximumAltitude] = 1500.0
      hBbox[:unitsOfAltitude] = 'meters'
      return hBbox
   end

   def add_featureCollection(hGeoElement)
      hGeoElement << featureCollection
      return hGeoElement
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

end
