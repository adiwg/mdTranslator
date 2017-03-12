# mdJson 2.0 writer - base

# History:
#   Stan Smith 2017-03-10 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

# TODO delete this module

require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Base

               def json_map(collection = [], _class)
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
end
