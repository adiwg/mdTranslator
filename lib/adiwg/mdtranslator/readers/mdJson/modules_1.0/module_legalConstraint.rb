# unpack legal constraint
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-11-14 original script
# 	Stan Smith 2013-11-27 modified to process a single legal constraint
#   Stan Smith 2014-04-28 modified attribute names to match json schema 0.3.0
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module LegalConstraints

                    def self.unpack(hLegalCon)

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        hIntCon = intMetadataClass.newLegalConstraint

                        # legal constraint - access code
                        if hLegalCon.has_key?('accessConstraint')
                            aAccCodes = hLegalCon['accessConstraint']
                            unless aAccCodes.empty?
                                hIntCon[:accessCodes] = aAccCodes
                            end
                        end

                        # legal constraint - use code
                        if hLegalCon.has_key?('useConstraint')
                            aUseCodes = hLegalCon['useConstraint']
                            unless aUseCodes.empty?
                                hIntCon[:useCodes] = aUseCodes
                            end
                        end

                        # legal constraint - other constraints
                        if hLegalCon.has_key?('otherConstraint')
                            aOtherCons = hLegalCon['otherConstraint']
                            unless aOtherCons.empty?
                                hIntCon[:otherCons] = aOtherCons
                            end
                        end

                        return hIntCon

                    end

                end

            end
        end
    end
end
