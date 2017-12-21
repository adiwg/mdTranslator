# Reader - fgdc to internal data structure
# unpack fgdc lineage

# History:
#  Stan Smith 2017-12-19 add bio methodology
#  Stan Smith 2017-08-28 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_methodology'
require_relative 'module_source'
require_relative 'module_process'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module Lineage

               def self.unpack(xLineage, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hLineage = intMetadataClass.newLineage

                  # data quality 2.5 (lineage) - lineage
                  unless xLineage.empty?

                     # lineage bio (method) - methodology []
                     axMethods = xLineage.xpath('./method')
                     unless axMethods.empty?
                        Method.unpack(hLineage, axMethods, hResponseObj)
                     end

                     # lineage 2.5.1 (srcinfo) - source information []
                     axSource = xLineage.xpath('./srcinfo')
                     unless axSource.empty?
                        axSource.each do |xSource|
                           hSource = Source.unpack(xSource, hResponseObj)
                           hLineage[:dataSources] << hSource
                        end
                     end

                     # lineage 2.5.2 (procstep) - process step []
                     axProcess = xLineage.xpath('./procstep')
                     unless axProcess.empty?
                        axProcess.each do |xProcess|
                           hProcess = Process.unpack(xProcess, hLineage, hResponseObj)
                           hLineage[:processSteps] << hProcess
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
