# MdTranslator - minitest of
# reader / mdJson / module_medium

# History:
#   Stan Smith 2016-10-20 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/mdJson_reader'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_medium'

class TestReaderMdJsonMedium < MiniTest::Test

    # set variables for test
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Medium
    @@responseObj = {
        readerExecutionPass: true,
        readerExecutionMessages: []
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), '../../', 'schemas/examples', 'medium.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn['medium'][0]

    def test_complete_medium_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute_empty metadata[:mediumSpecification]
        assert_equal 9.9, metadata[:density]
        assert_equal 'units', metadata[:units]
        assert_equal 9, metadata[:numberOfVolumes]
        assert_equal 2, metadata[:mediumFormat].length
        assert_equal 'mediumFormat0', metadata[:mediumFormat][0]
        assert_equal 'mediumFormat1', metadata[:mediumFormat][1]
        assert_equal 'note', metadata[:note]
        refute_empty metadata[:identifier]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_medium_empty_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['mediumSpecification'] = {}
        hIn['density'] = ''
        hIn['units'] = ''
        hIn['numberOfVolumes'] = ''
        hIn['mediumFormat'] = []
        hIn['note'] = ''
        hIn['identifier'] = {}
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_empty metadata[:mediumSpecification]
        assert_nil metadata[:density]
        assert_nil metadata[:units]
        assert_nil metadata[:numberOfVolumes]
        assert_empty metadata[:mediumFormat]
        assert_nil metadata[:note]
        assert_empty metadata[:identifier]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_medium_missing_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['nonElement'] = ''
        hIn.delete('mediumSpecification')
        hIn.delete('density')
        hIn.delete('units')
        hIn.delete('numberOfVolumes')
        hIn.delete('mediumFormat')
        hIn.delete('note')
        hIn.delete('identifier')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_empty metadata[:mediumSpecification]
        assert_nil metadata[:density]
        assert_nil metadata[:units]
        assert_nil metadata[:numberOfVolumes]
        assert_empty metadata[:mediumFormat]
        assert_nil metadata[:note]
        assert_empty metadata[:identifier]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_medium_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
