# MdTranslator - minitest of
# reader / mdJson / module_geometryProperties

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-10-25 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_geometryProperties'

class TestReaderMdJsonGeometryProperties < TestReaderMdJsonParent

    # set variables for test
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::GeometryProperties
    aIn = TestReaderMdJsonParent.getJson('geometryProperties.json')
    @@hIn = aIn['geometryProperties'][0]

    def test_complete_geometryProperties

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 2, metadata[:featureNames].length
        assert_equal 'featureName0', metadata[:featureNames][0]
        assert_equal 'featureName1', metadata[:featureNames][1]
        assert_equal 'description', metadata[:description]
        assert_equal 2, metadata[:identifiers].length
        assert_equal 'featureScope', metadata[:featureScope]
        assert_equal 'acquisitionMethod', metadata[:acquisitionMethod]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_geometryProperties_empty

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['featureName'] = []
        hIn['description'] = ''
        hIn['identifier'] = []
        hIn['featureScope'] = ''
        hIn['acquisitionMethod'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_empty metadata[:featureNames]
        assert_nil metadata[:description]
        assert_empty metadata[:identifiers]
        assert_nil metadata[:featureScope]
        assert_nil metadata[:acquisitionMethod]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_geometryProperties_missing

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['nonElement'] = ''
        hIn.delete('featureName')
        hIn.delete('description')
        hIn.delete('identifier')
        hIn.delete('featureScope')
        hIn.delete('acquisitionMethod')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_empty metadata[:featureNames]
        assert_nil metadata[:description]
        assert_empty metadata[:identifiers]
        assert_nil metadata[:featureScope]
        assert_nil metadata[:acquisitionMethod]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_geometryProperties

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
