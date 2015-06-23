# MdTranslator - code to test mdtranslator from Ruby Terminal during development

# History:
# Stan Smith 2014-07-02 original script
# Josh Bradley 2014-09-28 updated to use test/unit
# Stan Smith 2015-01-16 changed ADIWG::Mdtranslator.translate() to keyword parameters
# Stan Smith 2015-06-22 refactored setup to after removal of globals

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'

class TestTranslation_v1_0 < MiniTest::Test

    @@reader = 'mdJson'
    @@writer = 'iso19115_2'

    def test_full_success

        # get json file for tests from examples folder
        file = File.join(File.dirname(__FILE__), '../../../', 'schemas/v1_0/examples', 'full_example.json')
        file = File.open(file, 'r')
        jsonObj = file.read
        file.close

        # call opening module in mdTranslator
        metadata = ADIWG::Mdtranslator.translate(
            file: jsonObj, reader: @@reader, validate: 'normal',
            writer: @@writer, showAllTags: 'true')
        version = JSON.parse(jsonObj)['version']['version'].split('.')

        assert_equal('json', metadata[:readerFormat], 'Check reader name')
        assert metadata[:readerStructurePass], metadata[:readerStructureMessages].join(',')
        assert_equal(@@reader, metadata[:readerFound])

        # major version
        assert_equal(version[0], metadata[:readerVersionUsed].split('.')[0])

        # minor version
        assert_equal(version[1], metadata[:readerVersionUsed].split('.')[1])
        assert metadata[:readerValidationPass], "reader validation failed: \n" + metadata[:readerValidationMessages].join(',')
        assert_equal(@@writer, metadata[:writerName])
        assert metadata[:writerPass], "writer validation failed: \n" + metadata[:writerMessages].join(',')
        refute_nil metadata[:writerOutput]
    end

    def test_minimum_success

        # get json file for tests from examples folder
        file = File.join(File.dirname(__FILE__), '../../../', 'schemas/v1_0/examples', 'minimum_example.json')
        file = File.open(file, 'r')
        jsonObj = file.read
        file.close

        # call opening module in mdTranslator
        metadata = ADIWG::Mdtranslator.translate(
            file: jsonObj, reader: @@reader, validate: 'normal',
            writer: @@writer, showAllTags: 'true')

        assert_equal('json', metadata[:readerFormat], 'Check reader name')
        assert metadata[:readerStructurePass], metadata[:readerStructureMessages].join(',')
        assert_equal(@@reader, metadata[:readerFound])
        assert metadata[:readerValidationPass], "reader validation failed: \n" + metadata[:readerValidationMessages].join(',')
        assert_equal(@@writer, metadata[:writerName])
        assert metadata[:writerPass], "writer validation failed: \n" + metadata[:writerMessages].join(',')
        refute_nil metadata[:writerOutput]
    end

end
