# ISO <<Class>> MD_AssociatedResource
# 19115-1 writer output in XML

# History:
# 	Stan Smith 2019-03-25 original script

require_relative '../iso19115_1_writer'
require_relative 'class_codelist'
require_relative 'class_citation'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class MD_AssociatedResource

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_1
               end

               def writeXML(hAssocRes)

                  # classes used
                  codelistClass = MD_Codelist.new(@xml, @hResponseObj)
                  citationClass = CI_Citation.new(@xml, @hResponseObj)

                  @xml.tag!('gmd:MD_AggregateInformation') do

                     # aggregate information - aggregate data set name {citation}
                     hAssocCit = hAssocRes[:resourceCitation]
                     unless hAssocCit.empty?
                        @xml.tag!('gmd:aggregateDataSetName') do
                           citationClass.writeXML(hAssocCit, 'associated resource')
                        end
                     end
                     if hAssocCit.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:aggregateDataSetName')
                     end

                     # aggregate information - aggregate data set identifier (use citation > identifier)
                     # data set identifier was dropped from 19115-1 and not carried in mdJson

                     # aggregate information - association type (required)
                     s = hAssocRes[:associationType]
                     unless s.nil?
                        @xml.tag!('gmd:associationType') do
                           codelistClass.writeXML('gmd', 'iso_associationType', s)
                        end
                     end
                     if s.nil?
                        @NameSpace.issueWarning(1, 'gmd:associationType')
                     end

                     # aggregate information - initiative type
                     s = hAssocRes[:initiativeType]
                     unless s.nil?
                        @xml.tag!('gmd:initiativeType') do
                           codelistClass.writeXML('gmd', 'iso_initiativeType', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:initiativeType')
                     end

                  end # MD_AssociatedResource tag
               end # writeXML
            end # MD_AssociatedResource class

         end
      end
   end
end
