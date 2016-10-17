# unpack spatial resolution
# Reader - ADIwg JSON to internal data structure

# History:
#   Stan Smith 2016-10-17 refactored for mdJson 2.0
#   Stan Smith 2015-07-14 refactored to remove global namespace constants
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
# 	Stan Smith 2013-11-26 original script

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_angularMeasure')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_distanceMeasure')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_verticalMeasure')


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
                                if %w{ scaleFactor distance vertical angle levelOfDetail }.one? { |word| word == type }
                                    intResolution[:type] = hResolution['type']
                                else
                                    responseObj[:readerExecutionMessages] << 'Spatial Resolution type must be scaleFactor, distance, vertical, angle, or levelOfDetail'
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

                        # resolution - distance measure (required if)
                        if hResolution['type'] == 'distance'
                            if hResolution.has_key?('distanceMeasure')
                                hMeasure = hResolution['distanceMeasure']
                                unless hMeasure.empty?
                                    hObject = DistanceMeasure.unpack(hMeasure, responseObj)
                                    unless hObject.nil?
                                        intResolution[:distance] = hObject
                                    end
                                end
                            end
                            if intResolution[:distance].empty?
                                responseObj[:readerExecutionMessages] << 'Spatial Resolution object distanceMeasure is missing or incomplete'
                                responseObj[:readerExecutionPass] = false
                                return nil
                            end
                        end

                        # resolution - vertical measure (required if)
                        if hResolution['type'] == 'vertical'
                            if hResolution.has_key?('verticalMeasure')
                                hMeasure = hResolution['verticalMeasure']
                                unless hMeasure.empty?
                                    hObject = VerticalMeasure.unpack(hMeasure, responseObj)
                                    unless hObject.nil?
                                        intResolution[:vertical] = hObject
                                    end
                                end
                            end
                            if intResolution[:vertical].empty?
                                responseObj[:readerExecutionMessages] << 'Spatial Resolution object verticalMeasure is missing or incomplete'
                                responseObj[:readerExecutionPass] = false
                                return nil
                            end
                        end

                        # resolution - angular measure (required if)
                        if hResolution['type'] == 'angle'
                            if hResolution.has_key?('angularMeasure')
                                hMeasure = hResolution['angularMeasure']
                                unless hMeasure.empty?
                                    hObject = AngularMeasure.unpack(hMeasure, responseObj)
                                    unless hObject.nil?
                                        intResolution[:angle] = hObject
                                    end
                                end
                            end
                            if intResolution[:angle].empty?
                                responseObj[:readerExecutionMessages] << 'Spatial Resolution object angularMeasure is missing or incomplete'
                                responseObj[:readerExecutionPass] = false
                                return nil
                            end
                        end

                        # resolution - level of detail
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
