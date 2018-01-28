# unpack metadata information
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-01-27 add metadataConstraints
#  Stan Smith 2017-01-31 remove metadataCreationDate
#  Stan Smith 2016-10-31 original script

require_relative 'module_identifier'
require_relative 'module_citation'
require_relative 'module_locale'
require_relative 'module_responsibleParty'
require_relative 'module_date'
require_relative 'module_onlineResource'
require_relative 'module_constraint'
require_relative 'module_maintenance'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module MetadataInfo

               def self.unpack(hMetaInfo, responseObj)


                  # return nil object if input is empty
                  if hMetaInfo.empty?
                     responseObj[:readerExecutionMessages] << 'MetadataInfo object is empty'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intMetaInfo = intMetadataClass.newMetadataInfo

                  # metadata information - metadata identifier {identifier}
                  if hMetaInfo.has_key?('metadataIdentifier')
                     hObject = hMetaInfo['metadataIdentifier']
                     unless hObject.empty?
                        hReturn = Identifier.unpack(hObject, responseObj)
                        unless hReturn.nil?
                           intMetaInfo[:metadataIdentifier] = hReturn
                        end
                     end
                  end

                  # metadata information - parent metadata {citation}
                  if hMetaInfo.has_key?('parentMetadata')
                     hObject = hMetaInfo['parentMetadata']
                     unless hObject.empty?
                        hReturn = Citation.unpack(hObject, responseObj)
                        unless hReturn.nil?
                           intMetaInfo[:parentMetadata] = hReturn
                        end
                     end
                  end

                  # metadata information - default metadata locale {locale} (default to utf-8)
                  if hMetaInfo.has_key?('defaultMetadataLocale')
                     hObject = hMetaInfo['defaultMetadataLocale']
                     unless hObject.empty?
                        hReturn = Locale.unpack(hObject, responseObj)
                        unless hReturn.nil?
                           intMetaInfo[:defaultMetadataLocale] = hReturn
                        end
                     end
                  end

                  # metadata information - other metadata locale [] {locale}
                  if hMetaInfo.has_key?('otherMetadataLocale')
                     aItems = hMetaInfo['otherMetadataLocale']
                     aItems.each do |item|
                        hReturn = Locale.unpack(item, responseObj)
                        unless hReturn.nil?
                           intMetaInfo[:otherMetadataLocales] << hReturn
                        end
                     end
                  end

                  # metadata information - metadata contact [] {responsibleParty} (required)
                  if hMetaInfo.has_key?('metadataContact')
                     aItems = hMetaInfo['metadataContact']
                     aItems.each do |item|
                        hReturn = ResponsibleParty.unpack(item, responseObj)
                        unless hReturn.nil?
                           intMetaInfo[:metadataContacts] << hReturn
                        end
                     end
                  end
                  if intMetaInfo[:metadataContacts].empty?
                     responseObj[:readerExecutionMessages] << 'MetadataInfo object is missing metadataContacts'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # metadata information - metadata dates [] {date}
                  if hMetaInfo.has_key?('metadataDate')
                     aItems = hMetaInfo['metadataDate']
                     aItems.each do |item|
                        hReturn = Date.unpack(item, responseObj)
                        unless hReturn.nil?
                           intMetaInfo[:metadataDates] << hReturn
                        end
                     end
                  end

                  # metadata information - metadata online resource [] {onlineResource}
                  if hMetaInfo.has_key?('metadataOnlineResource')
                     aItems = hMetaInfo['metadataOnlineResource']
                     aItems.each do |item|
                        hReturn = OnlineResource.unpack(item, responseObj)
                        unless hReturn.nil?
                           intMetaInfo[:metadataLinkages] << hReturn
                        end
                     end
                  end

                  # metadata information - metadata constraint [] {constraint}
                  if hMetaInfo.has_key?('metadataConstraint')
                     hMetaInfo['metadataConstraint'].each do |hItem|
                        hReturn = Constraint.unpack(hItem, responseObj)
                        unless hReturn.nil?
                           intMetaInfo[:metadataConstraints] << hReturn
                        end
                     end
                  end

                  # metadata information - metadata maintenance {maintenance}
                  if hMetaInfo.has_key?('metadataMaintenance')
                     hObject = hMetaInfo['metadataMaintenance']
                     unless hObject.empty?
                        hReturn = Maintenance.unpack(hObject, responseObj)
                        unless hReturn.nil?
                           intMetaInfo[:metadataMaintenance] = hReturn
                        end
                     end
                  end

                  # metadata information - alternative metadata reference [] {citation}
                  if hMetaInfo.has_key?('alternateMetadataReference')
                     aItems = hMetaInfo['alternateMetadataReference']
                     aItems.each do |item|
                        hReturn = Citation.unpack(item, responseObj)
                        unless hReturn.nil?
                           intMetaInfo[:alternateMetadataReferences] << hReturn
                        end
                     end
                  end

                  # metadata information - metadata status
                  if hMetaInfo.has_key?('metadataStatus')
                     if hMetaInfo['metadataStatus'] != ''
                        intMetaInfo[:metadataStatus] = hMetaInfo['metadataStatus']
                     end
                  end

                  return intMetaInfo

               end

            end

         end
      end
   end
end
