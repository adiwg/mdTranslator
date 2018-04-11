# ISO <<Class>> MD_AggregateInformation
# 19115-2 writer output in XML

# History:
#  Stan Smith 2018-04-09 add error and warning messaging
#  Stan Smith 2016-11-23 refactored for mdTranslator/mdJson 2.0
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#  Stan Smith 2015-06-11 change all codelists to use 'class_codelist' method
#  Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#  Stan Smith 2014-11-06 take initiativeType from internal initiativeType
#  ... rather than resourceType for 0.9.0
#  Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
# 	Stan Smith 2014-05-29 original script

require_relative '../iso19115_2_writer'
require_relative 'class_codelist'
require_relative 'class_citation'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class MD_AggregateInformation

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_2
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

                  end # MD_AggregateInformation tag
               end # writeXML
            end # MD_AggregateInformation class

         end
      end
   end
end
