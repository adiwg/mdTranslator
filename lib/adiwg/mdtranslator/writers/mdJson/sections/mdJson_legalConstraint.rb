# mdJson 2.0 writer - legal constraint

# History:
#   Stan Smith 2017-03-17 original script

# TODO complete

require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module LegalConstraint

               def self.build(hLegal)

                  Jbuilder.new do |json|
                     json.accessConstraint hLegal[:accessCodes] unless hLegal[:accessCodes].empty?
                     json.legalConstraint hLegal[:useCodes] unless hLegal[:useCodes].empty?
                     json.otherConstraint hLegal[:otherCons] unless hLegal[:otherCons].empty?
                  end

               end # build
            end # LegalConstraint

         end
      end
   end
end
