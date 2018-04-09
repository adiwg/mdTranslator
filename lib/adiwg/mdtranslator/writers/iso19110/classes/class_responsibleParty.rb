# ISO <<Class>> CI_ResponsibleParty
# 19110 writer output in XML

# History:
#  Stan Smith 2018-04-03 refactored error and warning messaging
#  Stan Smith 2017-01-23 refactored for mdTranslator/mdJson 2.0
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#  Stan Smith 2015-06-11 change all codelists to use 'class_codelist' method
#  Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#  Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#  Stan Smith 2014-05-14 modified for JSON schema 0.4.0
# 	Stan Smith 2013-08-13 original script.

require_relative '../iso19110_writer'
require_relative 'class_codelist'
require_relative 'class_contact'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19110

            class CI_ResponsibleParty

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19110
               end

               def writeXML(role, hParty)

                  # classes used
                  codelistClass = MD_Codelist.new(@xml, @hResponseObj)
                  contactClass = CI_Contact.new(@xml, @hResponseObj)

                  contactId = hParty[:contactId]
                  hContact = ADIWG::Mdtranslator::Writers::Iso19110.getContact(contactId)
                  unless hContact.empty?
                     isOrg = hContact[:isOrganization]
                     @xml.tag!('gmd:CI_ResponsibleParty') do

                        # ISO19110 follows ISO19115-2 rules and requires either an individual
                        # or organization name and allows for both.  Since mdJson 2+ patterns
                        # after ISO19115-3 only one name is maintained.  So individual name
                        # becomes required for individual and organization name for organization.

                        # responsible party - (if individual)
                        unless isOrg

                           # individual name (required)
                           s = hContact[:name]
                           unless s.nil?
                              @xml.tag!('gmd:individualName') do
                                 @xml.tag!('gco:CharacterString', s)
                              end
                           end
                           if s.nil?
                              @NameSpace.issueWarning(22, 'gmd:individualName')
                           end

                           # position name
                           s = hContact[:positionName]
                           unless s.nil?
                              @xml.tag!('gmd:positionName') do
                                 @xml.tag!('gco:CharacterString', s)
                              end
                           end
                           if s.nil? && @hResponseObj[:writerShowTags]
                              @xml.tag!('gmd:positionName')
                           end

                        end

                        # responsible party - (if organization)
                        if isOrg

                           # organization name (required)
                           s = hContact[:name]
                           unless s.nil?
                              @xml.tag!('gmd:organisationName') do
                                 @xml.tag!('gco:CharacterString', s)
                              end
                           end
                           if s.nil?
                              @NameSpace.issueWarning(21, 'gmd:organisationName')
                           end

                        end

                        # responsible party - contact info
                        haveInfo = false
                        haveInfo = true unless hContact[:phones].empty?
                        haveInfo = true unless hContact[:addresses].empty?
                        haveInfo = true unless hContact[:eMailList].empty?
                        haveInfo = true unless hContact[:onlineResources].empty?
                        haveInfo = true unless hContact[:hoursOfService].empty?
                        haveInfo = true unless hContact[:contactInstructions].nil?
                        if haveInfo
                           @xml.tag!('gmd:contactInfo') do
                              contactClass.writeXML(hContact)
                           end
                        elsif @hResponseObj[:writerShowTags]
                           @xml.tag!('gmd:contactInfo')
                        end

                        # responsible party - role (required)
                        s = role
                        unless s.nil?
                           @xml.tag! 'gmd:role' do
                              codelistClass.writeXML('gmd', 'iso_role', s)
                           end
                        end
                        if s.nil?
                           @NameSpace.issueWarning(20, 'gmd:role')
                        end

                     end # CI_ResponsibleParty tag
                  end # valid contact returned
               end # write XML
            end # CI_ResponsibleParty class

         end
      end
   end
end
