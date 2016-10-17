# unpack angular measure
# Reader - ADIwg JSON to internal data structure

# History:
# 	Stan Smith 2016-10-16 original script

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module AngularMeasure

                    def self.unpack(hAngular, responseObj)

                        # return nil object if input is empty
                        if hAngular.empty?
                            responseObj[:readerExecutionMessages] << 'Angular Measure object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intAngular = intMetadataClass.newAngularMeasure

                        # angular measure - distance (required)
                        if hAngular.has_key?('angle')
                            intAngular[:angle] = hAngular['angle']
                        end
                        if intAngular[:angle].nil? || intAngular[:angle] == ''
                            responseObj[:readerExecutionMessages] << 'Angular Measure attribute angle is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # angular measure - unit of measure {required}
                        if hAngular.has_key?('unitOfMeasure')
                            intAngular[:unitOfMeasure] = hAngular['unitOfMeasure']
                        end
                        if intAngular[:unitOfMeasure].nil? || intAngular[:unitOfMeasure] == ''
                            responseObj[:readerExecutionMessages] << 'Angular Measure attribute unitOfMeasure is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        return intAngular
                    end

                end

            end
        end
    end
end
