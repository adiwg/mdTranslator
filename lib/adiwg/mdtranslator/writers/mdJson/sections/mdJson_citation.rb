require 'jbuilder'
require_relative 'mdJson_base'
require_relative 'mdJson_resourceIdentifier'
require_relative 'mdJson_onlineResource'
require_relative 'mdJson_dateTime'
require_relative 'mdJson_responsibleParty'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson
        module Citation
          extend MdJson::Base

          def self.build(cite)
            unless cite.nil? || cite.empty?
              Jbuilder.new do |json|
                json.title cite[:citTitle]
                json.alternateTitle cite[:citAltTitle]
                json.date json_map(cite[:citDate], DateTime) unless cite[:citDate].empty?
                json.edition cite[:citEdition]
                json.identifier json_map(cite[:citResourceIds], ResourceIdentifier)
                json.responsibleParty json_map(cite[:citResponsibleParty], ResponsibleParty)
                json.presentationForm(cite[:citResourceForms]) unless cite[:citResourceForms].empty?
                json.onlineResource json_map(cite[:citOlResources], OnlineResource)
              end
            end
          end
        end
      end
    end
  end
end
