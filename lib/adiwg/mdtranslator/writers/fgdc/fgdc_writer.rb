# Writer - internal data structure to FGDC CSDGM FGDC-STD-001-1998

# History:
#  Stan Smith 2017-11-16 original script

require 'builder'
require_relative 'version'
require_relative 'classes/class_fgdc'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            def self.startWriter(intObj, responseObj, whichDict: 0)

               # make contacts and domains available to the instance
               @contacts = intObj[:contacts]

               # set the format of the output file based on the writer
               responseObj[:writerOutputFormat] = 'xml'
               responseObj[:writerVersion] = ADIWG::Mdtranslator::Writers::Fgdc::VERSION

               # create new XML document
               xml = Builder::XmlMarkup.new(indent: 3)

               # start writing the FGDC XML record
               metadataWriter = Fgdc.new(xml, responseObj)
               metadata = metadataWriter.writeXML(intObj)

               return metadata

            end

            # find contact and return the contact hash
            def self.get_contact(contactId)
               @contacts.each do |contact|
                  if contact[:contactId] == contactId
                     return contact
                  end
               end
               return {}
            end

            def self.find_responsibility(aResponsibility, roleName)
               aParties = []
               aResponsibility.each do |hRParty|
                  if hRParty[:roleName] == roleName
                     hRParty[:parties].each do |hParty|
                        aParties << hParty[:contactId]
                     end
                  end
               end
               aParties = aParties.uniq
               return aParties
            end

         end
      end
   end
end

