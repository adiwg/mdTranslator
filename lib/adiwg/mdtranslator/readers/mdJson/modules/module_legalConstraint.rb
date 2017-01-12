# unpack legal constraint
# Reader - ADIwg JSON to internal data structure

# History:
# 	Stan Smith 2016-10-15 refactored for mdJson 2.0
#   Stan Smith 2015-07-14 refactored to remove global namespace constants
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2014-04-28 modified attribute names to match json schema 0.3.0
# 	Stan Smith 2013-11-27 modified to process a single legal constraint
# 	Stan Smith 2013-11-14 original script

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module LegalConstraint

                    def self.unpack(hLegalCon, responseObj)

                        # return nil object if input is empty
                        if hLegalCon.empty?
                            responseObj[:readerExecutionMessages] << 'Legal Constraint object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intLegalCon= intMetadataClass.newLegalConstraint

                        # legal constraint - use constraint []
                        if hLegalCon.has_key?('useConstraint')
                            hLegalCon['useConstraint'].each do |item|
                                if item != ''
                                    intLegalCon[:useCodes] << item
                                end
                            end
                        end

                        # legal constraint - access constraint []
                        if hLegalCon.has_key?('accessConstraint')
                            hLegalCon['accessConstraint'].each do |item|
                                if item != ''
                                    intLegalCon[:accessCodes] << item
                                end
                            end
                        end

                        # legal constraint - other constraint []
                        if hLegalCon.has_key?('otherConstraint')
                            hLegalCon['otherConstraint'].each do |item|
                                if item != ''
                                    intLegalCon[:otherCons] << item
                                end
                            end
                        end

                        if  intLegalCon[:useCodes].empty? &&
                            intLegalCon[:accessCodes].empty? &&
                            intLegalCon[:otherCons].empty?
                            responseObj[:readerExecutionMessages] << 'Legal Constraint was not declared'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        return intLegalCon

                    end

                end

            end
        end
    end
end
