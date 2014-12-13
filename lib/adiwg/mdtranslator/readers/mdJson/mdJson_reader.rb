# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-08-09 original script
# 	Stan Smith 2013-08-19 split out contacts to module_contacts
# 	Stan Smith 2013-08-23 split out metadata to module_metadata
#	Stan Smith 2014-04-23 add json schema version to internal object
#   Stan Smith 2014-06-05 capture an test json version
#   Stan Smith 2014-07-03 resolve require statements using Mdtranslator.reader_module
#   Stan Smith 2014-07-08 moved json schema version testing to 'adiwg_1_get_version'
#   Stan Smith 2014-08-18 add json name/version to internal object
#   Stan Smith 2014-12-01 add data dictionary
#   Stan Smith 2014-12-03 changed class name to MdJsonReader from AdiwgJsonReader
#   Stan Smith 2014-12-11 refactored to handle namespacing readers and writers

require 'json'

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                def self.inspectFile(file)
                    # set anticipated format of file in $response
                    $response[:readerFormat] = 'json'

                    # receive json file into ruby hash
                    parseJson(file)
                    if !$response[:readerStructurePass]
                        return false
                    end

                    # check mdJson version name
                    checkVersionName
                    if !$response[:readerStructurePass]
                        return false
                    end

                    # check mdJson version number
                    checkVersionNumber
                    if !$response[:readerStructurePass]
                        return false
                    end

                    # set reader namespace
                    $ReaderNS = ADIWG::Mdtranslator::Readers::MdJson

                    # validate file against mdJson schema definition
                    require 'adiwg/mdtranslator/readers/mdJson/mdJson_validator'
                    $ReaderNS.validate(file)
                    if !$response[:readerValidationPass]
                        return false
                    end

                    # unpack mdJson file
                    require readerModule('module_mdJson')
                    intObj = $ReaderNS.unpack(@hMdJson)
                    return intObj

                end

                def self.parseJson(file)
                    # validate the input file structure
                    # test for valid json syntax by attempting to parse the file
                    begin
                        @hMdJson = JSON.parse(file)
                        $response[:readerStructurePass] = true
                    rescue JSON::JSONError => err
                        $response[:readerStructurePass] = false
                        $response[:readerStructureMessages] << err
                        return
                    end
                end

                def self.checkVersionName
                    # find version name on the input json file
                    if @hMdJson.has_key?('version')
                        hVersion = @hMdJson['version']
                    else
                        $response[:readerStructurePass] = false
                        $response[:readerStructureMessages] << 'The input file is missing the version:{} block.'
                        return
                    end

                    # check the version name
                    if hVersion.has_key?('name')
                        s = hVersion['name']
                        if !s.nil?
                            $response[:readerFound] = s
                        else
                            $response[:readerStructurePass] = false
                            $response[:readerStructureMessages] << 'The input file version name is missing.'
                            return
                        end
                    else
                        $response[:readerStructurePass] = false
                        $response[:readerStructureMessages] << "The input file version:{} block is missing the 'name' attribute."
                        return
                    end

                    # check the version name is 'mdJson'
                    if s != 'mdJson'
                        $response[:readerStructurePass] = false
                        $response[:readerStructureMessages] << "The mdTranslator reader expected the input file version name to be 'mdJson'."
                        $response[:readerStructureMessages] << "Version name found was: '#{s}'."
                        return
                    end
                end

                def self.checkVersionNumber
                    # find version number on the input json file
                    hVersion = @hMdJson['version']
                    if hVersion.has_key?('version')
                        s = hVersion['version']
                        if !s.nil?
                            $response[:readerVersionFound] = s
                        end
                    else
                        $response[:readerStructurePass] = false
                        $response[:readerStructureMessages] << "The input file version:{} block is missing the 'version' number attribute."
                        return
                    end

                    # test the reader version requested is supported
                    # remove maintenance release number first
                    # ... then look for a module folder name ending with the requested version
                    # ... example: 'modules_1.2'
                    aVersionParts = s.split('.')
                    if aVersionParts.length >= 2
                        readerVersion = aVersionParts[0] +'.' + aVersionParts[1]
                        dir = File.join(File.dirname(__FILE__), 'modules_' + readerVersion)
                        if !File.directory?(dir)
                            $response[:readerStructurePass] = false
                            $response[:readerStructureMessages] << 'The input file version is not supported.'
                            $response[:readerStructureMessages] << "mdJson version requested was '#{s}'"
                            return
                        end
                        $response[:readerVersionUsed] = readerVersion
                    else
                        $response[:readerStructurePass] = false
                        $response[:readerStructureMessages] << 'The input file version number must be in the form MAJOR.MINOR.PATCH, e.g. 1.2.3'
                        $response[:readerStructureMessages] << 'Note the PATCH number is optional.'
                        return
                    end
                end

                # require modules for the requested version
                def self.readerModule(moduleName)
                    dir = File.join(File.dirname(__FILE__), 'modules_' + $response[:readerVersionUsed])
                    file = File.join(dir, moduleName)

                    # test for the existance of the module in the current mdJson version directory
                    if !File.exist?(File.join(dir, moduleName + '.rb'))
                        # file not found
                        # ... look for module in previous version directory
                        # ... note: no previous version directories exist yet

                        # no prior version directory found
                        # ... file not found
                        return nil
                    end
                    return file
                end

                # return path to readers and writers
                def self.path_to_resources
                    File.join(File.dirname(File.expand_path(__FILE__)), 'mdtranslator')
                end

                # return reader readme text
                def self.get_reader_readme(reader)
                    readmeText = 'No text found'
                    path = File.join(path_to_resources, 'readers', reader, 'readme.md')
                    if File.exist?(path)
                        file = File.open(path, 'r')
                        readmeText = file.read
                        file.close
                    end
                    return readmeText
                end

                def self.reader_module(moduleName, version)
                end

            end
        end
    end
end
