# Reader - fgdc to internal data structure
# unpack fgdc data quality

# History:
#  Stan Smith 2017-08-15 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_lineage'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module Quality

               def self.unpack(xDataQual, hMetadata, hResponseObj)

                  # data quality 2.1 (attracc) - attribute accuracy (not implemented)

                  # data quality 2.2 (logic) - logical consistency (required) (not implemented)
                  xLogic = xDataQual.xpath('./logic')
                  if xLogic.nil?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: data quality logical consistency section is missing'
                  end

                  # data quality 2.3 (complete) - completion report (required) (not implemented)
                  xComplete = xDataQual.xpath('./complete')
                  if xComplete.nil?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: data quality completion report section is missing'
                  end

                  # data quality 2.4 (position) - positional accuracy (not implemented)

                  # data quality 2.5 (lineage) - lineage (required)
                  xLineage = xDataQual.xpath('./lineage')
                  unless xLineage.empty?
                     hLineage = Lineage.unpack(xLineage, hResponseObj)
                     unless hLineage.nil?
                        hMetadata[:lineageInfo] << hLineage
                     end
                  end
                  if xLineage.nil?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: data quality lineage section is missing'
                  end

                  # data quality 2.6 (cloud) - cloud cover (not implemented)

                  return hMetadata

               end

            end

         end
      end
   end
end
