# unpack spatial resolution
# Reader - ADIwg JSON to internal data structure

# History:
#   Stan Smith 2016-10-17 refactored for mdJson 2.0
#   Stan Smith 2015-07-14 refactored to remove global namespace constants
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
# 	Stan Smith 2013-11-26 original script

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_measure')


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

                        # spatial resolution - type (required)
                        if hResolution.has_key?('type')
                            if hResolution['type'] != ''
                                type = hResolution['type']
                                if %w{ scaleFactor measure levelOfDetail }.one? { |word| word == type }
                                    intResolution[:type] = hResolution['type']
                                else
                                    responseObj[:readerExecutionMessages] << 'Spatial Resolution type must be scaleFactor, measure, or levelOfDetail'
                                    responseObj[:readerExecutionPass] = false
                                    return nil
                                end
                            end
                        end
                        if intResolution[:type].nil? || intResolution[:type] == ''
                            responseObj[:readerExecutionMessages] << 'Spatial Resolution attribute type is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # spatial resolution - scale factor (required if)
                        if hResolution['type'] == 'scaleFactor'
                            if hResolution.has_key?('scaleFactor')
                                intResolution[:scaleFactor] = hResolution['scaleFactor']
                            end
                            if intResolution[:scaleFactor].nil? || intResolution[:scaleFactor] == ''
                                responseObj[:readerExecutionMessages] << 'Spatial Resolution attribute scaleFactor is missing'
                                responseObj[:readerExecutionPass] = false
                                return nil
                            end
                        end

                        # spatial resolution - measure (required if)
                        if hResolution['type'] == 'measure'
                            if hResolution.has_key?('measure')
                                hMeasure = hResolution['measure']
                                unless hMeasure.empty?
                                    hObject = Measure.unpack(hMeasure, responseObj)
                                    unless hObject.nil?
                                        intResolution[:measure] = hObject
                                    end
                                end
                            end
                            if intResolution[:measure].empty?
                                responseObj[:readerExecutionMessages] << 'Spatial Resolution object measure is missing or incomplete'
                                responseObj[:readerExecutionPass] = false
                                return nil
                            end
                        end

                        # spatial resolution - level of detail
                        if hResolution['type'] == 'levelOfDetail'
                            if hResolution.has_key?('levelOfDetail')
                                intResolution[:levelOfDetail] = hResolution['levelOfDetail']
                            end
                            if intResolution[:levelOfDetail].nil? || intResolution[:levelOfDetail] == ''
                                responseObj[:readerExecutionMessages] << 'Spatial Resolution attribute levelOfDetail is missing'
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
