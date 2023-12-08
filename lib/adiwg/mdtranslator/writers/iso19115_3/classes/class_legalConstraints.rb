# ISO <<Class>> MD_LegalConstraints
# 19115-3 writer output in XML

# History:
# 	Stan Smith 2019-03-18 original script.

require_relative 'class_codelist'
require_relative 'class_useConstraints'
require_relative 'class_constraintCommon'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_3

            class MD_LegalConstraints

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_3
               end

               def writeXML(hConstraint, inContext = nil)

                  # classes used
                  codelistClass = MD_Codelist.new(@xml, @hResponseObj)
                  commonClass = ConstraintCommon.new(@xml, @hResponseObj)

                  outContext = 'legal constraint'
                  outContext = inContext + ' legal constraint' unless inContext.nil?

                  hLegalCon = hConstraint[:legalConstraint]
                  unless hLegalCon.empty?

                     @xml.tag!('mco:MD_LegalConstraints') do

                        # legal constraints - use constraint elements
                        commonClass.writeXML(hConstraint, outContext)

                        # legal constraints - access constraints
                        aAccess = hLegalCon[:accessCodes]
                        aAccess.each do |code|
                           @xml.tag!('mco:accessConstraints') do
                              codelistClass.writeXML('mco', 'iso_restriction', code)
                           end
                        end
                        if aAccess.empty? && @hResponseObj[:writerShowTags]
                           @xml.tag!('mco:accessConstraints')
                        end

                        # legal constraints - use constraints
                        aUse = hLegalCon[:useCodes]
                        aUse.each do |code|
                           @xml.tag!('mco:useConstraints') do
                              codelistClass.writeXML('mco', 'iso_restriction', code)
                           end
                        end
                        if aUse.empty? && @hResponseObj[:writerShowTags]
                           @xml.tag!('mco:useConstraints')
                        end

                        # legal constraints - other constraints
                        aOther = hLegalCon[:otherCons]
                        aOther.each do |con|
                           @xml.tag!('mco:otherConstraints') do
                              @xml.tag!('gco:CharacterString', con)
                           end
                        end
                        if aOther.empty? && @hResponseObj[:writerShowTags]
                           @xml.tag!('mco:otherConstraints')
                        end

                     end # gmd:MD_LegalConstraints tag

                  end
                  if hLegalCon.empty?
                     @NameSpace.issueWarning(291, nil, outContext)
                  end

               end # writeXML
            end # MD_LegalConstraints class

         end
      end
   end
end
