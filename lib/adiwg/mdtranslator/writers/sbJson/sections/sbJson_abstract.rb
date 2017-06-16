# sbJson 1.0 writer

# History:
#  Stan Smith 2017-06-16 original script

require 'kramdown'

module ADIWG
   module Mdtranslator
      module Writers
         module SbJson

            module Abstract

               def self.build(abstract)

                  abstract = Kramdown::Document.new(abstract).to_html
                  abstract.gsub!(/\n/, '')

               end

            end

         end
      end
   end
end
