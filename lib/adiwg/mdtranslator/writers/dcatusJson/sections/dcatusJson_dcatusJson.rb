
require 'jbuilder'
require 'rubygems'
require_relative 'dcatusJson_dataset'

module ADIWG
   module Mdtranslator
      module Writers
         module DcatusJson

            module DcatusJson

               def self.build(intObj, hResponseObj)

                  Jbuilder.new do |json|

                     json.conformsTo 'https://project-open-data.cio.gov/v1.1/schema'
                     json.type 'dcat:Catalog'
                     
                     # json.metadata Metadata.build(intObj[:metadata])
                     json.dataset Dataset.build(intObj[:metadata])

                  end
               end # build
            end # DcatusJson

         end
      end
   end
end
