# unpack browse graphic
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-10-17 original script
# 	Stan Smith 2013-11-27 modified to process single browse graphic rather than array
#   Stan Smith 2014-04-28 modified attribute names to match json schema 0.3.0
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2014-12-24 added return if input hash is empty
#   Stan Smith 2014-12-30 refactored
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to remove global namespace constants

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

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
                            end
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