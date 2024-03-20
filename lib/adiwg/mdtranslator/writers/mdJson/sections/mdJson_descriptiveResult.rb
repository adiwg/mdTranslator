require 'jbuilder'
require_relative 'mdJson_scope'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson

        module DescriptiveResult
          def self.build(hResult)
            Jbuilder.new do |json|
              json.dateTime hResult[:dateTime] unless hResult[:dateTime].nil?
              json.scope Scope.build(hResult[:scope]) unless hResult[:scope].empty?
              json.statement hResult[:statement] unless hResult[:statement].nil?
            end
          end

        end

      end
    end
  end
end
