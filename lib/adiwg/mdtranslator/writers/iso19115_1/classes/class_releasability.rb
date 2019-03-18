# ISO <<Class>> MD_Releasability
# 19115-1 writer output in XML

# History:
#   Stan Smith 2019-03-18 original script

require_relative 'class_responsibility'
require_relative 'class_codelist'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class MD_Releasability

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hRelease, inContext = nil)

                  @xml.tag!('mco:MD_Releasability') do

                     codelistClass = MD_Codelist.new(@xml, @hResponseObj)
                     responsibleClass = CI_Responsibility.new(@xml, @hResponseObj)

                     outContext = 'releasability'
                     outContext = inContext + ' releasability' unless inContext.nil?

                     # releasability - addressee [] {CI_Responsibility}
                     aParties = hRelease[:addressee]
                     aParties.each do |hRParty|
                        @xml.tag!('mco:addressee') do
                           responsibleClass.writeXML(hRParty, outContext)
                        end
                     end
                     if aParties.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mco:addressee')
                     end

                     # releasability - statement
                     unless hRelease[:statement].nil?
                        @xml.tag!('mco:statement') do
                           @xml.tag!('gco:CharacterString', hRelease[:statement])
                        end
                     end
                     if hRelease[:statement].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mco:statement')
                     end

                     # releasability - dissemination constraint [] {MD_RestrictionCode}
                     aConstraint = hRelease[:disseminationConstraint]
                     aConstraint.each do |constraint|
                        @xml.tag!('mco:disseminationConstraints') do
                           codelistClass.writeXML('mco', 'iso_dateType', constraint)
                        end
                     end
                     if aConstraint.empty && @hResponseObj[:writerShowTags]
                        @xml.tag!('mco:disseminationConstraints')
                     end

                  end # MD_Releasability tag
               end # writeXML
            end # MD_Releasability class

         end
      end
   end
end
