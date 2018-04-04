# FGDC <<Class>> Series
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-03-23 refactored error and warning messaging
#  Stan Smith 2017-11-21 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class Series

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Fgdc
               end

               def writeXML(hSeries)

                  # series 8.7.1 (sername) - series name
                  # <- hCitation[:series][:seriesName] (required)
                  unless hSeries[:seriesName].nil?
                     @xml.tag!('sername', hSeries[:seriesName])
                  end
                  if hSeries[:seriesName].nil?
                     @NameSpace.issueWarning(360, 'sername')
                  end

                  # series 8.7.2 (issue) - series issue
                  # <- hCitation[:series][:seriesIssue] (required)
                  unless hSeries[:seriesIssue].nil?
                     @xml.tag!('issue', hSeries[:seriesIssue])
                  end
                  if hSeries[:seriesIssue].nil?
                     @NameSpace.issueWarning(361, 'issue')
                  end

               end # writeXML
            end # Series

         end
      end
   end
end
