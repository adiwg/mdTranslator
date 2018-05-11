# ISO <<Class>> MD_Distribution
# 19115-2 writer output in XML

# History:
#  Stan Smith 2016-12-07 refactored for mdTranslator/mdJson 2.0
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#  Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#  Stan Smith 2014-07-09 modify require statements to function in RubyGem structure
# 	Stan Smith 2013-09-25 original script

require_relative 'class_distributor'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class MD_Distribution

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hDistribution)

                  # classes used
                  distributorClass = MD_Distributor.new(@xml, @hResponseObj)

                  @xml.tag!('gmd:MD_Distribution') do

                     # distribution - distributor
                     aDistributors = hDistribution[:distributor]
                     unless aDistributors.empty?
                        aDistributors.each do |hDistributor|
                           @xml.tag!('gmd:distributor') do
                              distributorClass.writeXML(hDistributor)
                           end
                        end
                     end
                     if aDistributors.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:distributor')
                     end

                  end # gmd:MD_Distribution tag
               end # writeXML
            end # MD_Distribution class

         end
      end
   end
end
