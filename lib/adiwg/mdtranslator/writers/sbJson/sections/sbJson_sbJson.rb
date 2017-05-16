# sbJson 1.0 writer

# History:
#  Stan Smith 2017-05-12 refactored for mdJson/mdTranslator 2.0
#  Josh Bradley original script

require 'jbuilder'
require_relative 'sbJson_id'

module ADIWG
   module Mdtranslator
      module Writers
         module SbJson

            def self.build(intObj, responseObj)

               resourceInfo = intObj[:metadata][:resourceInfo]
               hCitation = resourceInfo[:citation]

               Jbuilder.new do |json|

                  # id
                  json.id Id.build(intObj)

                  # title
                  unless hCitation.empty?
                     json.title hCitation[:title] unless hCitation[:title].nil?
                  end

                  # alternateTitles (incorporates subTitle)
                  unless hCitation.empty?
                     json.alternateTitles hCitation[:alternateTitles] unless hCitation[:alternateTitles].empty?
                  end
               end

            end

         end
      end
   end
end
