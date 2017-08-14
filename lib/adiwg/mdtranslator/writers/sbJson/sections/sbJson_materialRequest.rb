# sbJson 1.0 writer

# History:
#  Stan Smith 2017-05-25 original script

require_relative 'sbJson_codelists'

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
                           sbRole = Codelists.codelist_adiwg2sb('role_adiwg2sb', role)
                           sbRole = sbRole.nil? ? role : sbRole
                           aParties = hDistributor[:contact][:parties]
                           aParties.each do |hParty|
                              contactIndex = hParty[:contactIndex]
                              unless contactIndex.nil?
                                 hContact = ADIWG::Mdtranslator::Writers::SbJson.get_contact_by_index(contactIndex)
                                 unless hContact.empty?
                                    name = hContact[:name]
                                    if instructions.nil?
                                       materialRequest += name + '(' + sbRole + '); '
                                    else
                                       materialRequest += name + '(' + sbRole + ' - ' + instructions + '); '
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
