# unpack metadata information
# Reader - ADIwg JSON to internal data structure

# History:
#   Stan Smith 2016-10-31 original script

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_identifier')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_citation')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_locale')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_scope')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_responsibleParty')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_date')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_onlineResource')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_maintenance')

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

                        # metadata information - resource scope [] {scope}
                        if hMetaInfo.has_key?('resourceScope')
                            aItems = hMetaInfo['resourceScope']
                            aItems.each do |item|
                                hReturn = Scope.unpack(item, responseObj)
                                unless hReturn.nil?
                                    intMetaInfo[:resourceScopes] << hReturn
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

                        # metadata information - metadata creation date {date} (default supplied by mdEditor or mdTranslator)
                        if hMetaInfo.has_key?('metadataCreationDate')
                            sDate = hMetaInfo['metadataCreationDate']
                            unless sDate == ''
                                hObject = {}
                                hObject['date'] = sDate
                                hObject['dateType'] = 'creation'
                                hReturn = Date.unpack(hObject, responseObj)
                                unless hReturn.nil?
                                    intMetaInfo[:metadataCreationDate] = hReturn
                                end
                            end
                        end

                        # metadata information - other metadata dates [] {date}
                        if hMetaInfo.has_key?('otherMetadataDates')
                            aItems = hMetaInfo['otherMetadataDates']
                            aItems.each do |item|
                                hReturn = Date.unpack(item, responseObj)
                                unless hReturn.nil?
                                    intMetaInfo[:otherMetadataDates] << hReturn
                                end
                            end
                        end

                        # metadata information - metadata linkage [] {onlineResource}
                        if hMetaInfo.has_key?('metadataLinkage')
                            aItems = hMetaInfo['metadataLinkage']
                            aItems.each do |item|
                                hReturn = OnlineResource.unpack(item, responseObj)
                                unless hReturn.nil?
                                    intMetaInfo[:metadataLinkages] << hReturn
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
