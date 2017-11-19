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

            # find contact in contact array and return the contact hash
            def self.getContact(contactId)

               @contacts.each do |contact|
                  if contact[:contactId] == contactId
                     return contact
                  end
               end
               return {}

            end

            # find domain in domain array and return the domain hash
            def self.getDomain(domainId)

               @domains.each do |domain|
                  if domain[:domainId] == domainId
                     return domain
                  end
               end
               return {}

            end

         end
      end
   end
end

