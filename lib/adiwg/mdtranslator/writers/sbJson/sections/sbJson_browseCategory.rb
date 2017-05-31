# sbJson 1.0 writer

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

                  aTypes.each do |hType|
                     type = hType[:type]
                     sbType = Codelists.codelist_iso_to_sb('iso_sb_scope', :isoCode => type)
                     aCategories << sbType unless sbType.nil?
                  end

                  aCategories = aCategories.uniq

               end

            end

         end
      end
   end
end
