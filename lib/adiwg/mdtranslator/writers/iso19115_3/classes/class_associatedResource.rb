# ISO <<Class>> MD_AssociatedResource
# 19115-3 writer output in XML

# History:
# 	Stan Smith 2019-03-25 original script

require_relative '../iso19115_3_writer'
require_relative 'class_codelist'
require_relative 'class_citation'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_3

            class MD_AssociatedResource

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_3
               end

               def writeXML(hAssocRes, inContext = nil)

                  # classes used
                  codelistClass = MD_Codelist.new(@xml, @hResponseObj)
                  citationClass = CI_Citation.new(@xml, @hResponseObj)

                  outContext = 'associated resource'
                  outContext = inContext + ' associated resource' unless inContext.nil?

                  @xml.tag!('mri:MD_AssociatedResource') do

                     # associated resource - name {CI_Citation}
                     hResourceCitation = hAssocRes[:resourceCitation]
                     unless hResourceCitation.empty?
                        @xml.tag!('mri:name') do
                           citationClass.writeXML(hResourceCitation, outContext)
                        end
                     end
                     if hResourceCitation.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mri:name')
                     end

                     # associated resource - association type {DS_AssociationTypeCode} (required)
                     unless hAssocRes[:associationType].nil?
                        @xml.tag!('mri:associationType') do
                           codelistClass.writeXML('mri', 'iso_associationType', hAssocRes[:associationType])
                        end
                     end
                     if hAssocRes[:associationType].nil?
                        @NameSpace.issueWarning(1, 'mri:associationType')
                     end

                     # associated resource - initiative type {DS_InitiativeTypeCode}
                     unless hAssocRes[:initiativeType].nil?
                        @xml.tag!('mri:initiativeType') do
                           codelistClass.writeXML('mri', 'iso_initiativeType', hAssocRes[:initiativeType])
                        end
                     end
                     if hAssocRes[:initiativeType].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mri:initiativeType')
                     end

                     # associated resource - metadata reference {CI_Citation}
                     hMetadataCitation = hAssocRes[:metadataCitation]
                     unless hMetadataCitation.empty?
                        @xml.tag!('mri:metadataReference') do
                           citationClass.writeXML(hMetadataCitation, outContext)
                        end
                     end
                     if hMetadataCitation.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mri:metadataReference')
                     end

                  end # MD_AssociatedResource tag
               end # writeXML
            end # MD_AssociatedResource class

         end
      end
   end
end
