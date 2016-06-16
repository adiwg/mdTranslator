require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_geographicElement')
#require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_temporalElement')
#require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_verticalElement')

module ADIWG
    module Mdtranslator
        module Readers
            module SbJson

                module Extent

                    def self.unpack(hExtent, responseObj)

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intExtent = intMetadataClass.newExtent

                        # extent - description
                        if hExtent.has_key?('description')
                            s = hExtent['description']
                            if s != ''
                                intExtent[:extDesc] = s
                            end
                        end

                        # extent - geographic elements
                        if hExtent.has_key?('geographicElement')
                            aGeoElements = hExtent['geographicElement']
                            unless aGeoElements.empty?
                                intExtent[:extGeoElements] = GeographicElement.unpack(aGeoElements, responseObj)
                            end
                        end

                        # extent - temporal elements
                        # if hExtent.has_key?('temporalElement')
                        #     hTempElement = hExtent['temporalElement']
                        #     unless hTempElement.empty?
                        #         intExtent[:extTempElements] = TemporalElement.unpack(hTempElement, responseObj)
                        #     end
                        # end
                        #
                        # # extent - vertical elements
                        # if hExtent.has_key?('verticalElement')
                        #     aVertElements = hExtent['verticalElement']
                        #     unless aVertElements.empty?
                        #         aVertElements.each do |hVertElement|
                        #             intExtent[:extVertElements] << VerticalElement.unpack(hVertElement, responseObj)
                        #         end
                        #     end
                        # end

                        return intExtent

                    end

                end

            end
        end
    end
end
