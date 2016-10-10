# Reader - ADIwg JSON V1 to internal data structure

# History:
#   Stan Smith 2016-10-09 modify 'findContact' to also return contact index and type
#   Stan Smith 2016-10-07 refactored 'readerModule' to remove mdJson version checking
#   Stan Smith 2015-07-14 added support for mdJson version numbers
#   Stan Smith 2015-07-14 refactored to remove global namespace constants
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-06-12 added method to lookup contact in contact array
#   Stan Smith 2014-12-11 refactored to handle namespacing readers and writers
#   Stan Smith 2014-12-03 changed class name to MdJsonReader from AdiwgJsonReader
#   Stan Smith 2014-12-01 add data dictionary
#   Stan Smith 2014-08-18 add json name/version to internal object
#   Stan Smith 2014-07-08 moved json schema version testing to 'adiwg_1_get_version'
#   Stan Smith 2014-07-03 resolve require statements using Mdtranslator.reader_module
#   Stan Smith 2014-06-05 capture an test json version
#	Stan Smith 2014-04-23 add json schema version to internal object
# 	Stan Smith 2013-08-23 split out metadata to module_metadata
# 	Stan Smith 2013-08-19 split out contacts to module_contacts
# 	Stan Smith 2013-08-09 original script

require 'json'
require_relative 'mdJson_validator'

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                def self.readFile(file, responseObj)

                    # set reference to responseObj for use throughout this module
                    @responseObj = responseObj

                    # receive json file into ruby hash
                    parseJson(file)
                    if !@responseObj[:readerStructurePass]
                        return false
                    end

                    # set format of file in $response
                    @responseObj[:readerFormat] = 'json'

                    # check mdJson version name
                    checkVersionName
                    if !@responseObj[:readerStructurePass]
                        return false
                    end

                    # check mdJson version number
                    checkVersionNumber
                    if !@responseObj[:readerStructurePass]
                        return false
                    end

                    # validate file against mdJson schema definition
                    validate(file, @responseObj)
                    if !@responseObj[:readerValidationPass]
                        return false
                    end

                    # load mdJson file into internal object
                    require readerModule('module_mdJson')

                    # instance classes needed in script
                    intMetadataClass = InternalMetadata.new

                    # create new internal metadata container for the reader
                    @intObj = intMetadataClass.newBase

                    ADIWG::Mdtranslator::Readers::MdJson.unpack(@intObj, @hMdJson, @responseObj)
                    return @intObj

                end

                def self.parseJson(file)
                    # validate the input file structure
                    # test for valid json syntax by attempting to parse the file
                    begin
                        @hMdJson = JSON.parse(file)
                        @responseObj[:readerStructurePass] = true
                    rescue JSON::JSONError => err
                        @responseObj[:readerStructurePass] = false
                        @responseObj[:readerStructureMessages] << 'JSON Parsing Failed - see following message(s):\n'
                        @responseObj[:readerStructureMessages] << err.to_s.slice(0,300)
                    end
                end

                def self.checkVersionName
                    # find version name on the input json file
                    if @hMdJson.has_key?('version')
                        hVersion = @hMdJson['version']
                    else
                        @responseObj[:readerStructurePass] = false
                        @responseObj[:readerStructureMessages] << 'Invalid input file schema declaration - see following message(s):\n'
                        @responseObj[:readerStructureMessages] << 'The input file is missing the version:{} block.'
                        return
                    end

                    # check the version name
                    if hVersion.has_key?('name')
                        s = hVersion['name']
                        if s.nil?
                            @responseObj[:readerStructurePass] = false
                            @responseObj[:readerStructureMessages] << 'Invalid input file schema declaration - see following message(s):\n'
                            @responseObj[:readerStructureMessages] << 'The input file version: => name: is missing.'
                            return
                        end
                    else
                        @responseObj[:readerStructurePass] = false
                        @responseObj[:readerStructureMessages] << 'Invalid input file schema declaration - see following message(s):\n'
                        @responseObj[:readerStructureMessages] << "The input file version:{} block is missing the 'name:' attribute."
                        return
                    end

                    # check the version name is 'mdJson'
                    if s != 'mdJson'
                        @responseObj[:readerStructurePass] = false
                        @responseObj[:readerStructureMessages] << 'Invalid input file schema declaration - see following message(s):\n'
                        @responseObj[:readerStructureMessages] << "The mdTranslator reader expected the input file version: name: to be 'mdJson'."
                        @responseObj[:readerStructureMessages] << "Version name found was: '#{s}'."
                    end
                end

                def self.checkVersionNumber
                    # find version number on the input json file
                    hVersion = @hMdJson['version']
                    if hVersion.has_key?('version')
                        s = hVersion['version']
                        if !s.nil?
                            @responseObj[:readerVersionRequested] = s
                        end
                    else
                        @responseObj[:readerStructurePass] = false
                        @responseObj[:readerStructureMessages] << 'Invalid input file schema declaration - see following message(s):\n'
                        @responseObj[:readerStructureMessages] << "The input file version:{} block is missing the 'version:' number attribute."
                        return
                    end

                    # split the version number into its parts
                    aReqVersion = s.split('.')

                    reqMajor = 0
                    if !aReqVersion[0].nil?
                        reqMajor = aReqVersion[0]
                    end

                    # test if the requested reader major version is supported
                    # look for a folder with modules for the major version number
                    dirName = File.join(File.dirname(__FILE__), 'modules_v' + reqMajor)
                    if !File.directory?(dirName)
                        @responseObj[:readerStructurePass] = false
                        @responseObj[:readerStructureMessages] << 'Invalid input file schema declaration - see following message(s):\n'
                        @responseObj[:readerStructureMessages] << 'A reader for the requested version is not supported.'
                        @responseObj[:readerStructureMessages] << "mdJson version requested was '#{s}'"
                        return false
                    end

                    # the requested major version is supported
                    # get the full version number for this major version of mdJson
                    require File.join(dirName, 'version')
                    curVersion = ADIWG::Mdtranslator::Readers::MdJson::VERSION
                    @responseObj[:readerVersionUsed] = curVersion
                    aCurVersion = curVersion.split('.')
                    curMinor = aCurVersion[1]

                    # test that minor version number is not exceeded
                    reqMinor = 0
                    if !aReqVersion[1].nil?
                        reqMinor = aReqVersion[1]
                        if curMinor < reqMinor
                            @responseObj[:readerStructurePass] = false
                            @responseObj[:readerStructureMessages] << 'Invalid input file schema declaration - see following message(s):\n'
                            @responseObj[:readerStructureMessages] << 'The requested reader minor version is not supported.'
                            @responseObj[:readerStructureMessages] << "mdJson version requested was '#{s}'"
                            return false
                        end
                    end

                end

                # find the array pointer for a contact
                def self.findContact(contactId)
                    contactIndex = nil
                    contactType = nil
                    i = 0
                    @intObj[:contacts].each do |contact|
                        if contact[:contactId] == contactId
                            contactIndex = i
                            if contact[:isOrganization]
                                contactType = 'organization'
                            else
                                contactType = 'individual'
                            end
                        end
                        i += 1
                    end

                    return contactIndex, contactType
                end

                # build path to reader modules
                def self.readerModule(moduleName)
                    dirName = File.join(File.dirname(__FILE__), 'modules')
                    fileName = File.join(dirName, moduleName)

                    # test for the existence of the module in the current mdJson directory
                    if File.exist?(fileName + '.rb')
                        return fileName
                    else
                        return nil
                    end
                end

            end
        end
    end
end
