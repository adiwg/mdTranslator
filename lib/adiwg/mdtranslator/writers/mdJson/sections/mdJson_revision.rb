require 'jbuilder'
require_relative 'mdJson_responsibleParty'
require_relative 'mdJson_dateTime'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Revision

               @Namespace = ADIWG::Mdtranslator::Writers::MdJson

               def self.build(hRevision)
                  # "required": ["description", "responsibleParty", "dateInfo"]
                  Jbuilder.new do |json|
                     json.description hRevision[:description]
                     json.responsibleParty @Namespace.json_map(hRevision[:responsibleParties], ResponsibileParty)
                     json.dateInfo @Namespace.json_map(hRevision[:dateInfo], DateTime)
                  end

               end
            end # Revision

         end
      end
   end
end
