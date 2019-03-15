# ISO <<Class>> CI_Contact
# 19115-1 writer output in XML

# History:
# 	Stan Smith 2019-03-14 original script

require_relative 'class_phone'
require_relative 'class_address'
require_relative 'class_onlineResource'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class CI_Contact

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hContact)

                  # classes used
                  phoneClass = CI_Telephone.new(@xml, @hResponseObj)
                  addClass = CI_Address.new(@xml, @hResponseObj)
                  resourceClass = CI_OnlineResource.new(@xml, @hResponseObj)

                  # outContext
                  outContext = 'contact information'
                  outContext +=  ' ' + hContact[:name] unless hContact[:name].nil?
                  outContext += ' (' + hContact[:contactId] + ')' unless hContact[:contactId].nil?

                  @xml.tag!('gmd:CI_Contact') do

                     # contact - phones [] (pass all phones)
                     aPhones = hContact[:phones]
                     unless aPhones.empty?
                        @xml.tag!('gmd:phone') do
                           phoneClass.writeXML(aPhones)
                        end
                     end
                     if aPhones.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:phone')
                     end

                     # contact - address [0]
                     hAddress = hContact[:addresses][0]
                     aEmail = hContact[:eMailList]
                     unless hAddress.nil? && aEmail.empty?
                        @xml.tag!('gmd:address') do
                           addClass.writeXML(hAddress, aEmail)
                        end
                     end
                     if hAddress.nil? && hContact[:eMailList].empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:address')
                     end

                     # contact - online resource [0]
                     hOlResource = hContact[:onlineResources][0]
                     unless hOlResource.nil?
                        @xml.tag!('gmd:onlineResource') do
                           resourceClass.writeXML(hOlResource, outContext)
                        end
                     end
                     if hOlResource.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:onlineResource')
                     end

                     # contact - hours of service [0]
                     s = hContact[:hoursOfService][0]
                     unless s.nil?
                        @xml.tag!('gmd:hoursOfService') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:hoursOfService')
                     end

                     # contact - contact instructions
                     s = hContact[:contactInstructions]
                     unless s.nil?
                        @xml.tag!('gmd:contactInstructions') do
                           @xml.tag!('gco:CharacterString', hContact[:contactInstructions])
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:contactInstructions')
                     end

                  end # CI_Contact tag
               end # write XML
            end # CI_Contact class

         end
      end
   end
end
