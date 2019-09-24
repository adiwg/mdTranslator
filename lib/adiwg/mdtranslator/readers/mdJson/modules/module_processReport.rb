# unpack process step report
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2019-09-23 original script

require_relative 'module_citation'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module ProcessStepReport

               def self.unpack(hReport, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hReport.empty?
                     @MessagePath.issueWarning(980, responseObj, inContext)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intProcessReport = intMetadataClass.newProcessStepReport

                  outContext = 'process step report'
                  outContext = inContext + ' > ' + outContext unless inContext.nil?

                  # process step report - name (required)
                  if hReport.has_key?('name')
                     unless hReport['name'] == ''
                        intProcessReport[:name] = hReport['name']
                     end
                  end
                  if intProcessReport[:name].nil?
                     @MessagePath.issueWarning(981, responseObj, inContext)
                  end

                  # process step report - description
                  if hReport.has_key?('description')
                     unless hReport['description'] == ''
                        intProcessReport[:description] = hReport['description']
                     end
                  end

                  # process step report - file type
                  if hReport.has_key?('fileType')
                     unless hReport['fileType'] == ''
                        intProcessReport[:fileType] = hReport['fileType']
                     end
                  end

                  return intProcessReport

               end

            end

         end
      end
   end
end
