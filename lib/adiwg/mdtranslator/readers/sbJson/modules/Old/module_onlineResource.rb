module ADIWG
    module Mdtranslator
        module Readers
            module SbJson

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
                            else
                                responseObj[:readerExecutionMessages] << 'Online Resource URI is missing'
                                responseObj[:readerExecutionPass] = false
                                return nil
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
