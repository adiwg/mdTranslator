# MdTranslator - minitest of
# reader / mdJson / module_series

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-10-12 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_series'

class TestReaderMdJsonSeries < TestReaderMdJsonParent

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Series
    aIn = TestReaderMdJsonParent.getJson('series.json')
    @@hIn = aIn['series'][0]

    def test_series_schema

        errors = TestReaderMdJsonParent.testSchema(@@hIn, 'citation.json', :fragment=>'series')
        assert_empty errors

    end

    def test_complete_series_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'seriesName', metadata[:seriesName]
        assert_equal 'seriesIssue', metadata[:seriesIssue]
        assert_equal 'issuePage', metadata[:issuePage]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_series_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['seriesName'] = ''
        hIn['seriesIssue'] = ''
        hIn['issuePage'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:seriesName]
        assert_nil metadata[:seriesIssue]
        assert_nil metadata[:issuePage]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_series_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['nonElement'] = ''
        hIn.delete('seriesName')
        hIn.delete('seriesIssue')
        hIn.delete('issuePage')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:seriesName]
        assert_nil metadata[:seriesIssue]
        assert_nil metadata[:issuePage]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_series_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
