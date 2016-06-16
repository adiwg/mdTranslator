require 'json'
require_relative 'sbJson_validator'

module ADIWG
    module Mdtranslator
        module Readers
            module SbJson

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

                    # check sbJson version name
                    checkVersionName
                    if !@responseObj[:readerStructurePass]
                        return false
                    end

                    # check sbJson version number
                    checkVersionNumber
                    if !@responseObj[:readerStructurePass]
                        return false
                    end

                    #validate file against sbJson schema definition
                    validate(file, @responseObj)
                    if !@responseObj[:readerValidationPass]
                        return false
                    end

                    # load sbJson file into internal object
                    require readerModule('module_sbJson')
                    # instance classes needed in script
                    intMetadataClass = InternalMetadata.new

                    # create new internal metadata container for the reader
                    @intObj = intMetadataClass.newBase

                    #
                    ADIWG::Mdtranslator::Readers::SbJson.unpack(@intObj, @hSbJson, @responseObj)
                    return @intObj

                end

                def self.parseJson(file)
                    # validate the input file structure
                    # test for valid json syntax by attempting to parse the file
                    begin
                        @hSbJson = JSON.parse(file)

                        # faking the version since sbJSON has no support
                        @hSbJson['version'] = {
                          "name" => "sbJson",
                          "version" => "0.0.0"
                        }

                        @responseObj[:readerStructurePass] = true
                    rescue JSON::JSONError => err
                        @responseObj[:readerStructurePass] = false
                        @responseObj[:readerStructureMessages] << 'JSON Parsing Failed - see following message(s):\n'
                        @responseObj[:readerStructureMessages] << err.to_s.slice(0,300)
                    end
                end

                def self.checkVersionName
                    # find version name on the input json file
                    if @hSbJson.has_key?('version')
                        hVersion = @hSbJson['version']
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

                    # check the version name is 'sbJson'
                    if s != 'sbJson'
                        @responseObj[:readerStructurePass] = false
                        @responseObj[:readerStructureMessages] << 'Invalid input file schema declaration - see following message(s):\n'
                        @responseObj[:readerStructureMessages] << "The mdTranslator reader expected the input file version: name: to be 'sbJson'."
                        @responseObj[:readerStructureMessages] << "Version name found was: '#{s}'."
                    end
                end

                def self.checkVersionNumber
                    # find version number on the input json file
                    hVersion = @hSbJson['version']
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
                        @responseObj[:readerStructureMessages] << "sbJson version requested was '#{s}'"
                        return false
                    end

                    # the requested major version is supported
                    # get the full version number for this major version of sbJson
                    require File.join(dirName, 'version')
                    curVersion = ADIWG::Mdtranslator::Readers::SbJson::VERSION
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
                            @responseObj[:readerStructureMessages] << "sbJson version requested was '#{s}'"
                            return false
                        end
                    end

                end

                # find the array pointer for a contact
                def self.findContact(contactId)
                    pointer = nil
                    i = 0
                    @intObj[:contacts].each do |contact|
                        if contact[:contactId] == contactId
                            pointer = i
                        end
                        i += 1
                    end

                    return pointer
                end

                # require modules for the requested version
                def self.readerModule(moduleName)
                    majVersion = @responseObj[:readerVersionUsed].split('.')[0]
                    dirName = File.join(File.dirname(__FILE__), 'modules_v' + majVersion.to_s)
                    fileName = File.join(dirName, moduleName)

                    # test for the existance of the module in the current sbJson version directory
                    if !File.exist?(File.join(dirName, moduleName + '.rb'))
                        # file not found
                        # ... look for module in previous version directory
                        # ... note: no previous version directories exist yet

                        # no prior version directory found
                        # ... file not found
                        return nil
                    end

                    return fileName
                end

            end
        end
    end
end
