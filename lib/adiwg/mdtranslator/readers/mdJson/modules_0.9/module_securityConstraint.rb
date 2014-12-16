# unpack security constraint
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-11-15 original script
# 	Stan Smith 2013-11-27 modified to process a single security constraint
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module SecurityConstraints

                    def self.unpack(hSecurityCon)

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        hIntCon = intMetadataClass.newSecurityConstraint

                        # security constraint - classification code - required
                        if hSecurityCon.has_key?('classification')
                            s = hSecurityCon['classification']
                            if s != ''
                                hIntCon[:classCode] = s
                            end
                        end

                        # security constraint - user note
                        if hSecurityCon.has_key?('userNote')
                            s = hSecurityCon['userNote']
                            if s != ''
                                hIntCon[:userNote] = s
                            end
                        end

                        # security constraint - classification system
                        if hSecurityCon.has_key?('classificationSystem')
                            s = hSecurityCon['classificationSystem']
                            if s != ''
                                hIntCon[:classSystem] = s
                            end
                        end

                        # security constraint - handling description
                        if hSecurityCon.has_key?('handlingDescription')
                            s = hSecurityCon['handlingDescription']
                            if s != ''
                                hIntCon[:handlingDesc] = s
                            end
                        end

                        return hIntCon

                    end

                end

            end
        end
    end
end
