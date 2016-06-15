require 'jbuilder'

module ADIWG
  module Mdtranslator
    module Writers
      module SbJson
        module Base
          def json_map(collection = [], _class)
            if collection.nil? || collection.empty?
              return nil
            else
              collection.map { |item| _class.build(item).attributes! }
            end
          end
        end
      end
    end
  end
end
