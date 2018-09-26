# Reader - fgdc to internal data structure
# unpack fgdc vertical altitude reference

# History:
#  Stan Smith 2018-09-26 move altitude datum name to datumIdentifier
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
                  hDatumIdentifier = intMetadataClass.newIdentifier

                  hDatum[:isDepthSystem] = false

                  # altitude datum 4.2.1.1 (altdatum) - altitude datum name (required)
                  # -> referenceSystemParameters.verticalDatum.datumIdentifier.identifier
                  datumName = xAltSys.xpath('./altdatum').text
                  unless datumName.empty?
                     hDatumIdentifier[:identifier] = datumName
                     hDatum[:datumIdentifier] = hDatumIdentifier
                  end
                  if datumName.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: vertical altitude datum name is missing'
                  end

                  # altitude datum 4.2.1.2 (altres) - altitude resolution []
                  # -> referenceSystemParameters.verticalDatum.verticalResolution
                  altRes = xAltSys.xpath('./altres[1]').text
                  unless altRes.empty?
                     hDatum[:verticalResolution] = altRes.to_f
                  end

                  # altitude datum 4.2.1.3 (altunits) -  altitude distance units (required)
                  # -> referenceSystemParameters.verticalDatum.unitOfMeasure
                  altUnits = xAltSys.xpath('./altunits').text
                  unless altUnits.empty?
                     hDatum[:unitOfMeasure] = altUnits
                  end
                  if altUnits.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: vertical altitude distance units are missing'
                  end

                  # altitude datum 4.2.1.4 (altenc) - altitude encoding method (required)
                  # -> referenceSystemParameters.verticalDatum.encodingMethod
                  altEncode = xAltSys.xpath('./altenc').text
                  unless altEncode.empty?
                     hDatum[:encodingMethod] = altEncode
                  end
                  if altEncode.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: vertical altitude encoding method is missing'
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
