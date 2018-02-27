# Reader - fgdc to internal data structure
# unpack fgdc vertical depth reference

# History:
#  Stan Smith 2017-10-19 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module VerticalDepth

               def self.unpack(xDepthSys, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hDatum = intMetadataClass.newVerticalDatum
                  hDatum[:isDepthSystem] = true

                  # depth datum 4.2.2.1 (depthdn) - depth datum name
                  # -> referenceSystemParameters.verticalDatum.datumName
                  datumName = xDepthSys.xpath('./depthdn').text
                  unless datumName.empty?
                     hDatum[:datumName] = datumName
                  end
                  if datumName.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: vertical depth datum name is missing'
                  end

                  # depth datum 4.2.2.2 (depthres) - depth resolution [] (take first)
                  # -> referenceSystemParameters.verticalDatum.verticalResolution
                  depthRes = xDepthSys.xpath('./depthres[1]').text
                  unless depthRes.empty?
                     hDatum[:verticalResolution] = depthRes.to_f
                  end

                  # depth datum 4.2.2.3 (depthdu) -  depth distance units
                  # -> referenceSystemParameters.verticalDatum.unitOfMeasure
                  depthUnits = xDepthSys.xpath('./depthdu').text
                  unless depthUnits.empty?
                     hDatum[:unitOfMeasure] = depthUnits
                  end
                  if depthUnits.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: vertical depth distance units are missing'
                  end

                  # depth datum 4.2.2.4 (depthem) - depth encoding method
                  # -> referenceSystemParameters.verticalDatum.encodingMethod
                  depthEncode = xDepthSys.xpath('./depthem').text
                  unless depthEncode.empty?
                     hDatum[:encodingMethod] = depthEncode
                  end
                  if depthEncode.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: vertical depth encoding method is missing'
                  end

                  hParamSet = intMetadataClass.newReferenceSystemParameterSet
                  hRefSystem = intMetadataClass.newSpatialReferenceSystem
                  hParamSet[:verticalDatum] = hDatum
                  hRefSystem[:systemParameterSet] = hParamSet
                  return hRefSystem

               end

            end

         end
      end
   end
end
