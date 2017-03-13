# mdJson 2.0 writer - metadataInfo

# History:
#   Stan Smith 2017-03-11 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

# TODO complete

require 'jbuilder'
require_relative 'mdJson_responsibleParty'
# require_relative 'mdJson_citation'
# require_relative 'mdJson_resourceIdentifier'
# require_relative 'mdJson_locale'
# require_relative 'mdJson_resourceMaintenance'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module MetadataInfo

               def self.build(hMetaInfo)

                  Jbuilder.new do |json|
                     json.metadataIdentifier Identifier.build(hMetaInfo[:metadataIdentifier]) unless hMetaInfo[:metadataIdentifier].empty?
                     # json.parentMetadata Citation.build(hMetaInfo[:parentMetadata])
                     json.metadataContact hMetaInfo[:metadataContacts].map { |obj| ResponsibleParty.build(obj).attributes! }
                     # json.metadataCharacterSet hMetaInfo[:metadataCharacterSet]
                     # json.metadataLocales json_map(hMetaInfo[:metadataLocales], Locale)
                     # json.metadataCreationDate hMetaInfo[:metadataCreateDate][:dateTime]
                     # json.metadataLastUpdate hMetaInfo[:metadataUpdateDate][:dateTime]
                     # json.metadataUri hMetaInfo[:metadataURI]
                     # json.metadataStatus hMetaInfo[:metadataStatus]
                     # json.metadataMaintenance ResourceMaintenance.build( hMetaInfo[:maintInfo])
                  end

               end # build
            end # MetadataInfo

         end
      end
   end
end
