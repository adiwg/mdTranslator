# sbJson 1.0 writer

# History:
#  Stan Smith 2017-05-22 original script

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
