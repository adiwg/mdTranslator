# ISO <<Class>> CI_Date
# 19115-2 writer output in XML

# History:
#  Stan Smith 2018-04-09 add error and warning messaging
#  Stan Smith 2016-11-29 refactored for mdTranslator/mdJson 2.0
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#  Stan Smith 2015-06-11 change all codelists to use 'class_codelist' method
#  Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#  Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
# 	Stan Smith 2013-11-21 support for date or datetime
# 	Stan Smith 2013-08-26 original script

require_relative '../iso19115_2_writer'
require_relative 'class_codelist'
require_relative 'class_gcoDateTime'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class CI_Date

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_2
               end

               def writeXML(hDate, inContext = nil)

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
                        @NameSpace.issueError(70)
                     end

                     # date - date type (required)
                     unless dateType.nil?
                        @xml.tag!('gmd:dateType') do
                           codelistClass.writeXML('gmd', 'iso_dateType', dateType)
                        end
                     end
                     if dateType.nil?
                        @NameSpace.issueWarning(71, 'gmd:dateType', inContext)
                     end

                  end # CI_Date tag
               end # write XML
            end # CI_Date class

         end
      end
   end
end
