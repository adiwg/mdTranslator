# Reader - fgdc to internal data structure
# unpack fgdc lineage

# History:
#  Stan Smith 2017-08-28 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_source'
require_relative 'module_process'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module Lineage

               def self.unpack(xLineage, hResourceInfo, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hLineage = intMetadataClass.newLineage

                  # data quality 2.5 (lineage) - lineage
                  unless xLineage.empty?

                     # lineage 2.5.1 (srcinfo) - source information []
                     axSource = xLineage.xpath('./srcinfo')
                     unless axSource.empty?
                        axSource.each do |xSource|
                           hSource = Source.unpack(xSource, hResourceInfo[:spatialResolutions], hResponseObj)
                           hLineage[:dataSources] << hSource
                        end
                     end

                     # lineage 2.5.2 (procstep) - process step []
                     axProcess = xLineage.xpath('./procstep')
                     unless axProcess.empty?
                        axProcess.each do |xProcess|
                           Process.unpack(xProcess, hLineage, hResponseObj)
                        end
                     end

                     return hLineage

                  end

                  return nil

               end
            end

         end
      end
   end
end
