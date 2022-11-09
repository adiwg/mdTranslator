require 'jbuilder'
require_relative 'mdJson_scope'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson

        module DescriptiveResult
          def self.build(hResult)
            Jbuilder.new do |json|
              json.dateTime hResult[:dateTime]
              json.scope Scope.build(hResult[:scope]) unless hResult[:scope].nil?
              json.statement hResult[:statement]
            end
          end

        end

      end
    end
  end
end
