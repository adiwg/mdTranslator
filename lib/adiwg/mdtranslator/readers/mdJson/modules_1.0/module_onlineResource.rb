# unpack online resources
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-09-25 original script
#   Stan Smith 2014-04-23 modified for json 0.3.0
#   Stan Smith 2014-08-18 removed doi section for json 0.6.0
#   Stan Smith 2014-08-21 changed url to uri for json 0.6.0
#   Stan Smith 2014-12-10 changed to return nil intOlRes if input empty
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module OnlineResource

                    def self.unpack(hOlResource, responseObj)

                        # return nil object if input is empty
                        intOLRes = nil
                        return if hOlResource.empty?

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intOLRes = intMetadataClass.newOnlineResource

                        # unpack the online resource
                        # resource - web link
                        if hOlResource.has_key?('uri')
                            s = hOlResource['uri']
                            if s != ''
                                intOLRes[:olResURI] = s
                            end
                        end

                        # resource - web link protocol
                        if hOlResource.has_key?('protocol')
                            s = hOlResource['protocol']
                            if s != ''
                                intOLRes[:olResProtocol] = s
                            end
                        end

                        # resource - web link name
                        if hOlResource.has_key?('name')
                            s = hOlResource['name']
                            if s != ''
                                intOLRes[:olResName] = s
                            end
                        end

                        # resource - web link description
                        if hOlResource.has_key?('description')
                            s = hOlResource['description']
                            if s != ''
                                intOLRes[:olResDesc] = s
                            end
                        end

                        # resource - web link function
                        if hOlResource.has_key?('function')
                            s = hOlResource['function']
                            if s != ''
                                intOLRes[:olResFunction] = s
                            end
                        end

                        return intOLRes
                    end

                end

            end
        end
    end
end
