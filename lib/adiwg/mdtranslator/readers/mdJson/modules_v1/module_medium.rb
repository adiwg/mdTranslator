# unpack transfer medium
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2015-08-24 original script

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

                        if hMedium.has_key?('name')
                            s = hMedium['name']
                            if s != ''
                                intMedium[:mediumName] = s
                            end
                        end

                        if hMedium.has_key?('mediumFormat')
                            s = hMedium['mediumFormat']
                            if s != ''
                                intMedium[:mediumFormat] = s
                            end
                        end

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
