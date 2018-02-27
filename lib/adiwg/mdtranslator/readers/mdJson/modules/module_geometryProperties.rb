# unpack geometry properties
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-02-18 refactored error and warning messaging
#  Stan Smith 2016-10-25 original script

require_relative 'module_identifier'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module GeometryProperties

               def self.unpack(hGeoProp, responseObj)

                  # return nil object if input is empty
                  if hGeoProp.empty?
                     responseObj[:readerExecutionMessages] << 'WARNING: mdJson reader: GeoJSON geometry properties object is empty'
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intGeoProp = intMetadataClass.newGeometryProperties

                  # geometry properties - feature name []
                  if hGeoProp.has_key?('featureName')
                     hGeoProp['featureName'].each do |item|
                        if item != ''
                           intGeoProp[:featureNames] << item
                        end
                     end
                  end

                  # geometry properties - description
                  if hGeoProp.has_key?('description')
                     unless hGeoProp['description'] == ''
                        intGeoProp[:description] = hGeoProp['description']
                     end
                  end

                  # geometry properties - [{Identifier}]
                  if hGeoProp.has_key?('identifier')
                     aItems = hGeoProp['identifier']
                     aItems.each do |item|
                        hReturn = Identifier.unpack(item, responseObj)
                        unless hReturn.nil?
                           intGeoProp[:identifiers] << hReturn
                        end
                     end
                  end

                  # geometry properties - feature scope
                  if hGeoProp.has_key?('featureScope')
                     unless hGeoProp['featureScope'] == ''
                        intGeoProp[:featureScope] = hGeoProp['featureScope']
                     end
                  end

                  # geometry properties - acquisition method
                  if hGeoProp.has_key?('acquisitionMethod')
                     unless hGeoProp['acquisitionMethod'] == ''
                        intGeoProp[:acquisitionMethod] = hGeoProp['acquisitionMethod']
                     end
                  end

                  return intGeoProp

               end

            end

         end
      end
   end
end
