# sbJson 1.0 writer

# History:
#  Stan Smith 2017-05-23 original script

module ADIWG
   module Mdtranslator
      module Writers
         module SbJson

            module Provenance

               def self.build(hMetadataInfo)

                  aContacts = hMetadataInfo[:metadataContacts]
                  aDates = hMetadataInfo[:metadataDates]

                  hProvenance = {}
                  hProvenance[:dataSource] = 'generated using ADIwg mdTranslator ' + ADIWG::Mdtranslator::VERSION

                  aDates.each do |hDate|
                     if hDate[:dateType] == 'creation'
                        hProvenance[:dateCreated] = AdiwgDateTimeFun.stringFromDateObject(hDate)
                     end
                     if hDate[:dateType] == 'lastUpdate'
                        hProvenance[:lastUpdated] = AdiwgDateTimeFun.stringFromDateObject(hDate)
                     end
                  end

                  if hProvenance.empty?
                     return nil
                  end

                  hProvenance

               end

            end

         end
      end
   end
end
