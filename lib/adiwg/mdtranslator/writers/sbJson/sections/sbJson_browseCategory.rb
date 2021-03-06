# sbJson 1.0 writer browse categories

# History:
#  Stan Smith 2017-05-31 original script

require 'jbuilder'
require_relative 'sbJson_codelists'

module ADIWG
   module Mdtranslator
      module Writers
         module SbJson

            module BrowseCategory

               def self.build(aTypes)

                  aCategories = []

                  # always include a 'Data' browse category
                  aCategories << 'Data'

                  aTypes.each do |hType|
                     type = hType[:type]
                     sbType = Codelists.codelist_adiwg2sb('scope_adiwg2sb', type)
                     aCategories << sbType unless sbType.nil?
                  end

                  aCategories = aCategories.uniq

               end

            end

         end
      end
   end
end
