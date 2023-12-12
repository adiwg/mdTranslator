# ISO <<Class>> MD_SecurityConstraints
# 19115-3 writer output in XML

# History:
# 	Stan Smith 2019-03-18 original script.

require_relative '../iso19115_3_writer'
require_relative 'class_codelist'
require_relative 'class_constraintCommon'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_3

            class MD_SecurityConstraints

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_3
               end

               def writeXML(hConstraint, inContext = nil)

                  # classes used
                  codelistClass = MD_Codelist.new(@xml, @hResponseObj)
                  commonClass = ConstraintCommon.new(@xml, @hResponseObj)

                  outContext = 'security constraint'
                  outContext = inContext + ' security constraint' unless inContext.nil?

                  hSecurityCon = hConstraint[:securityConstraint]
                  unless hSecurityCon.empty?
                     @xml.tag!('mco:MD_SecurityConstraints') do

                        # security constraints - use constraint elements
                        commonClass.writeXML(hConstraint, outContext)

                        # security constraints - classification code (required)
                        s = hSecurityCon[:classCode]
                        unless s.nil?
                           @xml.tag!('mco:classification') do
                              codelistClass.writeXML('mco', 'iso_classification', s)
                           end
                        end
                        if s.nil?
                           @NameSpace.issueWarning(290, 'mco:classification')
                        end

                        # security constraints - user note
                        s = hSecurityCon[:userNote]
                        unless s.nil?
                           @xml.tag!('mco:userNote') do
                              @xml.tag!('gco:CharacterString', s)
                           end
                        end
                        if s.nil? && @hResponseObj[:writerShowTags]
                           @xml.tag!('mco:userNote')
                        end

                        # security constraints - classification system
                        s = hSecurityCon[:classSystem]
                        unless s.nil?
                           @xml.tag!('mco:classificationSystem') do
                              @xml.tag!('gco:CharacterString', s)
                           end
                        end
                        if s.nil? && @hResponseObj[:writerShowTags]
                           @xml.tag!('mco:classificationSystem')
                        end

                        # security constraints - handling description
                        s = hSecurityCon[:handling]
                        unless s.nil?
                           @xml.tag!('mco:handlingDescription') do
                              @xml.tag!('gco:CharacterString', s)
                           end
                        end
                        if s.nil? && @hResponseObj[:writerShowTags]
                           @xml.tag!('mco:handlingDescription')
                        end

                     end # MD_SecurityConstraints tag

                  end
                  if hSecurityCon.empty?
                     @NameSpace.issueWarning(292, nil, outContext)
                  end

               end # writeXML
            end # MD_SecurityConstraints class

         end
      end
   end
end
