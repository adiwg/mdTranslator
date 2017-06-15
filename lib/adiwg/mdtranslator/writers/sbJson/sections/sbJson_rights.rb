# sbJson 1.0 writer

# History:
#  Stan Smith 2017-05-22 original script

require_relative 'sbJson_codelists'

module ADIWG
   module Mdtranslator
      module Writers
         module SbJson

            module Rights

               def self.build(aConstraints)

                  rights = ''

                  aConstraints.each do |hConstraint|
                     if hConstraint[:type] = 'legal'
                        unless hConstraint[:legalConstraint].empty?

                           # map legal constraint usage restriction codes
                           hConstraint[:legalConstraint][:useCodes].each do |code|
                              codeDef = Codelists.get_code_definition('iso_restriction', code)
                              unless codeDef.nil?
                                 rights += code + ' - ' + codeDef + '; '
                              end
                           end

                           # map other legal constraints
                           hConstraint[:legalConstraint][:otherCons].each do |con|
                              rights += con + '; '
                           end

                        end
                     end
                  end

                  # clean off last semicolon
                  if rights.length > 2
                     rights = rights[0...-2]
                  end

                  rights

               end

            end

         end
      end
   end
end
