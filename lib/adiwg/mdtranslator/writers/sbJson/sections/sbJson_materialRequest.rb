# sbJson 1.0 writer

# History:
#  Stan Smith 2017-05-25 original script

module ADIWG
   module Mdtranslator
      module Writers
         module SbJson

            module MaterialRequest

               def self.build(aDistribution)

                  materialRequest = ''

                  aDistribution.each do |hDistribution|
                     aDistributor = hDistribution[:distributor]
                     aDistributor.each do |hDistributor|
                        instructions = nil
                        unless hDistributor[:orderProcess].empty?
                           instructions = hDistributor[:orderProcess][0][:orderingInstructions]
                        end
                        unless hDistributor[:contact].empty?
                           role = hDistributor[:contact][:roleName]
                           aParties = hDistributor[:contact][:parties]
                           aParties.each do |hParty|
                              contactIndex = hParty[:contactIndex]
                              unless contactIndex.nil?
                                 hContact = ADIWG::Mdtranslator::Writers::SbJson.getContact(contactIndex)
                                 unless hContact.empty?
                                    name = hContact[:name]
                                    if instructions.nil?
                                       materialRequest += name + '(' + role + '); '
                                    else
                                       materialRequest += name + '(' + role + ' - ' + instructions + '); '
                                    end
                                 end
                              end
                           end
                        end
                     end
                  end

                  # clean off last semicolon
                  if materialRequest.length > 0
                     materialRequest = materialRequest[0...-2]
                  end

                  materialRequest

               end

            end

         end
      end
   end
end
