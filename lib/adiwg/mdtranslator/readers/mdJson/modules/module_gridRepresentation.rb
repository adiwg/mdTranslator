# unpack grid representation
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-20 refactored error and warning messaging
# 	Stan Smith 2016-10-19 original script

require_relative 'module_dimension'
require_relative 'module_scope'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module GridRepresentation

               def self.unpack(hGrid, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hGrid.empty?
                     @MessagePath.issueWarning(440, responseObj, inContext)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intGrid = intMetadataClass.newGridInfo

                  outContext = 'grid representation'
                  outContext = inContext + ' > ' + outContext unless inContext.nil?

                  # grid representation - number of dimensions (required)
                  if hGrid.has_key?('numberOfDimensions')
                     unless hGrid['numberOfDimensions'] == ''
                        intGrid[:numberOfDimensions] = hGrid['numberOfDimensions']
                     end
                  end
                  if intGrid[:numberOfDimensions].nil?
                     @MessagePath.issueError(441, responseObj, inContext)
                  end

                  # grid representation - dimensions [] (required)
                  if hGrid.has_key?('dimension')
                     hGrid['dimension'].each do |item|
                        hDim = Dimension.unpack(item, responseObj, outContext)
                        unless hDim.nil?
                           intGrid[:dimension] << hDim
                        end
                     end
                  end
                  if intGrid[:dimension].empty?
                     @MessagePath.issueError(442, responseObj, inContext)
                  end

                  # grid representation - cell geometry (required)
                  if hGrid.has_key?('cellGeometry')
                     unless hGrid['cellGeometry'] == ''
                        intGrid[:cellGeometry] = hGrid['cellGeometry']
                     end
                  end
                  if intGrid[:cellGeometry].nil?
                     @MessagePath.issueError(443, responseObj, inContext)
                  end

                  # grid representation - transformation parameter available {Boolean} (required)
                  if hGrid.has_key?('transformationParameterAvailable')
                     if hGrid['transformationParameterAvailable'] === true
                        intGrid[:transformationParameterAvailable] = hGrid['transformationParameterAvailable']
                     end
                  end

                  if hGrid.has_key?('scope')
                     hGrid['scope'].each do |item|
                        scope = Scope.unpack(item, responseObj, outContext)
                        unless scope.nil?
                           intGrid[:scope] << scope
                        end
                     end
                  end

                  return intGrid

               end

            end

         end
      end
   end
end
