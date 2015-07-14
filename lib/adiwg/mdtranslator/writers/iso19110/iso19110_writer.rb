# Writer - internal data structure to ISO 19110:2003

# History:
# 	Stan Smith 2014-12-01 original script
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2015-03-02 added test and return for missing data dictionary
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#   Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS

require 'builder'
require 'date'
require 'uuidtools'
require_relative 'class_FCfeatureCatalogue'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19110

                def self.startWriter(intObj, responseObj)

                    # make internal object available to writer methods in this namespace
                    @intObj = intObj

                    # set the format of the output file based on the writer specified
                    responseObj[:writerFormat] = 'xml'
                    responseObj[:writerVersion] = ADIWG::Mdtranslator::VERSION

                    # test for a valid dataDictionary object in the internal object
                    aDictionaries = intObj[:dataDictionary]
                    if aDictionaries.length == 0
                        responseObj[:writerMessages] << 'Writer Failed - see following message(s):\n'
                        responseObj[:writerMessages] << 'No data dictionary was loaded from the input file'
                        responseObj[:writerPass] = false
                        return
                    end

                    # create new XML document
                    xml = Builder::XmlMarkup.new(indent: 3)
                    metadataWriter = FC_FeatureCatalogue.new(xml, responseObj)
                    metadata = metadataWriter.writeXML(intObj)

                    # set writer pass to true if no writer modules set it to false
                    # false or warning will be set by code that places the message
                    # load metadata into $response
                    if responseObj[:writerPass].nil?
                        responseObj[:writerPass] = true
                    end

                    return metadata
                end

                # find contact in contact array and return the contact hash
                def self.getContact(contactID)
                    @intObj[:contacts].each do |hContact|
                        if hContact[:contactId] == contactID
                            return hContact
                        end
                    end
                    return {}
                end

                # find domain in domain array and return the domain hash
                def self.getDomain(domainID)
                    @intObj[:dataDictionary][0][:domains].each do |hDomain|
                        if hDomain[:domainId] == domainID
                            return hDomain
                        end
                    end
                    return {}
                end

            end
        end
    end
end

