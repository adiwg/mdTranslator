require 'jbuilder'
require_relative 'version'
require_relative 'sections/mdJson_contact'
require_relative 'sections/mdJson_metadata'
require_relative 'sections/mdJson_dictionary'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson
        def self.startWriter(_intObj, responseObj, _paramsObj)
          @intObj = _intObj

          # set output flag for null properties
          Jbuilder.ignore_nil(!responseObj[:writerShowTags])
          # set the format of the output file based on the writer specified
          responseObj[:writerFormat] = 'json'
          responseObj[:writerVersion] = ADIWG::Mdtranslator::Writers::MdJson::VERSION

          # version
          metadata = Jbuilder.new do |json|
            json.version do
              json.name 'mdJson'
              json.version responseObj[:writerVersion]
            end

            json.contact _intObj[:contacts].map { |obj| Contact.build(obj).attributes! }
            json.metadata Metadata.build(_intObj[:metadata])
            json.dataDictionary _intObj[:dataDictionary].map { |obj| Dictionary.build(obj).attributes! }
          end

          # set writer pass to true if no messages
          # false or warning will be set by code that places the message
          responseObj[:writerPass] = true if responseObj[:writerMessages].empty?

          # j = JSON.parse(metadata.target!)
          # puts JSON.pretty_generate(j)

          metadata.target!
        end

        # find contact in contact array and return the contact hash
        def self.getContact(contactID)
          @intObj[:contacts].each do |hContact|
            return hContact if hContact[:contactId] == contactID
          end
          {}
        end
      end
    end
  end
end
