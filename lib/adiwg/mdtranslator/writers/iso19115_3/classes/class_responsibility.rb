# ISO <<Class>> CI_Responsibility
# 19115-3 writer output in XML

# History:
# 	Stan Smith 2019-03-14 original script.

require_relative '../iso19115_3_writer'
require_relative 'class_codelist'
require_relative 'class_extent'
require_relative 'class_individual'
require_relative 'class_organization'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_3

            class CI_Responsibility

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_3
               end

               def writeXML(hResponsibility, inContext = nil)

                  # classes used
                  codelistClass = MD_Codelist.new(@xml, @hResponseObj)
                  extentClass = EX_Extent.new(@xml, @hResponseObj)
                  individualClass = CI_Individual.new(@xml, @hResponseObj)
                  orgClass = CI_Organization.new(@xml, @hResponseObj)

                  outContext = 'responsible party'
                  outContext = inContext + ' responsible party' unless inContext.nil?

                  @xml.tag!('cit:CI_Responsibility') do

                     # responsibility - role (required)
                     unless hResponsibility[:roleName].nil?
                        @xml.tag!('cit:role') do
                           codelistClass.writeXML('cit', 'iso_role', hResponsibility[:roleName])
                        end
                     end
                     if hResponsibility[:roleName].nil?
                        @NameSpace.issueWarning(270, 'cit:role', outContext)
                     end

                     # responsibility - extent [] {EX_Extent}
                     aExtents = hResponsibility[:roleExtents]
                     aExtents.each do |hExtent|
                        @xml.tag!('cit:extent') do
                           extentClass.writeXML(hExtent)
                        end
                     end
                     if aExtents.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('cit:extent')
                     end

                     # responsibility - party [] {CI_Individual | CI_Organization} (required)
                     aParty = hResponsibility[:parties]
                     aParty.each do |hParty|
                        unless hParty.empty?
                           contactId = hParty[:contactId]
                           hContact = @NameSpace.getContact(contactId)
                           unless hContact.empty?
                              @xml.tag!('cit:party') do
                                 if hContact[:isOrganization]
                                    orgClass.writeXML(hParty, hContact, outContext)
                                 else
                                    individualClass.writeXML(hContact, outContext)
                                 end
                              end
                           end
                           if hContact.empty?
                              @NameSpace.issueWarning(272, 'cit:party', outContext)
                           end
                        end
                        if hParty.empty?
                           @NameSpace.issueWarning(271, 'cit:party', outContext)
                        end
                     end

                  end # CI_Responsibility tag
               end # write XML
            end # CI_ResponsibleParty class

         end
      end
   end
end
