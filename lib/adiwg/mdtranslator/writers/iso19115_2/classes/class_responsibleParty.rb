# ISO <<Class>> CI_ResponsibleParty
# 19115-2 writer output in XML

# History:
#  Stan Smith 2019-03-14 added test for empty parameters
#  Stan Smith 2018-04-10 add error and warning messaging
#  Stan Smith 2016-11-17 refactored for mdTranslator/mdJson 2.0
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#  Stan Smith 2015-06-11 change all codelists to use 'class_codelist' method
#  Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#  Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#  Stan Smith 2014-05-14 modified for JSON schema 0.4.0
# 	Stan Smith 2013-08-13 original script.

require_relative '../iso19115_2_writer'
require_relative 'class_codelist'
require_relative 'class_contact'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class CI_ResponsibleParty

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_2
               end

               def writeXML(role, hParty, inContext = nil)

                  # classes used
                  codelistClass = MD_Codelist.new(@xml, @hResponseObj)
                  contactClass = CI_Contact.new(@xml, @hResponseObj)

                  outContext = 'responsible party'
                  outContext = inContext + ' responsible party' unless inContext.nil?

                  hContact = ADIWG::Mdtranslator::Writers::Iso19115_2.getContact(hParty[:contactId])

                  unless hContact.empty?
                     @xml.tag!('gmd:CI_ResponsibleParty') do

                        name = hContact[:name]
                        position = hContact[:positionName]

                        # responsible party
                        if hContact[:isOrganization]

                           # responsible party - organization name
                           unless name.nil?
                              @xml.tag!('gmd:organisationName') do
                                 @xml.tag!('gco:CharacterString', name)
                              end
                           end
                           if name.nil? && @hResponseObj[:writerShowTags]
                              @xml.tag!('gmd:organisationName')
                           end

                        else

                           # responsible party - individual name
                           unless name.nil?
                              @xml.tag!('gmd:individualName') do
                                 @xml.tag!('gco:CharacterString', name)
                              end
                           end
                           if name.nil? && @hResponseObj[:writerShowTags]
                              @xml.tag!('gmd:individualName')
                           end

                           # responsible party - position name
                           unless position.nil?
                              @xml.tag!('gmd:positionName') do
                                 @xml.tag!('gco:CharacterString', position)
                              end
                           end
                           if position.nil? && @hResponseObj[:writerShowTags]
                              @xml.tag!('gmd:positionName')
                           end

                        end

                        # responsible party - contact info
                        haveInfo = false
                        unless hContact[:phones].empty? &&
                           hContact[:addresses].empty? &&
                           hContact[:eMailList].empty? &&
                           hContact[:onlineResources].empty? &&
                           hContact[:hoursOfService].empty? &&
                           hContact[:contactInstructions].nil?
                           haveInfo = true
                        end
                        if haveInfo
                           @xml.tag!('gmd:contactInfo') do
                              contactClass.writeXML(hContact)
                           end
                        end
                        if !haveInfo && @hResponseObj[:writerShowTags]
                           @xml.tag!('gmd:contactInfo')
                        end

                        # responsible party - role (required)
                        unless role.nil?
                           @xml.tag!('gmd:role') do
                              codelistClass.writeXML('gmd', 'iso_role', role)
                           end
                        end
                        if role.nil?
                           @NameSpace.issueWarning(270, 'gmd:role', outContext)
                        end

                     end
                  end
                  if hContact.empty? && @hResponseObj[:writerShowTags]
                     @xml.tag!('gmd:CI_ResponsibleParty')
                  end

               end # write XML
            end # CI_ResponsibleParty class

         end
      end
   end
end
