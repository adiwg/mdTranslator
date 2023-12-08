# ISO <<Class>> CI_Date
# 19115-3 writer output in XML

# History:
# 	Stan Smith 2019-03-14 original script

require_relative '../iso19115_3_writer'
require_relative 'class_codelist'
require_relative 'class_gcoDateTime'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_3

            class CI_Date

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_3
               end

               def writeXML(hDate, inContext = nil)

                  # classes used
                  codelistClass = MD_Codelist.new(@xml, @hResponseObj)
                  gcoDateTimeClass = GcoDateTime.new(@xml, @hResponseObj)

                  date = hDate[:date]
                  dateType = hDate[:dateType]

                  @xml.tag!('cit:CI_Date') do

                     # date - date (required)
                     unless date.nil?
                        @xml.tag!('cit:date') do
                           gcoDateTimeClass.writeXML(hDate)
                        end
                     end
                     if date.nil?
                        @NameSpace.issueError(70)
                     end

                     # date - date type (required)
                     unless dateType.nil?
                        @xml.tag!('cit:dateType') do
                           codelistClass.writeXML('cit', 'iso_dateType', dateType)
                        end
                     end
                     if dateType.nil?
                        @NameSpace.issueWarning(71, 'cit:dateType', inContext)
                     end

                  end # CI_Date tag
               end # write XML
            end # CI_Date class

         end
      end
   end
end
