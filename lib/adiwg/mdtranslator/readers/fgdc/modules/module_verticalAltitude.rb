# Reader - fgdc to internal data structure
# unpack fgdc vertical altitude reference

# History:
#  Stan Smith 2017-10-19 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module VerticalAltitude

               def self.unpack(xAltSys, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hDatum = intMetadataClass.newVerticalDatum

                  hDatum[:isDepthSystem] = false

                  # altitude datum 4.2.1.1 (altdatum) - altitude datum name
                  # -> referenceSystemParameters.verticalDatum.datumName
                  datumName = xAltSys.xpath('./altdatum').text
                  unless datumName.empty?
                     hDatum[:datumName] = datumName
                  end

                  # altitude datum 4.2.1.2 (altres) - altitude resolution []
                  # -> referenceSystemParameters.verticalDatum.verticalResolution
                  altRes = xAltSys.xpath('./altres[1]').text
                  unless altRes.empty?
                     hDatum[:verticalResolution] = altRes.to_f
                  end

                  # altitude datum 4.2.1.3 (altunits) -  altitude distance units
                  # -> referenceSystemParameters.verticalDatum.unitOfMeasure
                  altUnits = xAltSys.xpath('./altunits').text
                  unless altUnits.empty?
                     hDatum[:unitOfMeasure] = altUnits
                  end

                  # altitude datum 4.2.1.4 (altenc) - altitude encoding method
                  # -> referenceSystemParameters.verticalDatum.encodingMethod
                  altEncode = xAltSys.xpath('./altenc').text
                  unless altEncode.empty?
                     hDatum[:encodingMethod] = altEncode
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
