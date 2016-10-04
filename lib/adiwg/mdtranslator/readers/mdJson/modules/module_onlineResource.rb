# unpack online resources
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2016-10-03 original script

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module OnlineResource

                    def self.unpack(hOnlineRes, responseObj)

                        # return nil object if input is empty
                        if hOnlineRes.empty?
                            responseObj[:readerExecutionMessages] << 'OnlineResource object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intOLRes = intMetadataClass.newOnlineResource

                        # unpack the online resource
                        # resource - web link
                        if hOnlineRes.has_key?('uri')
                            s = hOnlineRes['uri']
                            if s != ''
                                intOLRes[:olResURI] = s
                            else
                                responseObj[:readerExecutionMessages] << 'Online Resource URI is missing'
                                responseObj[:readerExecutionPass] = false
                                return nil
                            end
                        end

                        # resource - web link protocol
                        if hOnlineRes.has_key?('protocol')
                            s = hOnlineRes['protocol']
                            if s != ''
                                intOLRes[:olResProtocol] = s
                            end
                        end

                        # resource - web link name
                        if hOnlineRes.has_key?('name')
                            s = hOnlineRes['name']
                            if s != ''
                                intOLRes[:olResName] = s
                            end
                        end

                        # resource - web link description
                        if hOnlineRes.has_key?('description')
                            s = hOnlineRes['description']
                            if s != ''
                                intOLRes[:olResDesc] = s
                            end
                        end

                        # resource - web link function
                        if hOnlineRes.has_key?('function')
                            s = hOnlineRes['function']
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
