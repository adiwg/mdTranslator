# ISO <<Class>> CI_Date
# 19115-2 writer output in XML

# History:
# 	Stan Smith 2017-11-02 original script

require_relative 'class_codelist'
require_relative 'class_gcoDateTime'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19110

            class CI_Date

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hDate)

                  # classes used
                  codelistClass = MD_Codelist.new(@xml, @hResponseObj)
                  gcoDateTimeClass = GcoDateTime.new(@xml, @hResponseObj)

                  date = hDate[:date]
                  dateType = hDate[:dateType]

                  @xml.tag!('gmd:CI_Date') do

                     # date - date (required)
                     unless date.nil?
                        @xml.tag!('gmd:date') do
                           gcoDateTimeClass.writeXML(hDate)
                        end
                     end
                     if date.nil?
                        @xml.tag!('gmd:date', {'gco:nilReason' => 'missing'})
                     end

                     # date - date type (required)
                     unless dateType.nil?
                        @xml.tag!('gmd:dateType') do
                           codelistClass.writeXML('gmd', 'iso_dateType', dateType)
                        end
                     end
                     if dateType.nil?
                        @xml.tag!('gmd:dateType', {'gco:nilReason' => 'missing'})
                     end

                  end # CI_Date tag
               end # write XML
            end # CI_Date class

         end
      end
   end
end
