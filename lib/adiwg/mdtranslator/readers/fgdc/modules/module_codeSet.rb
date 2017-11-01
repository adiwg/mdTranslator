# Reader - fgdc to internal data structure
# unpack fgdc entity codeSet domain

# History:
#  Stan Smith 2017-10-31 original script

require 'uuidtools'
require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module CodeSet

               def self.unpack(axDomains, code, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  aDomains = []

                  axCodeSets = axDomains.xpath('./codesetd')
                  unless axCodeSets.empty?
                     axCodeSets.each do |xCodeSet|

                        hDomain = intMetadataClass.newDictionaryDomain
                        hDomain[:domainId] = UUIDTools::UUID.random_create.to_s
                        hDomain[:domainCode] = code
                        hDomain[:domainDescription] = 'FGDC codeSet domain'


                        # entity attribute 5.1.2.4.3.1 (codesetn) - codeset name
                        # -> dataDictionary.domains.commonName
                        name = xCodeSet.xpath('./codesetn').text
                        unless name.empty?
                           hDomain[:domainName] = name
                        end

                        # entity attribute 5.1.2.4.3.2 (codesets) - codeset source {citation}
                        # -> dataDictionary.domains.domainReference.title
                        hCitation = intMetadataClass.newCitation
                        title = xCodeSet.xpath('./codesets').text
                        unless title.empty?
                           hCitation[:title] = title
                           hDomain[:domainReference] = hCitation
                        end

                        aDomains << hDomain

                     end

                  end

                  return aDomains

               end

            end

         end
      end
   end
end
