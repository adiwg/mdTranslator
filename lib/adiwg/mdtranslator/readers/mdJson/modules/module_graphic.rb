# unpack graphic
# Reader - ADIwg JSON to internal data structure

# History:
#   Stan Smith 2016-10-12 refactored for mdJson 2.0
#   Stan Smith 2015-07-14 refactored to remove global namespace constants
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2014-12-30 refactored
#   Stan Smith 2014-12-24 added return if input hash is empty
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2014-04-28 modified attribute names to match json schema 0.3.0
# 	Stan Smith 2013-11-27 modified to process single browse graphic rather than array
# 	Stan Smith 2013-10-17 original script

require_relative 'module_onlineResource'
require_relative 'module_constraints'

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module Graphic

                    def self.unpack(hGraphic, responseObj)

                        # return nil object if input is empty
                        if hGraphic.empty?
                            responseObj[:readerExecutionMessages] << 'Graphic object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intGraphic = intMetadataClass.newGraphic

                        # graphic - file name (required)
                        if hGraphic.has_key?('fileName')
                            intGraphic[:graphicName] = hGraphic['fileName']
                        end
                        if intGraphic[:graphicName].nil? || intGraphic[:graphicName] == ''
                            responseObj[:readerExecutionMessages] << 'Graphic attribute fileName is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # graphic - file description
                        if hGraphic.has_key?('fileDescription')
                            if hGraphic['fileDescription'] != ''
                                intGraphic[:graphicDescription] = hGraphic['fileDescription']
                            end
                        end

                        # graphic - file  type
                        if hGraphic.has_key?('fileType')
                            if hGraphic['fileType'] != ''
                                intGraphic[:graphicType] = hGraphic['fileType']
                            end
                        end

                        # graphic - file  constraint []
                        if hGraphic.has_key?('fileConstraint')
                            hGraphic['fileConstraint'].each do |item|
                                unless item.empty?
                                    con = Constraints.unpack(item, responseObj)
                                    unless con.nil?
                                        intGraphic[:graphicConstraint] << con
                                    end
                                end
                            end
                        end

                        # graphic - online resource []
                        if hGraphic.has_key?('fileUri')
                            hGraphic['fileUri'].each do |item|
                                unless item.empty?
                                    uri = OnlineResource.unpack(item, responseObj)
                                    unless uri.nil?
                                        intGraphic[:graphicURI] << uri
                                    end
                                end
                            end
                        end

                        return intGraphic

                    end

                end

            end
        end
    end
end