# unpack citation
# Reader - ADIwg JSON to internal data structure

# History:
#   Stan Smith 2016-10-13 refactored for mdJson 2.0
#   Stan Smith 2015-08-28 added alternate title
#   Stan Smith 2015-07-14 refactored to remove global namespace constants
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2014-12-30 refactored
#   Stan Smith 2014-12-19 refactored to return nil when hCitation is empty
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2014-08-18 changed additionalIdentifier section to identifier schema 0.6.0
#   Stan Smith 2014-07-03 resolve require statements using Mdtranslator.reader_module
#   Stan Smith 2014-04-25 modified to support json schema 0.3.0
# 	Stan Smith 2013-08-26 original script

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_date')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_responsibleParty')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_onlineResource')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_identifier')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_series')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_graphic')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module Citation

                    def self.unpack(hCitation, responseObj)


                        # return nil object if input is empty
                        if hCitation.empty?
                            responseObj[:readerExecutionMessages] << 'Citation object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intCitation = intMetadataClass.newCitation

                        # citation - title (required)
                        if hCitation.has_key?('title')
                            intCitation[:citTitle] = hCitation['title']
                        end
                        if intCitation[:citTitle].nil? || intCitation[:citTitle] == ''
                            responseObj[:readerExecutionMessages] << 'Citation attribute title is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # citation - alternate title []
                        if hCitation.has_key?('alternateTitle')
                            hCitation['alternateTitle'].each do |item|
                                if item != ''
                                    intCitation[:citAltTitle] << item
                                end
                            end
                        end

                        # citation - date []
                        if hCitation.has_key?('date')
                            aCitDates = hCitation['date']
                            aCitDates.each do |item|
                                hDate = Date.unpack(item, responseObj)
                                unless hDate.nil?
                                    intCitation[:citDate] << hDate
                                end
                            end
                        end

                        # citation - edition
                        if hCitation.has_key?('edition')
                            if hCitation['edition'] != ''
                                intCitation[:citEdition] = hCitation['edition']
                            end
                        end

                        # citation - responsible party []
                        if hCitation.has_key?('responsibleParty')
                            aRParty = hCitation['responsibleParty']
                            aRParty.each do |item|
                                hParty = ResponsibleParty.unpack(item, responseObj)
                                unless hParty.nil?
                                    intCitation[:citResponsibleParty] << hParty
                                end
                            end
                        end

                        # citation - presentation form []
                        if hCitation.has_key?('presentationForm')
                            hCitation['presentationForm'].each do |item|
                                if item != ''
                                    intCitation[:citPresentationForms] << item
                                end
                            end
                        end

                        # citation - identifier []
                        if hCitation.has_key?('identifier')
                            aIds = hCitation['identifier']
                            aIds.each do |item|
                                hIdentifier = Identifier.unpack(item, responseObj)
                                unless hIdentifier.nil?
                                    intCitation[:citIdentifiers] << hIdentifier
                                end
                            end
                        end

                        # citation - series
                        if hCitation.has_key?('series')
                            hObject = hCitation['series']
                            unless hObject.empty?
                                hReturn = Series.unpack(hObject, responseObj)
                                unless hReturn.nil?
                                    intCitation[:citSeries] = hReturn
                                end
                            end
                        end

                        # citation - other details
                        if hCitation.has_key?('otherCitationDetails')
                            hCitation['otherCitationDetails'].each do |item|
                                if item != ''
                                    intCitation[:citOtherDetails] << item
                                end
                            end
                        end

                        # citation - online resource []
                        if hCitation.has_key?('onlineResource')
                            aOlRes = hCitation['onlineResource']
                            aOlRes.each do |item|
                                hResource = OnlineResource.unpack(item, responseObj)
                                unless hResource.nil?
                                    intCitation[:citOlResources] << hResource
                                end
                            end
                        end

                        # citation - graphic []
                        if hCitation.has_key?('graphic')
                            aGraphic = hCitation['graphic']
                            aGraphic.each do |item|
                                hGraphic = Graphic.unpack(item, responseObj)
                                unless hGraphic.nil?
                                    intCitation[:citGraphics] << hGraphic
                                end
                            end
                        end

                        return intCitation

                    end

                end

            end
        end
    end
end
