# ISO <<Class>> MD_Distribution
# 19115-3 writer output in XML

# History:
# 	Stan Smith 2019-04-09 original script

require_relative 'class_distributor'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_3

            class MD_Distribution

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hDistribution)

                  # classes used
                  distributorClass = MD_Distributor.new(@xml, @hResponseObj)

                  @xml.tag!('mrd:MD_Distribution') do

                     # distribution - description
                     unless hDistribution[:description].nil?
                        @xml.tag!('mrd:description') do
                           @xml.tag!('gco:CharacterString', hDistribution[:description])
                        end
                     end
                     if hDistribution[:description].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrd:description')
                     end

                     # distribution - distributor
                     aDistributors = hDistribution[:distributor]
                     unless aDistributors.empty?
                        aDistributors.each do |hDistributor|
                           @xml.tag!('mrd:distributor') do
                              distributorClass.writeXML(hDistributor)
                           end
                        end
                     end
                     if aDistributors.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrd:distributor')
                     end

                     # distribution - transfer options - supported under distributor

                     # distribution - distribution format - supported under distributor

                  end # gmd:MD_Distribution tag
               end # writeXML
            end # MD_Distribution class

         end
      end
   end
end
