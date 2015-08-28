# ISO <<Class>> MD_ReferenceSystem
# writer
# output for ISO 19115-2 XML

# History:
# 	Stan Smith 2014-09-03 original script
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#   Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#   Stan Smith 2015-08-28 convert referenceSystem to resourceId and pass to RS_Identifier

require_relative 'class_resourceIdentifier'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class MD_ReferenceSystem

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(refSystem, refType)

                        # classes used
                        resIdClass =  RS_Identifier.new(@xml, @responseObj)

                        # convert reference system to RS_Identifier
                        intMetadataClass = InternalMetadata.new
                        hResId = intMetadataClass.newResourceId

                        hResId[:identifier] = refSystem
                        hResId[:identifierType] = refType

                        @xml.tag!('gmd:MD_ReferenceSystem') do
                            @xml.tag!('gmd:referenceSystemIdentifier') do
                                resIdClass.writeXML(hResId)
                            end
                        end

                    end

                end

            end
        end
    end
end
