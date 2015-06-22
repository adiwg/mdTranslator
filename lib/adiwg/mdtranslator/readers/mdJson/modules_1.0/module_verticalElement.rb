# unpack vertical element
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-11-18 original script
# 	Stan Smith 2013-12-11 modified to handle single vertical element
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module VerticalElement

                    def self.unpack(hVertElement, responseObj)

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new

                        intVertEle = intMetadataClass.newVerticalElement

                        # vertical element - minimum value
                        if hVertElement.has_key?('minimumValue')
                            s = hVertElement['minimumValue']
                            if s != ''
                                intVertEle[:minValue] = s
                            end
                        end

                        # vertical element - maximum value
                        if hVertElement.has_key?('maximumValue')
                            s = hVertElement['maximumValue']
                            if s != ''
                                intVertEle[:maxValue] = s
                            end
                        end

                        # vertical element - vertical crs title attribute
                        if hVertElement.has_key?('verticalCRSTitle')
                            s = hVertElement['verticalCRSTitle']
                            if s != ''
                                intVertEle[:crsTitle] = s
                            end
                        end

                        # vertical element - vertical crs link attribute
                        if hVertElement.has_key?('verticalCRSUri')
                            s = hVertElement['verticalCRSUri']
                            if s != ''
                                intVertEle[:crsURI] = s
                            end
                        end

                        return intVertEle

                    end

                end

            end
        end
    end
end
