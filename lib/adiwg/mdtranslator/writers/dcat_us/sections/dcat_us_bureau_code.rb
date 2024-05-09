require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module Dcat_us
            module BureauCode

               def self.build(intObj)
                
                    roles = intObj[:metadata][:resourceInfo][:citation][:responsibleParties]&.select { |party| party[:roleName] == 'bureau' }
                    bureaus = intObj[:contacts]&.select { |contact| contact[:externalIdentifier].any? { |id| id[:namespace] == 'bureauCode'} }

                    bureauCodes = []
                    unless roles.empty? || bureaus.empty?
                        roles.each do |bureau|
                            roleId = bureau[:parties][0][:contactId]
                            bureauId = bureau[:parties].any? { |party| party[:contactId] == roleId } ? roleId : nil
                            unless bureauId.nil?
                                bureauCodes << bureauId
                            end
                        end
                    end

                    return bureauCodes
                end
                
            end
         end
      end
   end
end
