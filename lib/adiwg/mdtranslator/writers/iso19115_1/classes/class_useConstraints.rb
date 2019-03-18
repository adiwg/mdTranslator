# ISO <<Class>> MD_Constraints (Use Constraint)
# 19115-1 writer output in XML

# History:
# 	Stan Smith 2019-03-18 original script

require_relative 'class_scope'
require_relative 'class_browseGraphic'
require_relative 'class_citation'
require_relative 'class_releasability'
require_relative 'class_responsibility'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class MD_Constraints

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hConstraint, inContext = nil)

                  # classes used
                  scopeClass = MD_Scope.new(@xml, @hResponseObj)
                  graphClass = MD_BrowseGraphic.new(@xml, @hResponseObj)
                  citationClass = CI_Citation.new(@xml, @hResponseObj)
                  releaseClass = MD_Releasability.new(@xml, @hResponseObj)
                  responsibleClass = CI_Responsibility.new(@xml, @hResponseObj)

                  outContext = 'use constraint'
                  outContext = inContext + ' use constraint' unless inContext.nil?

                  @xml.tag!('mco:MD_Constraints') do


                     # use constraints - use limitation []
                     aCons = hConstraint[:useLimitation]
                     aCons.each do |useCon|
                        @xml.tag!('mco:useLimitation') do
                           @xml.tag!('gco:CharacterString', useCon)
                        end
                     end
                     if aCons.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mco:useLimitation')
                     end

                     # use constraints - constraint application scope {MD_Scope}
                     unless hConstraint[:scope].empty?
                        @xml.tag!('mco:constraintApplicationScope') do
                           scopeClass.writeXML(hConstraint[:scope], outContext)
                        end
                     end
                     if hConstraint[:scope].empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mco:constraintApplicationScope')
                     end

                     # use constraints - graphic [] {MD_BrowseGraphic}
                     aGraphics = hConstraint[:graphic]
                     aGraphics.each do |hGraphic|
                        @xml.tag!('mco:graphic') do
                           graphClass.writeXML(hGraphic, outContext)
                        end
                     end
                     if aGraphics.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mco:graphic')
                     end

                     # use constraints - reference [] {CI_Citation}
                     aReferences = hConstraint[:responsibleParty]
                     aReferences.each do |hCitation|
                        @xml.tag!('mco:reference') do
                           citationClass.writeXML(hCitation, outContext)
                        end
                     end
                     if aReferences.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mco:reference')
                     end

                     # use constraints - releasability {MD_Releasability}
                     unless hConstraint[:releasability].empty?
                        @xml.tag!('mco:releasability') do
                           releaseClass.writeXML(hConstraint[:releasability], outContext)
                        end
                     end
                     if hConstraint[:releasability].empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mco:releasability')
                     end

                     # use constraints - responsible party [] {CI_Responsibility}
                     aParties = hConstraint[:responsibleParty]
                     aParties.each do |hRParty|
                        @xml.tag!('mco:reference') do
                           responsibleClass.writeXML(hRParty, outContext)
                        end
                     end
                     if aParties.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mco:reference')
                     end

                  end # gmd:MD_Constraints tag
               end # writeXML
            end # MD_Constraints class

         end
      end
   end
end
