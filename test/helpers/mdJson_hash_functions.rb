
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

   def build_associatedResource(associationType)
      hAssocRes = associatedResource
      hAssocRes[:associationType] = associationType
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

end
