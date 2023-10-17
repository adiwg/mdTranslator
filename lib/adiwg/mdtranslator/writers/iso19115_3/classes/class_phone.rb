# ISO <<Class>> CI_Telephone
# 19115-3 writer output in XML

# History:
# 	Stan Smith 2019-03-18 original script.

require_relative 'class_codelist'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_3

            class CI_Telephone

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_3
               end

               def writePhone(number, service, inContext)

                  # classes used
                  codelistClass = MD_Codelist.new(@xml, @hResponseObj)

                  @xml.tag!('cit:phone') do
                     @xml.tag!('cit:CI_Telephone') do

                        # phone - phone number (required)
                        unless number.nil?
                           @xml.tag!('cit:number') do
                              @xml.tag!('gco:CharacterString', number)
                           end
                        end
                        if number.nil?
                           @NameSpace.issueWarning(370, 'cit:number', inContext)
                        end

                        # phone - phone number type {CI_TelephoneTypeCode}
                        unless service.nil?
                           @xml.tag!('cit:numberType') do
                              codelistClass.writeXML('cit', 'iso_telephone', service)
                           end
                        end
                        if service.nil? && @hResponseObj[:writerShowTags]
                           @xml.tag!('cit:numberType')
                        end

                     end
                  end
               end

               def writeXML(aPhones, inContext = nil)

                  outContext = 'phone'
                  outContext = inContext + ' phone' unless inContext.nil?

                  aPhones.each do |hPhone|
                     unless hPhone.empty?
                        number = hPhone[:phoneNumber]
                        aServices = hPhone[:phoneServiceTypes]

                        if aServices.empty?
                           writePhone(number, nil, outContext)
                        else
                           aServices.each do |service|
                              writePhone(number, service, outContext)
                           end
                        end

                     end
                  end

               end # write XML
            end # CI_Telephone class

         end
      end
   end
end
