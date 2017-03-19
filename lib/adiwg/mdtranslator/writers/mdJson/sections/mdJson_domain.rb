# mdJson 2.0 writer - domain

# History:
#   Stan Smith 2017-03-19 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

# TODO Complete tests

require 'jbuilder'
require_relative 'mdJson_domainItem'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Domain

               @Namespace = ADIWG::Mdtranslator::Writers::MdJson

               def self.build(hDomain)

                  Jbuilder.new do |json|
                     json.domainId hDomain[:domainId]
                     json.commonName hDomain[:domainName]
                     json.codeName hDomain[:domainCode]
                     json.description hDomain[:domainDescription]
                     json.domainItem @Namespace.json_map(hDomain[:domainItems], DomainItem)
                  end

               end # build
            end # Domain

         end
      end
   end
end
