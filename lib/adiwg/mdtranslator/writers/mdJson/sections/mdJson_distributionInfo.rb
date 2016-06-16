require 'jbuilder'
require_relative 'mdJson_base'
require_relative 'mdJson_responsibleParty'
require_relative 'mdJson_format'
require_relative 'mdJson_transferOption'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson
        module DistributionInfo
          extend MdJson::Base

          def self.build(intObj)
            Jbuilder.new do |json|
              json.distributorContact ResponsibleParty.build(intObj[:distContact])
              json.distributionOrderProcess(intObj[:distOrderProcs]) do |dpo|
                json.fees dpo[:fees]
                json.plannedAvailabilityDateTime dpo[:plannedDateTime][:dateTime] unless dpo[:plannedDateTime].nil?
                json.orderingInstructions dpo[:orderInstructions]
                json.turnaround dpo[:turnaround]
            end unless intObj[:distOrderProcs].empty?
              json.distributorFormat json_map(intObj[:distFormats], Format)
              json.distributorTransferOptions json_map(intObj[:distTransOptions], TransferOption)
            end
          end
        end
      end
    end
  end
end
