# ISO <<Class>> CI_Series
# 19115-2 writer output in XML

# History:
#   Stan Smith 2017-11-02 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19110

            class CI_Series

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hSeries)

                  @xml.tag!('gmd:CI_Series') do

                     # series - name
                     s = hSeries[:seriesName]
                     unless s.nil?
                        @xml.tag!('gmd:name') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:name')
                     end

                     # series - issue identification
                     s = hSeries[:seriesIssue]
                     unless s.nil?
                        @xml.tag!('gmd:issueIdentification') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:issueIdentification')
                     end

                     # series - page
                     s = hSeries[:issuePage]
                     unless s.nil?
                        @xml.tag!('gmd:page') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:page')
                     end

                  end # CI_Series tag
               end # writeXML
            end # CI_Series class

         end
      end
   end
end
