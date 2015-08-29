# unpack citation
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-08-26 original script
#   Stan Smith 2014-04-25 modified to support json schema 0.3.0
#   Stan Smith 2014-07-03 resolve require statements using Mdtranslator.reader_module
#   Stan Smith 2014-08-18 changed additionalIdentifier section to identifier schema 0.6.0
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2014-12-19 refactored to return nil when hCitation is empty
#   Stan Smith 2014-12-30 refactored
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to remove global namespace constants
#   Stan Smith 2015-08-28 added alternate title

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_dateTime')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_responsibleParty')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_onlineResource')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_resourceIdentifier')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module Citation

                    def self.unpack(hCitation, responseObj)

                        # return nil object if input is empty
                        intCitation = nil
                        return if hCitation.empty?

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intCitation = intMetadataClass.newCitation

                        # citation - title
                        if hCitation.has_key?('title')
                            s = hCitation['title']
                            if s != ''
                                intCitation[:citTitle] = s
                            else
                                responseObj[:readerExecutionMessages] << 'Citation title is empty'
                                responseObj[:readerExecutionPass] = false
                                return nil
                            end
                        else
                            responseObj[:readerExecutionMessages] << 'Citation title is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # citation - alternate title
                        if hCitation.has_key?('alternateTitle')
                            s = hCitation['alternateTitle']
                            if s != ''
                                intCitation[:citAltTitle] = s
                            end
                        end

                        # citation - date
                        if hCitation.has_key?('date')
                            aCitDates = hCitation['date']
                            unless aCitDates.empty?
                                aCitDates.each do |hCitDate|
                                    if hCitDate.has_key?('date')
                                        s = hCitDate['date']
                                        if s != ''
                                            intDateTime = DateTime.unpack(s, responseObj)
                                            if hCitDate.has_key?('dateType')
                                                s = hCitDate['dateType']
                                                if s != ''
                                                    intDateTime[:dateType] = s
                                                end
                                            end
                                            intCitation[:citDate] << intDateTime
                                        end
                                    end
                                end
                            end
                        end

                        # citation - edition
                        if hCitation.has_key?('edition')
                            s = hCitation['edition']
                            if s != ''
                                intCitation[:citEdition] = s
                            end
                        end

                        # citation - responsible party
                        if hCitation.has_key?('responsibleParty')
                            aRParty = hCitation['responsibleParty']
                            unless aRParty.empty?
                                aRParty.each do |hRParty|
                                    intCitation[:citResponsibleParty] << ResponsibleParty.unpack(hRParty, responseObj)
                                end
                            end
                        end

                        # citation - presentation form
                        if hCitation.has_key?('presentationForm')
                            aPForms = hCitation['presentationForm']
                            unless aPForms.empty?
                                aPForms.each do |pForm|
                                    intCitation[:citResourceForms] << pForm
                                end
                            end
                        end

                        # citation - resource identifiers
                        if hCitation.has_key?('identifier')
                            aResIds = hCitation['identifier']
                            aResIds.each do |hIdentifier|
                                unless hIdentifier.empty?
                                    intCitation[:citResourceIds] << ResourceIdentifier.unpack(hIdentifier, responseObj)
                                end
                            end
                        end

                        # citation - online resources
                        if hCitation.has_key?('onlineResource')
                            aOlRes = hCitation['onlineResource']
                            aOlRes.each do |hOlRes|
                                unless hOlRes.empty?
                                    intCitation[:citOlResources] << OnlineResource.unpack(hOlRes, responseObj)
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

