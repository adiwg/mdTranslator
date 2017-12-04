# mdJson 2.0 writer

# History:
#   Stan Smith 2017-03-10 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'jbuilder'
require 'rubygems'
require_relative 'version'
require_relative 'sections/mdJson_mdJson'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            def self.startWriter(intObj, responseObj)

               @intObj = intObj

               # set output flag for null properties
               Jbuilder.ignore_nil(!responseObj[:writerShowTags])

               # set the format of the output file based on the writer specified
               responseObj[:writerOutputFormat] = 'json'
               schemaVersion = Gem::Specification.find_by_name('adiwg-mdjson_schemas').version.to_s
               responseObj[:writerVersion] = schemaVersion

               # write the mdJson metadata record
               metadata = MdJson.build(intObj, responseObj)

               # set writer pass to true if no messages
               # false or warning will be set by code that places the message
               responseObj[:writerPass] = true if responseObj[:writerMessages].empty?

               # generated mdJson is not validated against schema
               # mdJson record may be partial
               # or mdJson may be conversion from other format destined for mdEditor

               # encode the metadata target as JSON
               metadata.target!

            end

            # ignore jBuilder object mapping when array is empty
            def self.json_map(collection = [], _class)
               if collection.nil? || collection.empty?
                  return nil
               else
                  collection.map { |item| _class.build(item).attributes! }
               end
            end

         end
      end
   end
end
