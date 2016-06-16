require 'jbuilder'
require_relative 'mdJson_base'
require_relative 'mdJson_citation'
require_relative 'mdJson_resourceIdentifier'
require_relative 'mdJson_responsibleParty'
require_relative 'mdJson_locale'
require_relative 'mdJson_resourceMaintenance'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson
        module MetadataInfo
          extend MdJson::Base

          def self.build(_info)
            Jbuilder.new do |json|
              unless _info[:metadataId].nil?
                json.metadataIdentifier ResourceIdentifier.build(_info[:metadataId])
                json.parentMetadata Citation.build(_info[:parentMetadata])
                json.metadataContact json_map(_info[:metadataCustodians], ResponsibleParty)
                json.metadataCharacterSet _info[:metadataCharacterSet]
                json.metadataLocales json_map(_info[:metadataLocales], Locale)
                json.metadataCreationDate _info[:metadataCreateDate][:dateTime]
                json.metadataLastUpdate _info[:metadataUpdateDate][:dateTime]
                json.metadataUri _info[:metadataURI]
                json.metadataStatus _info[:metadataStatus]
                json.metadataMaintenance ResourceMaintenance.build( _info[:maintInfo])
              end
            end
          end
        end
      end
    end
  end
end
