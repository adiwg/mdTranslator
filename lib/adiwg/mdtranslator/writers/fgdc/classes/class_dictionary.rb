# FGDC <<Class>> Series
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-02-26 refactored error and warning messaging
#  Stan Smith 2018-01-21 original script

require_relative '../fgdc_writer'
require_relative 'class_entityDetail'
require_relative 'class_entityOverview'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class DataDictionary

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Fgdc
               end

               def writeXML(hDictionary, inContext = nil)

                  # classes used
                  detailClass = EntityDetail.new(@xml, @hResponseObj)
                  overviewClass = EntityOverview.new(@xml, @hResponseObj)

                  hDictionary[:entities].each do |hEntity|
                     unless hEntity.empty?

                        # dictionary 5.1 (detailed) - detailed description
                        # <- hDictionary.entity[].entityCode != 'overview'
                        unless hEntity[:entityCode] == 'overview'
                           @xml.tag!('detailed') do
                              detailClass.writeXML(hEntity)
                           end
                        end

                        # dictionary 5.2 (overview) - overview description
                        # <- hDictionary.entity[].entityCode == 'overview'
                        if hEntity[:entityCode] == 'overview'
                           @xml.tag!('overview') do
                              overviewClass.writeXML(hEntity)
                           end
                        end

                     end
                  end

                  # error message
                  if hDictionary[:entities].empty?
                     @NameSpace.issueWarning(80,nil, inContext)
                  end

               end # writeXML
            end # Series

         end
      end
   end
end
