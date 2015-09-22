# unpack transfer medium
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2015-08-24 original script
#   Stan Smith 2015-09-18 added capacity and capacity units

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module Medium

                    def self.unpack(hMedium, responseObj)

                        # return nil object if input is empty
                        intMedium = nil
                        return if hMedium.empty?

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intMedium = intMetadataClass.newMedium

                        # medium - type
                        if hMedium.has_key?('name')
                            s = hMedium['name']
                            if s != ''
                                intMedium[:mediumType] = s
                            end
                        end

                        # medium - capacity
                        if hMedium.has_key?('mediumCapacity')
                            s = hMedium['mediumCapacity']
                            if s != ''
                                intMedium[:mediumCapacity] = s
                            end
                        end

                        # medium - capacity units
                        if hMedium.has_key?('mediumCapacityUnits')
                            s = hMedium['mediumCapacityUnits']
                            if s != ''
                                intMedium[:mediumCapacityUnits] = s
                            end
                        end

                        # medium - format
                        if hMedium.has_key?('mediumFormat')
                            s = hMedium['mediumFormat']
                            if s != ''
                                intMedium[:mediumFormat] = s
                            end
                        end

                        # medium - note
                        if hMedium.has_key?('mediumNote')
                            s = hMedium['mediumNote']
                            if s != ''
                                intMedium[:mediumNote] = s
                            end
                        end

                        return intMedium
                    end

                end

            end
        end
    end
end
