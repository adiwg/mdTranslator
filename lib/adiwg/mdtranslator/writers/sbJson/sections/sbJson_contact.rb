# sbJson 1.0 writer

# History:
#  Stan Smith 2017-05-25 refactored for mdJson/mdTranslator 2.0
#  Josh Bradley original script

require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module SbJson

            module Contacts

               # find all the responsibility role/party pairs in intObj
               def self.nested_obj_by_element(obj, ele)
                  aCollected = []
                  obj.each do |key, value|
                     if key == ele.to_sym
                        aCollected << obj
                     elsif obj.is_a?(Array)
                        if key.respond_to?(:each)
                           aReturn = nested_obj_by_element(key, ele)
                           aCollected = aCollected.concat(aReturn) unless aReturn.empty?
                        end
                     elsif obj[key].respond_to?(:each)
                        aReturn = nested_obj_by_element(value, ele)
                        aCollected = aCollected.concat(aReturn) unless aReturn.empty?
                     end
                  end
                  aCollected
               end

               def self.build(intObj)

                  # gather all responsibility objects in intObj
                  aResponsibility = nested_obj_by_element(intObj, 'roleName')

                  a=1
                  # Jbuilder.new do |json|
                  #    if intObj[:internal]
                  #       json.nil!
                  #    else
                  #       type = intObj[:indName].nil? ? 'organization' : 'person'
                  #       json.name intObj[:indName] || intObj[:orgName]
                  #       json.contactType type
                  #       json.type intObj[:primaryRole]
                  #       json.email intObj[:address][:eMailList][0] unless intObj[:address].empty?
                  #       json.organization type == 'person' ? {:displayText => intObj[:orgName]} : nil
                  #       json.primaryLocation do
                  #          json.officePhone intObj[:phones].collect {|ph|
                  #             ph[:phoneNumber] if ph[:phoneServiceType] == 'voice'
                  #          }.reject(&:nil?).first
                  #          json.faxPhone intObj[:phones].collect {|ph|
                  #             ph[:phoneNumber] if ph[:phoneServiceType] == 'fax'
                  #          }.reject(&:nil?).first
                  #          json.streetAddress do
                  #             add = intObj[:address]
                  #             unless [:deliveryPoints].empty?
                  #                json.line1 add[:deliveryPoints][0]
                  #                json.line2 add[:deliveryPoints][1]
                  #             end
                  #             json.city add[:city]
                  #             json.state add[:adminArea]
                  #             json.zip add[:postalCode]
                  #             json.country add[:country]
                  #          end unless intObj[:address].empty?
                  #       end
                  #    end
                  # end

               end # build

            end # Module Contacts

         end
      end
   end
end
