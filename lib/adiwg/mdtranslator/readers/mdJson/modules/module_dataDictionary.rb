# unpack a data dictionary
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-18 refactored error and warning messaging
#  Stan Smith 2018-01-25 rename dictionaryFormat to dictionaryFunctionalLanguage
#  Stan Smith 2017-11-09 add dictionary description
#  Stan Smith 2017-01-20 refactored for mdJson/mdTranslator 2.0
#  Stan Smith 2015-07-14 refactored to remove global namespace constants
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#  Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
# 	Stan Smith 2014-12-01 original script

require_relative 'module_citation'
require_relative 'module_domain'
require_relative 'module_entity'
require_relative 'module_locale'
require_relative 'module_responsibleParty'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module DataDictionary

               def self.unpack(hDictionary, responseObj)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hDictionary.empty?
                     @MessagePath.issueWarning(140, responseObj)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intDictionary = intMetadataClass.newDataDictionary

                  # dictionary - description
                  if hDictionary.has_key?('description')
                     s = hDictionary['description']
                     unless s == ''
                        intDictionary[:description] = s
                     end
                  end

                  # dictionary - citation (required by mdJson) {citation}
                  if hDictionary.has_key?('citation')
                     hCitation = hDictionary['citation']
                     unless hCitation.empty?
                        hReturn = Citation.unpack(hCitation, responseObj)
                        unless hReturn.nil?
                           intDictionary[:citation] = hReturn
                        end
                     end
                  end
                  if intDictionary[:citation].empty?
                     @MessagePath.issueError(141, responseObj)
                  end

                  # dictionary - subject [] (required)
                  if hDictionary.has_key?('subject')
                     aSubjects = hDictionary['subject']
                     aSubjects.each do |item|
                        unless item == ''
                           intDictionary[:subjects] << item
                        end
                     end
                  end
                  if intDictionary[:subjects].empty?
                     @MessagePath.issueError(142, responseObj)
                  end

                  # dictionary - recommended use []
                  if hDictionary.has_key?('recommendedUse')
                     aUses = hDictionary['recommendedUse']
                     aUses.each do |item|
                        unless item == ''
                           intDictionary[:recommendedUses] << item
                        end
                     end
                  end

                  # dictionary - locale [] {locale}
                  if hDictionary.has_key?('locale')
                     aLocales = hDictionary['locale']
                     aLocales.each do |hItem|
                        hReturn = Locale.unpack(hItem, responseObj)
                        unless hReturn.nil?
                           intDictionary[:locales] << hReturn
                        end
                     end
                  end

                  # dictionary - responsible party (required) {responsibleParty}
                  if hDictionary.has_key?('responsibleParty')
                     hRParty = hDictionary['responsibleParty']
                     unless hRParty.empty?
                        hReturn = ResponsibleParty.unpack(hRParty, responseObj)
                        unless hReturn.nil?
                           intDictionary[:responsibleParty] = hReturn
                        end
                     end
                  end
                  if intDictionary[:responsibleParty].empty?
                     @MessagePath.issueError(143, responseObj)
                  end

                  # dictionary - dictionary format
                  # deprecate dictionaryFormat in favor of dictionaryFunctionalLanguage
                  s = nil
                  if hDictionary.has_key?('dictionaryFunctionalLanguage')
                     s = hDictionary['dictionaryFunctionalLanguage']
                  elsif hDictionary.has_key?('dictionaryFormat')
                     s = hDictionary['dictionaryFormat']
                     @MessagePath.issueWarning(144, responseObj)
                  end
                  unless s.nil? || s == ''
                     intDictionary[:dictionaryFunctionalLanguage] = s
                  end

                  # dictionary - dictionary included with resource
                  if hDictionary.has_key?('dictionaryIncludedWithResource')
                     if hDictionary['dictionaryIncludedWithResource'] === true
                        intDictionary[:includedWithDataset] = hDictionary['dictionaryIncludedWithResource']
                     end
                  end

                  # dictionary - domains [] {domain}
                  if hDictionary.has_key?('domain')
                     aDomains = hDictionary['domain']
                     aDomains.each do |hItem|
                        hReturn = Domain.unpack(hItem, responseObj)
                        unless hReturn.nil?
                           intDictionary[:domains] << hReturn
                        end
                     end
                  end

                  # dictionary - entity [] {entity}
                  if hDictionary.has_key?('entity')
                     aEntities = hDictionary['entity']
                     aEntities.each do |hItem|
                        hReturn = Entity.unpack(hItem, responseObj)
                        unless hReturn.nil?
                           intDictionary[:entities] << hReturn
                        end
                     end
                  end

                  return intDictionary

               end

            end

         end
      end
   end
end