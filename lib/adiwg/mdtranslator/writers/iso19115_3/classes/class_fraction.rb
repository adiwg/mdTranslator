# ISO <<Class>> MD_RepresentativeFraction
# 19115-3 writer output in XML

# History:
#  Stan Smith 2019-03-21 original script

require_relative '../iso19115_3_writer'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_3

            class MD_RepresentativeFraction

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_3
               end

               def writeXML(denominator, inContext = nil)

                  outContext = 'scale factor'
                  outContext = inContext + ' scale factor' unless inContext.nil?

                  @xml.tag!('mri:MD_RepresentativeFraction') do

                     # representative fraction - denominator
                     unless denominator.nil?
                        @xml.tag!('mri:denominator') do
                           @xml.tag!('gco:Integer', denominator)
                        end
                     end
                     if denominator.nil?
                        @NameSpace.issueWarning(120, 'mri:denominator', outContext)
                     end

                  end # gmd:MD_RepresentativeFraction tag
               end # writeXML
            end # MD_RepresentativeFraction class

         end
      end
   end
end
