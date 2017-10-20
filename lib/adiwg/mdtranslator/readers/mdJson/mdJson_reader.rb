# mdJson reader - process and direct mdJson ingest to internal data structure

# History:
#  Stan Smith 2016-11-12 refactor for mdTranslator 2.0
#  Stan Smith 2016-10-09 modify 'findContact' to also return contact index and type
#  Stan Smith 2016-10-07 refactored 'readerModule' to remove mdJson version checking
#  Stan Smith 2015-07-14 added support for mdJson version numbers
#  Stan Smith 2015-07-14 refactored to remove global namespace constants
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#  Stan Smith 2015-06-12 added method to lookup contact in contact array
#  Stan Smith 2014-12-11 refactored to handle namespacing readers and writers
#  Stan Smith 2014-12-03 changed class name to MdJsonReader from AdiwgJsonReader
#  Stan Smith 2014-12-01 add data dictionary
#  Stan Smith 2014-08-18 add json name/version to internal object
#  Stan Smith 2014-07-08 moved json schema version testing to 'adiwg_1_get_version'
#  Stan Smith 2014-07-03 resolve require statements using Mdtranslator.reader_module
#  Stan Smith 2014-06-05 capture an test json version
#	Stan Smith 2014-04-23 add json schema version to internal object
# 	Stan Smith 2013-08-23 split out metadata to module_metadata
# 	Stan Smith 2013-08-19 split out contacts to module_contacts
# 	Stan Smith 2013-08-09 original script

require 'json'
require_relative 'mdJson_validator'
require_relative 'version'
require_relative 'modules/module_mdJson'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            def self.readFile(file, hResponseObj)

               # parse mdJson file
               begin
                  hMdJson = JSON.parse(file)
               rescue JSON::JSONError => err
                  hResponseObj[:readerStructureMessages] << 'Parsing mdJson Failed - see following message(s):\n'
                  hResponseObj[:readerStructureMessages] << err.to_s.slice(0, 300)
                  hResponseObj[:readerStructurePass] = false
                  return {}
               end

               # file must contain an mdJson object
               if hMdJson.empty?
                  hResponseObj[:readerStructureMessages] << 'mdJson object is empty'
                  hResponseObj[:readerStructurePass] = false
                  return {}
               end

               # schema - (required)
               unless hMdJson.has_key?('schema')
                  hResponseObj[:readerStructureMessages] << 'mdJson is missing schema object'
                  hResponseObj[:readerStructurePass] = false
                  return {}
               end

               # schema - name (required) (must = 'mdJson')
               unless hMdJson['schema'].has_key?('name')
                  hResponseObj[:readerStructureMessages] << 'mdJson schema:name attribute is missing'
                  hResponseObj[:readerStructurePass] = false
                  return {}
               end
               schemaName = hMdJson['schema']['name']
               if schemaName.nil? || schemaName == ''
                  hResponseObj[:readerStructureMessages] << 'mdJson schema name is missing'
                  hResponseObj[:readerStructurePass] = false
                  return {}
               end
               unless schemaName.downcase == 'mdjson'
                  hResponseObj[:readerStructureMessages] << "mdJson schema name is '#{schemaName}', should be mdJson"
                  hResponseObj[:readerStructurePass] = false
                  return {}
               end

               # schema - version (required)
               unless hMdJson['schema'].has_key?('version')
                  hResponseObj[:readerStructureMessages] << 'mdJson schema:version attribute is missing'
                  hResponseObj[:readerStructurePass] = false
                  return {}
               end
               requestedVersion = hMdJson['schema']['version']
               if requestedVersion.nil? || requestedVersion == ''
                  hResponseObj[:readerStructureMessages] << 'mdJson schema version is missing'
                  hResponseObj[:readerStructurePass] = false
                  return {}
               end

               # schema - 2.0.0 =< requested version =< current version
               currentVersion = ADIWG::Mdtranslator::Readers::MdJson::VERSION
               hResponseObj[:readerVersionRequested] = requestedVersion
               hResponseObj[:readerVersionUsed] = currentVersion
               aCurVersion = currentVersion.split('.')
               aReqVersion = requestedVersion.split('.')
               approved = false
               if aReqVersion[0] == aCurVersion[0]
                  if aReqVersion[1] <= aCurVersion[1]
                     approved = true
                  end
               end
               unless approved
                  hResponseObj[:readerStructureMessages] << "mdJson schema version '#{requestedVersion}' is not supported"
                  hResponseObj[:readerStructurePass] = false
                  return {}
               end

               # validate file against mdJson schema definition
               unless hResponseObj[:readerValidationLevel] == 'none'
                  validate(hMdJson, hResponseObj)
                  unless hResponseObj[:readerValidationPass]
                     return {}
                  end
               end

               # unpack the mdJson into the internal object
               return MdJson.unpack(hMdJson, hResponseObj)

            end

         end
      end
   end
end
