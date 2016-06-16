require 'jbuilder'
require_relative 'mdJson_base'
require_relative 'mdJson_citation'
require_relative 'mdJson_responsibleParty'
require_relative 'mdJson_taxon'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson
        module Taxonomy
          extend MdJson::Base

          def self.build(intObj)
            Jbuilder.new do |json|
              json.classificationSystem json_map(intObj[:taxClassSys], Citation)
              json.taxonGeneralScope intObj[:taxGeneralScope]
              json.observer json_map(intObj[:taxObservers], ResponsibleParty)
              json.taxonomicProcedure intObj[:taxIdProcedures]
              json.voucher do
                voucher = intObj[:taxVoucher]
                json.specimen voucher.nil? ? nil : voucher[:specimen]
                json.repository voucher.nil? ? nil : ResponsibleParty.build(voucher[:repository])
              end
              json.taxonClass json_map(intObj[:taxClasses], Taxon)
            end
          end
        end
      end
    end
  end
end
