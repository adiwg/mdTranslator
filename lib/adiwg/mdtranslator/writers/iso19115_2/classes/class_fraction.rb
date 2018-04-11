# ISO <<Class>> MD_RepresentativeFraction
# 19115-2 writer output in XML

# History:
#  Stan Smith 2018-04-09 add error and warning messaging
#  Stan Smith 2016-12-13 original script

require_relative '../iso19115_2_writer'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class MD_RepresentativeFraction

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_2
               end

               def writeXML(denominator)

                  @xml.tag!('gmd:MD_RepresentativeFraction') do

                     # representative fraction - denominator
                     unless denominator.nil?
                        @xml.tag!('gmd:denominator') do
                           @xml.tag!('gco:Integer', denominator)
                        end
                     end
                     if denominator.nil?
                        @NameSpace.issueWarning(120, 'gmd:denominator')
                     end

                  end # gmd:MD_RepresentativeFraction tag
               end # writeXML
            end # MD_RepresentativeFraction class

         end
      end
   end
end
