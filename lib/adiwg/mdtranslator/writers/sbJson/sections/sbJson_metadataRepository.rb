# sbJson 1.0 writer metadata repository

# History:
#  Stan Smith 2017-06-06 original script

module ADIWG
   module Mdtranslator
      module Writers
         module SbJson

            module Repository

               def self.build(aRepositories)

                  repository = {}

                  aRepositories.each do |hRepo|
                     if hRepo[:repository] == 'data.gov'
                        repository[:repository] = hRepo[:repository]
                        repository[:title] = 'Data.gov'
                        unless hRepo[:citation].empty?
                           unless hRepo[:citation][:identifiers].empty?
                              repository[:identifier] = hRepo[:citation][:identifiers][0][:identifier]
                           end
                        end
                        repository[:metadataStandard] = hRepo[:metadataStandard]
                        break
                     end
                  end

                  if repository.empty?
                     return nil
                  end

                  repository

               end

            end

         end
      end
   end
end
