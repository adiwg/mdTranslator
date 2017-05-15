# sbJson 1.0 writer

# History:
#  Stan Smith 2017-05-12 refactored for mdJson/mdTranslator 2.0
#  Josh Bradley original script

require 'jbuilder'
require 'uuidtools'
require_relative 'sbJson_id'

module ADIWG
   module Mdtranslator
      module Writers
         module SbJson

            def self.build(intObj, responseObj)

               Jbuilder.new do |json|

                  # id
                  json.id Id.build(intObj)

               end

            end

         end
      end
   end
end
