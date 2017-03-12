# MdTranslator - minitest of
# parent class for all tc_mdjson tests

# History:
# Stan Smith 2017-03-11 original script

require 'minitest/autorun'
require 'json'
require 'json-schema'
require 'adiwg-mdjson_schemas'

class TestWriterMdJsonParent < MiniTest::Test

    # get json file for tests from examples folder
    def self.getJson(fileName)

        file = File.join(File.dirname(__FILE__), 'testData', fileName)
        file = File.open(file, 'r')
        jsonFile = file.read
        file.close
        return jsonFile

    end

    # test schema for writer modules
    def self.testSchema(mdJson, schema, fragment: nil, remove: [])

        # load all schemas with 'true' to prohibit additional parameters
        ADIWG::MdjsonSchemas::Utils.load_schemas(false)

        # load schema segment and make all elements required and prevent additional parameters
        strictSchema = ADIWG::MdjsonSchemas::Utils.load_strict(schema)

        # remove unwanted parameters from the required array
        unless remove.empty?
            strictSchema['required'] = strictSchema['required'] - remove
        end

        # build relative path to schema fragment
        fragmentPath = nil
        if fragment
            fragmentPath = '#/definitions/' + fragment
        end

        # scan
        return JSON::Validator.fully_validate(strictSchema, mdJson, :fragment=>fragmentPath)

    end

end
