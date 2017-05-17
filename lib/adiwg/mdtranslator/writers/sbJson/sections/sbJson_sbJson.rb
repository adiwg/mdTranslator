# sbJson 1.0 writer

# History:
#  Stan Smith 2017-05-12 refactored for mdJson/mdTranslator 2.0
#  Josh Bradley original script

require 'jbuilder'
require_relative 'sbJson_id'
require_relative 'sbJson_citation'

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

                  # title / alternateTitles (incorporates subTitle)
                  unless hCitation.empty?
                     json.title hCitation[:title] unless hCitation[:title].nil?
                     json.alternateTitles hCitation[:alternateTitles] unless hCitation[:alternateTitles].empty?
                  end

                  # body / summary
                  json.body resourceInfo[:abstract] unless resourceInfo[:abstract].nil?
                  json.summary resourceInfo[:shortAbstract] unless resourceInfo[:shortAbstract].nil?

                  # citation
                  unless hCitation.empty?
                     json.citation Citation.build(hCitation)
                  end

               end

            end

         end
      end
   end
end
