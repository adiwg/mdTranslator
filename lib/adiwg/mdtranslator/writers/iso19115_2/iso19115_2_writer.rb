# Writer - internal data structure to ISO 19115-2:2009

# History:
#   Stan Smith 2016-11-14 refactor for mdJson/mdTranslator 2.0
#   Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#   Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#   Stan Smith 2015-06-11 change all codelists to use 'class_codelist' method
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#   Stan Smith 2014-06-04 add internal object pre-scan to create extents
#   ... for geometry supplemental information
# 	Stan Smith 2013-08-10 original script

require 'builder'
require_relative 'classes/class_miMetadata'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            def self.startWriter(intObj, hResponseObj)

               # make contact available to the instance
               @contacts = intObj[:contacts]

               # set the format of the output file based on the writer specified
               hResponseObj[:writerOutputFormat] = 'xml'
               hResponseObj[:writerVersion] = ADIWG::Mdtranslator::Writers::Iso19115_2::VERSION

               # create new XML document
               xml = Builder::XmlMarkup.new(indent: 3)

               # start writing the ISO 19115-2 XML record
               metadataWriter = MI_Metadata.new(xml, hResponseObj)
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

         end
      end
   end
end
