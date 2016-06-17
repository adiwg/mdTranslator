require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_responsibleParty')
require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_dateTime')
# require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_resourceMaintenance')
# require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_metadataExtension')
# require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_resourceIdentifier')
# require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_citation')
# require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_locale')

module ADIWG
  module Mdtranslator
    module Readers
      module SbJson
        module MetadataInfo
          def self.unpack(hMetadata, responseObj, intObj)
            # return nil object if input is empty
            intMetadataInfo = nil
            return if hMetadata.empty?

            # instance classes needed in script
            intMetadataClass = InternalMetadata.new
            intMetadataInfo = intMetadataClass.newMetadataInfo
            hMetadataInfo = hMetadata

            # metadata - metadata identifier
            if hMetadataInfo.key?('id')
              hMetadataId = hMetadataInfo['id']
              unless hMetadataId.empty?
                rId = intMetadataClass.newResourceId
                rId[:identifier] = hMetadataId
                rId[:identifierType] = 'uuid'
                rId[:identifierNamespace] = 'gov.sciencebase.catalog'
                rId[:identifierDescription] = 'The unique ScienceBase id of the resource.'
                intMetadataInfo[:metadataId] = rId
              end
            end

            # metadata - parent metadata identifier
            if hMetadataInfo.key?('parentId')
              hParentId = hMetadataInfo['parentId']
              hParent = intMetadataClass.newCitation
              hParent[:citTitle] = 'Parent Metadata identifier'
              pId = intMetadataClass.newResourceId
              pId[:identifier] = hParentId
              pId[:identifierType] = 'uuid'
              pId[:identifierNamespace] = 'gov.sciencebase.catalog'
              pId[:identifierDescription] = 'The unique ScienceBase id of the parent resource.'
              hParent[:citResourceIds] << pId
              pParty = intMetadataClass.newRespParty
              pParty[:contactId] = 'SB'
              pParty[:roleName] = 'originator'
              hParent[:citResponsibleParty] << pParty

              intMetadataInfo[:parentMetadata] = hParent unless hParent.empty?
            end

            # metadata - metadata contacts, custodians
            # We're just injecting the first sbJSON contact here
            firstCont = intObj[:contacts][0]
            aCust = {}
            aCust['contactId'] = firstCont[:contactId]
            aCust['role'] = firstCont[:sbType]
            intMetadataInfo[:metadataCustodians] << ResponsibleParty.unpack(aCust, responseObj)

            # metadata - creation date
            if hMetadataInfo.key?('provenance')
              s = hMetadataInfo['provenance']['dateCreated']
              if s != ''
                hDateTime = DateTime.unpack(s, responseObj)
                hDateTime[:dateType] = 'creation'
                intMetadataInfo[:metadataCreateDate] = hDateTime
              end
            end

            # metadata - date of last metadata update
            if hMetadataInfo.key?('provenance')
              s = hMetadataInfo['provenance']['lastUpdated']
              if s != ''
                hDateTime = DateTime.unpack(s, responseObj)
                hDateTime[:dateType] = 'lastUpdate'
                intMetadataInfo[:metadataUpdateDate] = hDateTime
              end
            end

            # metadata - characterSet - default 'utf8'
            intMetadataInfo[:metadataCharacterSet] = 'utf8'

            # metadata - locale
            intLocale = intMetadataClass.newLocale
            intLocale[:languageCode] = 'eng'
            intLocale[:countryCode] = 'USA'
            intLocale[:characterEncoding] = 'UTF-8'
            intMetadataInfo[:metadataLocales] << intLocale

            # metadata - metadata URI
            intMetadataInfo[:metadataURI] = 'https://www.sciencebase.gov/catalog/item/' +
                                            hMetadataInfo['id'] unless hMetadataInfo['id'].nil?

            # metadata - status
            # if hMetadataInfo.has_key?('metadataStatus')
            #     s = hMetadataInfo['metadataStatus']
            #     if s != ''
            #         intMetadataInfo[:metadataStatus] = s
            #     end
            # end

            # metadata - metadata maintenance info
            intResMaint = intMetadataClass.newResourceMaint

            # resource maintenance - frequency code
            intResMaint[:maintFreq] = 'asNeeded'

            # resource maintenance - contact
            intResMaint[:maintContacts] << intMetadataInfo[:metadataCustodians][0]

            intMetadataInfo[:maintInfo] = intResMaint

            intMetadataInfo
          end
        end
      end
    end
  end
end
