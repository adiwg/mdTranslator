# unpack resource formats
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-08-26 original script
# 	Stan Smith 2013-11-27 modified to process single resource format rather than array
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module ResourceFormat

                    def self.unpack(hResFormat, responseObj)

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        rFormat = intMetadataClass.newResourceFormat

                        # format - name
                        if hResFormat.has_key?('formatName')
                            s = hResFormat['formatName']
                            if s != ''
                                rFormat[:formatName] = s
                            end
                        end

                        # format - version
                        if hResFormat.has_key?('version')
                            s = hResFormat['version']
                            if s != ''
                                rFormat[:formatVersion] = s
                            end
                        end

                        return rFormat
                    end

                end

            end
        end
    end
end
