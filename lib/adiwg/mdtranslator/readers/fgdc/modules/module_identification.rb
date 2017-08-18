# Reader - fgdc to internal data structure
# unpack fgdc metadata identification

# History:
#  Stan Smith 2017-08-15 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_citation'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module Identification

               def self.unpack(xIdInfo, intObj, hResponseObj)

                  # identification information 1.1 (citation) - citation (required)
                  xCitation = xIdInfo.xpath('./citation')
                  unless xCitation.empty?
                     hCitation = Citation.unpack(xCitation, hResponseObj)
                     unless hCitation.nil?
                        intObj[:metadata][:resourceInfo][:citation] = hCitation
                     end
                  end
                  if xCitation.empty?
                     hResponseObj[:readerExecutionMessages] << 'FGDC is missing identification information citation section (citation)'
                  end

               end

            end

         end
      end
   end
end
