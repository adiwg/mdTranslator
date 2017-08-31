# Reader - fgdc to internal data structure
# unpack fgdc process

# History:
#  Stan Smith 2017-08-28 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module Process

               def self.unpack(xProcess, hLineage, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hProcess = intMetadataClass.newProcessStep

                  # process 2.5.2.1 (procdesc) - process description
                  description = xProcess.xpath('./procdesc').text
                  unless description.empty?
                     hProcess[:description] = description
                  end

                  # process 2.5.2.2 (srcused) - source used citation abbreviation []
                  axUsed = xProcess.xpath('./srcused')
                  unless axUsed.empty?

                  end

                  # process 2.5.2.3 (procdate) - procedure date
                  procDate = xProcess.xpath('./procdate').text
                  unless procDate.empty?

                  end

                  # process 2.5.2.4 (proctime) - procedure time
                  procTime = xProcess.xpath('./proctime')
                  unless procTime.empty?

                  end

                  # process 2.5.2.5 (srcprod) - source produced citation abbreviation []
                  axProduced = xProcess.xpath('./srcprod')
                  unless axProduced.empty?

                  end

                  # process 2.5.2.6 (proccont) - process contact {contact}
                  xContact = xProcess.xpath('./proccont')
                  unless xContact.empty?

                  end

                  return hProcess

               end

            end

         end
      end
   end
end
