module ADIWG
    module Mdtranslator
        module Readers
            module SbJson

                module BrowseGraphic

                    def self.unpack(hBgraphic, responseObj)

                        # return nil object if input is empty
                        intBGraphic = nil
                        return if hBgraphic.empty?

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intBGraphic = intMetadataClass.newBrowseGraphic

                        # graphic - file name
                        if hBgraphic.has_key?('fileName')
                            s = hBgraphic['fileName']
                            if s != ''
                                intBGraphic[:bGName] = s
                            else
                                responseObj[:readerExecutionMessages] << 'Graphic overview name is empty'
                                responseObj[:readerExecutionPass] = false
                                return nil
                            end
                        else
                            responseObj[:readerExecutionMessages] << 'Graphic overview name is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # graphic - file description
                        if hBgraphic.has_key?('fileDescription')
                            s = hBgraphic['fileDescription']
                            if s != ''
                                intBGraphic[:bGDescription] = s
                            end
                        end

                        # graphic - file  type
                        if hBgraphic.has_key?('fileType')
                            s = hBgraphic['fileType']
                            if s != ''
                                intBGraphic[:bGType] = s
                            end
                        end

                        # graphic - web link
                        if hBgraphic.has_key?('fileUri')
                            s = hBgraphic['fileUri']
                            if s != ''
                                intBGraphic[:bGURI] = s
                            end
                        end

                        return intBGraphic
                    end

                end

            end
        end
    end
end
