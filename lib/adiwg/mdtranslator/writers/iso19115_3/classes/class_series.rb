# ISO <<Class>> CI_Series
# 19115-3 writer output in XML

# History:
#   Stan Smith 2019-03-15 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_3

            class CI_Series

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hSeries)

                  @xml.tag!('cit:CI_Series') do

                     # series - name
                     s = hSeries[:seriesName]
                     unless s.nil?
                        @xml.tag!('cit:name') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('cit:name')
                     end

                     # series - issue identification
                     s = hSeries[:seriesIssue]
                     unless s.nil?
                        @xml.tag!('cit:issueIdentification') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('cit:issueIdentification')
                     end

                     # series - page
                     s = hSeries[:issuePage]
                     unless s.nil?
                        @xml.tag!('cit:page') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('cit:page')
                     end

                  end # CI_Series tag
               end # writeXML
            end # CI_Series class

         end
      end
   end
end
