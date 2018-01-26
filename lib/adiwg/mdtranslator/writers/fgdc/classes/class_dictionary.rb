# FGDC <<Class>> Series
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-01-21 original script

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
               end

               def writeXML(hDictionary)

                  # classes used
                  detailClass = EntityDetail.new(@xml, @hResponseObj)
                  overviewClass = EntityOverview.new(@xml, @hResponseObj)

                  haveDescription = false
                  hDictionary[:entities].each do |hEntity|
                     unless hEntity.empty?

                        # dictionary 5.1 (detailed) - detailed description
                        # <- hDictionary.entity[].entityCode != 'overview'
                        unless hEntity[:entityCode] == 'overview'
                           @xml.tag!('detailed') do
                              detailClass.writeXML(hEntity)
                           end
                           haveDescription = true
                        end

                        # dictionary 5.2 (overview) - overview description
                        # <- hDictionary.entity[].entityCode == 'overview'
                        if hEntity[:entityCode] == 'overview'
                           @xml.tag!('overview') do
                              overviewClass.writeXML(hEntity)
                           end
                           haveDescription = true
                        end

                     end

                  end

                  # must have at least on detailed description or overview description
                  unless haveDescription
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Data Dictionary requires at least one detail or overview description'
                  end

               end # writeXML
            end # Series

         end
      end
   end
end
