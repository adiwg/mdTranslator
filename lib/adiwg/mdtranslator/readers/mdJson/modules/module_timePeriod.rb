# unpack role extent
# Reader - ADIwg JSON to internal data structure

# History:
# 	Stan Smith 2016-10-08 original script

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_dateTime')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module RoleExtent

                    def self.unpack(hRoleEx, responseObj)

                        # return nil object if input is empty
                        if hRoleEx.empty?
                            responseObj[:readerExecutionMessages] << 'Role Extent object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intRoleEx = intMetadataClass.newRoleExtent

                        # role extent - description
                        if hRoleEx.has_key?('description')
                            if hRoleEx['description'] != ''
                                intRoleEx[:description] = hRoleEx['description']
                            end
                        end

                        # role extent - start dateTime
                        if hRoleEx.has_key?('startDateTime')
                            if hRoleEx['startDateTime'] != ''
                                intRoleEx[:startDateTime] = DateTime.unpack(hRoleEx['startDateTime'], responseObj)
                            end
                        end

                        # role extent - end dateTime
                        if hRoleEx.has_key?('endDateTime')
                            if hRoleEx['endDateTime'] != ''
                                intRoleEx[:endDateTime] = DateTime.unpack(hRoleEx['endDateTime'], responseObj)
                            end
                        end

                        return intRoleEx
                    end

                end

            end
        end
    end
end
