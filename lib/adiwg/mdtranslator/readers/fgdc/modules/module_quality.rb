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

                  hResourceInfo = hMetadata[:resourceInfo]

                  # data quality 2.1 (attracc) - attribute accuracy (not implemented)

                  # data quality 2.2 (logic) - logical consistency (not implemented)

                  # data quality 2.3 (complete) - completion report (not implemented)

                  # data quality 2.4 (position) - positional accuracy (not implemented)

                  # data quality 2.5 (lineage) - lineage
                  xLineage = xDataQual.xpath('./lineage')
                  unless xLineage.empty?
                     hLineage = Lineage.unpack(xLineage, hResourceInfo, hResponseObj)
                     unless hLineage.nil?
                        hMetadata[:lineageInfo] << hLineage
                     end
                  end

                  # data quality 2.6 (cloud) - cloud cover (not implemented)

                  return hMetadata

               end

            end

         end
      end
   end
end
