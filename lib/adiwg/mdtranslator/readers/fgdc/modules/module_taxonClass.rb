# Reader - fgdc to internal data structure
# unpack fgdc taxonomy classification

# History:
#  Stan Smith 2017-09-21 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_taxonClass'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module TaxonClass

               def self.unpack(xTaxonClass, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hTaxonClass = intMetadataClass.newTaxonClass

                  # taxonomy bio.4.1 (taxonrn) - taxon rank name
                  # -> resourceInfo.taxonomy.taxonClass.taxonRank
                  rankName = xTaxonClass.xpath('./taxonrn').text
                  unless rankName.empty?
                     hTaxonClass[:taxonRank] = rankName
                  end

                  # taxonomy bio.4.2 (taxonrv) - taxon rank value
                  # -> resourceInfo.taxonomy.taxonClass.taxonValue
                  rankValue = xTaxonClass.xpath('./taxonrv').text
                  unless rankValue.empty?
                     hTaxonClass[:taxonValue] = rankValue
                  end

                  # taxonomy bio.4.3 (common) - taxon common name []
                  # -> resourceInfo.taxonomy.taxonClass.commonNames
                  axCommonNames = xTaxonClass.xpath('./common')
                  unless axCommonNames.empty?
                     axCommonNames.each do |xCommon|
                        common = xCommon.text
                        unless common.empty?
                           hTaxonClass[:commonNames] << common
                        end
                     end
                  end

                  # taxonomy bio.4.4 (taxoncl) - taxonomic classification []
                  # -> resourceInfo.taxonomy.taxonClass.taxonClass
                  axSubClass = xTaxonClass.xpath('./taxoncl')
                  unless axSubClass.empty?
                     axSubClass.each do |xSubClass|
                        hClass = TaxonClass.unpack(xSubClass, hResponseObj)
                        unless hClass.nil?
                           hTaxonClass[:subClasses] << hClass
                        end
                     end
                  end

                  return hTaxonClass

               end
            end

         end
      end
   end
end
