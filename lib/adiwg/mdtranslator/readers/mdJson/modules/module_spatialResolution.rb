# unpack spatial resolution
# Reader - ADIwg JSON to internal data structure

# History:
#   Stan Smith 2016-10-17 refactored for mdJson 2.0
#   Stan Smith 2015-07-14 refactored to remove global namespace constants
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
# 	Stan Smith 2013-11-26 original script

require_relative 'module_measure'

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module SpatialResolution

                    def self.unpack(hResolution, responseObj)

                        # return nil object if input is empty
                        if hResolution.empty?
                            responseObj[:readerExecutionMessages] << 'Spatial Resolution object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intResolution = intMetadataClass.newSpatialResolution

                        # spatial resolution - scale factor (required if)
                        if hResolution.has_key?('scaleFactor')
                            if hResolution['scaleFactor'] != ''
                                intResolution[:scaleFactor] = hResolution['scaleFactor']
                            else
                                responseObj[:readerExecutionMessages] << 'Spatial Resolution scale factor is missing'
                                responseObj[:readerExecutionPass] = false
                                return nil
                            end
                        end

                        # spatial resolution - measure
                        if hResolution.has_key?('measure')
                            hMeasure = hResolution['measure']
                            unless hMeasure.empty?
                                hObject = Measure.unpack(hMeasure, responseObj)
                                if hObject.nil?
                                    responseObj[:readerExecutionMessages] << 'Spatial Resolution measure is missing'
                                    responseObj[:readerExecutionPass] = false
                                    return nil
                                else
                                    intResolution[:measure] = hObject
                                end
                            end
                        end

                        # spatial resolution - level of detail
                        if hResolution.has_key?('levelOfDetail')
                            if hResolution['levelOfDetail'] != ''
                                intResolution[:levelOfDetail] = hResolution['levelOfDetail']
                            else
                                responseObj[:readerExecutionMessages] << 'Spatial Resolution level of detail is missing'
                                responseObj[:readerExecutionPass] = false
                                return nil
                            end
                        end

                        return intResolution

                    end

                end

            end
        end
    end
end
