# DCAT_US 1.0 writer

# History:
#  Johnathan Aspinwall 2023-06-22 original script

require 'jbuilder'
require_relative 'version'
require_relative 'sections/dcat_us_dcat_us'

module ADIWG
   module Mdtranslator
      module Writers
         module DCAT_US

            def self.startWriter(intObj, responseObj)
               @contacts = intObj[:contacts]

               # set output flag for null properties
               Jbuilder.ignore_nil(!responseObj[:writerShowTags])

               # set the format of the output file based on the writer specified
               responseObj[:writerOutputFormat] = 'json'
               responseObj[:writerVersion] = ADIWG::Mdtranslator::Writers::DCAT_US::VERSION

               # write the DCAT_US metadata record
               metadata = DCAT_US.build(intObj, responseObj)

               # set writer pass to true if no messages
               # false or warning state will be set by writer code
               responseObj[:writerPass] = true if responseObj[:writerMessages].empty?

               # encode the metadata target as JSON
               metadata.target!
            end

            # find contact in contact array and return the contact hash
            def self.get_contact_by_index(contactIndex)
               if @contacts[contactIndex]
                  return @contacts[contactIndex]
               end
               {}
            end

            # find contact in contact array and return the contact hash
            def self.get_contact_by_id(contactId)
               @contacts.each do |hContact|
                  if hContact[:contactId] == contactId
                     return hContact
                  end
               end
               {}
            end

            # find contact in contact array and return the contact index
            def self.get_contact_index_by_id(contactId)
               @contacts.each_with_index do |hContact, index|
                  if hContact[:contactId] == contactId
                     return index
                  end
               end
               {}
            end

            # ignore jBuilder object mapping when array is empty
            def self.json_map(collection = [], _class)
               if collection.nil? || collection.empty?
                  return nil
               else
                  collection.map { |item| _class.build(item).attributes! }
               end
            end

            # find all nested objects in 'obj' that contain the element 'ele'
            def self.nested_objs_by_element(obj, ele, excludeList = [])
               aCollected = []
               obj.each do |key, value|
                  skipThisOne = false
                  excludeList.each do |exclude|
                     if key == exclude.to_sym
                        skipThisOne = true
                     end
                  end
                  next if skipThisOne
                  if key == ele.to_sym
                     aCollected << obj
                  elsif obj.is_a?(Array)
                     if key.respond_to?(:each)
                        aReturn = nested_objs_by_element(key, ele, excludeList)
                        aCollected = aCollected.concat(aReturn) unless aReturn.empty?
                     end
                  elsif obj[key].respond_to?(:each)
                     aReturn = nested_objs_by_element(value, ele, excludeList)
                     aCollected = aCollected.concat(aReturn) unless aReturn.empty?
                  end
               end
               aCollected
            end

         end
      end
   end
end
