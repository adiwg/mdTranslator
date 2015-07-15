# unpack extent
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-11-04 original script
# 	Stan Smith 2013-11-14 add temporal elements
# 	Stan Smith 2013-11-14 add vertical elements
# 	Stan Smith 2013-11-27 modified to process a single extent
# 	Stan Smith 2013-12-05 modified to for new temporalElement schema
#   Stan Smith 2014-07-07 resolve require statements using Mdtranslator.reader_module
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to remove global namespace constants

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_geographicElement')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_temporalElement')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_verticalElement')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

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
                        if hExtent.has_key?('temporalElement')
                            hTempElement = hExtent['temporalElement']
                            unless hTempElement.empty?
                                intExtent[:extTempElements] = TemporalElement.unpack(hTempElement, responseObj)
                            end
                        end

                        # extent - vertical elements
                        if hExtent.has_key?('verticalElement')
                            aVertElements = hExtent['verticalElement']
                            unless aVertElements.empty?
                                aVertElements.each do |hVertElement|
                                    intExtent[:extVertElements] << VerticalElement.unpack(hVertElement, responseObj)
                                end
                            end
                        end

                        return intExtent

                    end

                end

            end
        end
    end
end
