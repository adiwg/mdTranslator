# unpack constraints
# Reader - ADIwg JSON to internal data structure

# History:
# 	Stan Smith 2016-10-15 original script

require_relative 'module_constraint'
require_relative 'module_legalConstraint'
require_relative 'module_securityConstraint'

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module Constraints

                    def self.unpack(hConstraints, responseObj)


                        # return nil object if input is empty
                        if hConstraints.empty?
                            responseObj[:readerExecutionMessages] << 'Constraints object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intConstraint = intMetadataClass.newConstraints

                        # constraints - constraint []
                        if hConstraints.has_key?('constraint')
                            aCons = hConstraints['constraint']
                            aCons.each do |item|
                                hCon = Constraint.unpack(item, responseObj)
                                unless hCon.nil?
                                    intConstraint[:constraints] << hCon
                                end
                            end
                        end

                        # constraints - legal constraint []
                        if hConstraints.has_key?('legalConstraint')
                            aCons = hConstraints['legalConstraint']
                            aCons.each do |item|
                                hCon = LegalConstraint.unpack(item, responseObj)
                                unless hCon.nil?
                                    intConstraint[:legalConstraints] << hCon
                                end
                            end
                        end

                        # constraints - security constraint []
                        if hConstraints.has_key?('securityConstraint')
                            aCons = hConstraints['securityConstraint']
                            aCons.each do |item|
                                hCon = SecurityConstraint.unpack(item, responseObj)
                                unless hCon.nil?
                                    intConstraint[:securityConstraints] << hCon
                                end
                            end
                        end

                        return intConstraint

                    end

                end

            end
        end
    end
end
