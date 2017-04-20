# unpack grid representation
# Reader - ADIwg JSON to internal data structure

# History:
# 	Stan Smith 2016-10-19 original script

require_relative 'module_dimension'

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module GridRepresentation

                    def self.unpack(hGrid, responseObj)

                        # return nil object if input is empty
                        if hGrid.empty?
                            responseObj[:readerExecutionMessages] << 'Grid Representation object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intGrid = intMetadataClass.newGridInfo

                        # grid representation - number of dimensions (required)
                        if hGrid.has_key?('numberOfDimensions')
                            if hGrid['numberOfDimensions'] != ''
                                intGrid[:numberOfDimensions] = hGrid['numberOfDimensions']
                            end
                        end
                        if intGrid[:numberOfDimensions].nil?
                            responseObj[:readerExecutionMessages] << 'Grid Representation attribute numberOfDimensions is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # grid representation - dimensions []
                        if hGrid.has_key?('dimension')
                            hGrid['dimension'].each do |item|
                                hDim = Dimension.unpack(item, responseObj)
                                unless hDim.nil?
                                    intGrid[:dimension] << hDim
                                end
                            end
                        end

                        # grid representation - cell geometry (required)
                        if hGrid.has_key?('cellGeometry')
                            if hGrid['cellGeometry'] != ''
                                intGrid[:cellGeometry] = hGrid['cellGeometry']
                            end
                        end
                        if intGrid[:cellGeometry].nil?
                            responseObj[:readerExecutionMessages] << 'Grid Representation attribute cellGeometry is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # grid representation - transformation parameter available {Boolean} (required)
                        if hGrid.has_key?('transformationParameterAvailable')
                            if hGrid['transformationParameterAvailable'] === true
                                intGrid[:transformationParameterAvailable] = hGrid['transformationParameterAvailable']
                            end
                        end

                        return intGrid

                    end

                end

            end
        end
    end
end
