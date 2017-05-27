# sbJson 1.0 writer

# History:
#  Stan Smith 2017-05-26 original script

require 'jbuilder'
require_relative 'sbJson_codelists'

module ADIWG
   module Mdtranslator
      module Writers
         module SbJson

            module ContactList

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

                  # make a list of unique role/party contacts
                  aContactList = []
                  aResponsibility.each do |hResponsibility|
                     role = hResponsibility[:roleName]
                     hResponsibility[:parties].each do |hParty|
                        aContactList << { :role => role, :index => hParty[:contactIndex] }
                     end
                  end
                  aContactList = aContactList.uniq

               end # build

            end # Module Contacts

         end
      end
   end
end
