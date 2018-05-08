# FGDC <<Class>> Contact
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-02-26 refactored error and warning messaging
#  Stan Smith 2017-11-27 original script

require_relative '../fgdc_writer'
require_relative 'class_address'
require_relative 'class_phone'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class Contact

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Fgdc
               end

               def writeXML(hContact)

                  # classes used
                  addressClass = Address.new(@xml, @hResponseObj)
                  phoneClass = Phone.new(@xml, @hResponseObj)

                  # address outContext
                  outContext = 'contact ' + hContact[:name] + ' (' + hContact[:contactId] + ')'

                  # set contact type and names
                  contactType = nil
                  personName = nil
                  orgName = nil
                  if hContact[:isOrganization]
                     contactType = 'organization'
                     orgName = hContact[:name]
                     if orgName.nil?
                        @NameSpace.issueWarning(50, 'cntorgp', outContext)
                     end
                  else
                     contactType = 'person'
                     personName = hContact[:name]
                     if personName.nil?
                        @NameSpace.issueWarning('51', 'cntperp', outContext)
                     end
                     unless hContact[:memberOfOrgs].empty?
                        hOrgContact = ADIWG::Mdtranslator::Writers::Fgdc.get_contact(hContact[:memberOfOrgs][0])
                        unless hOrgContact.empty?
                           orgName = hOrgContact[:name]
                        end
                     end
                  end
                  if contactType.nil?
                     @NameSpace.issueError(52, outContext)
                  end

                  # contact 10 (cntinfo) - contact information
                  @xml.tag!('cntinfo') do

                     # contact 10.1 (cntperp) - contact person primary
                     if contactType == 'person'
                        @xml.tag!('cntperp') do

                           # contact 10.1.1 (cntper) - contact person name
                           unless personName.nil?
                              @xml.tag!('cntper', personName)
                           end
                           if personName == ''
                              @NameSpace.issueWarning(53,'cntper', outContext)
                           end

                           # contact 10.1.1 (cntorg) - contact organization name
                           unless orgName.nil?
                              @xml.tag!('cntorg', orgName)
                           end
                           if orgName.nil? && @hResponseObj[:writerShowTags]
                              @xml.tag!('cntorg')
                           end

                        end
                     end

                     # contact 10.2 (cntorgp) - contact organization primary
                     if contactType == 'organization'
                        @xml.tag!('cntorgp') do

                           # contact 10.2.1 (cntper) - contact person name
                           unless personName.nil?
                              @xml.tag!('cntper', personName)
                           end

                           # contact 10.2.1 (cntorg) - contact organization name
                           unless orgName == ''
                              @xml.tag!('cntorg', orgName)
                           end
                           if orgName.nil?
                              @NameSpace.issueWarning(54, 'cntorg', outContext)
                           end

                        end
                     end

                     # contact 10.3 (cntpos) - contact position name
                     unless hContact[:positionName].nil?
                        @xml.tag!('cntpos', hContact[:positionName])
                     end
                     if hContact[:positionName].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('cntpos')
                     end

                     # contact 10.4 (cntaddr) - contact address (required)
                     hContact[:addresses].each do |hAddress|
                        unless hAddress.empty?
                           @xml.tag!('cntaddr') do
                              addressClass.writeXML(hAddress, outContext)
                           end
                        end
                     end
                     if hContact[:addresses].empty?
                        @NameSpace.issueWarning(55, nil, outContext)
                     end

                     # contact 10.5..7 - phone (voice phone required)
                     # requirement testing is done in phoneClass
                     phoneClass.writeXML(hContact[:phones], outContext)

                     # contact 10.8 - email addresses []
                     hContact[:eMailList].each do |email|
                        @xml.tag!('cntemail', email)
                     end
                     if hContact[:eMailList].empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('cntemail')
                     end

                     # contact 10.9 - hours of service
                     # <- hContact[:hoursOfService][0]
                     unless hContact[:hoursOfService].empty?
                        @xml.tag!('hours', hContact[:hoursOfService][0])
                     end
                     if hContact[:hoursOfService].empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('hours')
                     end

                     # contact 10.10 (cntinst) - contact instructions
                     unless hContact[:contactInstructions].nil?
                        @xml.tag!('cntinst', hContact[:contactInstructions])
                     end
                     if hContact[:contactInstructions].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('cntinst')
                     end

                  end

               end # writeXML
            end # Contact

         end
      end
   end
end
