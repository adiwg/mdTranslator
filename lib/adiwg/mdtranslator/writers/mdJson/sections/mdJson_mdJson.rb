# mdJson 2.0 writer - mdJson

# History:
#   Stan Smith 2017-03-10 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'jbuilder'
require 'rubygems'
require_relative 'mdJson_contact'
require_relative 'mdJson_metadata'
require_relative 'mdJson_dictionary'
require_relative 'mdJson_repository'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module MdJson

               def self.build(intObj, hResponseObj)

                  Jbuilder.new do |json|

                     # mdJson - schema (required)
                     json.schema do
                        json.name 'mdJson'
                        json.version hResponseObj[:writerVersion]
                     end

                     # mdJson - contacts [] (required)
                     json.contact intObj[:contacts].map { |obj| Contact.build(obj).attributes! }

                     # mdJson - metadata (required)
                     json.metadata Metadata.build(intObj[:metadata])

                     # mdJson - metadataRepositories []
                     unless intObj[:metadataRepositories].empty?
                        json.metadataRepository intObj[:metadataRepositories].map { |obj| Repository.build(obj).attributes! }
                     end

                     # mdJson - dataDictionaries []
                     unless intObj[:dataDictionaries].empty?
                        json.dataDictionary intObj[:dataDictionaries].map { |obj| Dictionary.build(obj).attributes! }
                     end

                  end

               end # build
            end # MdJson

         end
      end
   end
end
