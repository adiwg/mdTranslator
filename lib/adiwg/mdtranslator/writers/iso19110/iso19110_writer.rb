# Writer - internal data structure to ISO 19110:2003

# History:
#  Stan Smith 2017-05-26 allow choice of which dictionary to translate
#                    ... fix bug when no dictionary is provided in mdJson
#  Stan Smith 2017-01-20 refactor for mdJson/mdTranslator 2.0
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#  Stan Smith 2015-03-02 added test and return for missing data dictionary
#  Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
# 	Stan Smith 2014-12-01 original script

require 'builder'
require_relative 'classes/class_fcFeatureCatalogue'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19110

            def self.startWriter(intObj, responseObj, whichDict: 0)

               # Iso19110 can only output one dictionary at a time
               # test if requested dictionary is in input file
               if intObj[:dataDictionaries][whichDict].nil?
                  responseObj[:writerMessages] << 'Dictionary is missing'
                  responseObj[:writerPass] = false
                  return nil
               end

               # make contacts and domains available to the instance
               @contacts = intObj[:contacts]
               dictionary = intObj[:dataDictionaries][whichDict]
               @domains = dictionary[:domains]

               # set the format of the output file based on the writer specified
               responseObj[:writerOutputFormat] = 'xml'
               responseObj[:writerVersion] = ADIWG::Mdtranslator::Writers::Iso19110::VERSION

               # create new XML document
               xml = Builder::XmlMarkup.new(indent: 3)

               # start writing the ISO 19110 XML record
               metadataWriter = FC_FeatureCatalogue.new(xml, responseObj)
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

