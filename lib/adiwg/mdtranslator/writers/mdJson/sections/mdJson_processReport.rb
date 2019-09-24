# mdJson 2.0 writer - process step report

# History:
#  Stan Smith 2019-09-24 original script

require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module ProcessStepReport

               @Namespace = ADIWG::Mdtranslator::Writers::MdJson

               def self.build(hReport)

                  Jbuilder.new do |json|
                     json.name hReport[:name]
                     json.description hReport[:description]
                     json.fileType hReport[:fileType]
                  end

               end # build
            end # ProcessStepReport

         end
      end
   end
end
