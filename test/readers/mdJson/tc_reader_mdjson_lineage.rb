# MdTranslator - minitest of
# reader / mdJson / module_lineage

# History:
# Stan Smith 2015-09-22 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/mdJson_reader'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_lineage'

class TestReaderMdJsonResourceLineage < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::ResourceLineage
    @@responseObj = {
        readerExecutionMessages: [],
        readerExecutionPass: true
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), '../../', 'schemas/examples', 'lineage.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn['resourceLineage'][0]

    def test_complete_lineage_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'statement', metadata[:statement]
        refute_empty metadata[:resourceScope]
        assert_equal 2, metadata[:lineageCitation].length
        assert_equal 2, metadata[:dataSources].length
        assert_equal 2, metadata[:processSteps].length
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_incomplete_lineage_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['statement'] = ''
        hIn['source'] = []
        hIn['processStep'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_lineage_statement_only

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['resourceScope'] = {}
        hIn['lineageCitation'] = {}
        hIn['source'] = []
        hIn['processStep'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'statement', metadata[:statement]
        assert_empty metadata[:resourceScope]
        assert_empty metadata[:lineageCitation]
        assert_empty metadata[:dataSources]
        assert_empty metadata[:processSteps]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_lineage_source_only

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['statement'] = ''
        hIn['resourceScope'] = {}
        hIn['lineageCitation'] = {}
        hIn['processStep'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:statement]
        assert_empty metadata[:resourceScope]
        assert_empty metadata[:lineageCitation]
        refute_empty metadata[:dataSources]
        assert_empty metadata[:processSteps]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_lineage_processStep_only

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['statement'] = ''
        hIn['resourceScope'] = {}
        hIn['lineageCitation'] = {}
        hIn['processStep'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:statement]
        assert_empty metadata[:resourceScope]
        assert_empty metadata[:lineageCitation]
        refute_empty metadata[:dataSources]
        assert_empty metadata[:processSteps]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_lineage_missing_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('resourceScope')
        hIn.delete('lineageCitation')
        hIn.delete('source')
        hIn.delete('processStep')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'statement', metadata[:statement]
        assert_empty metadata[:resourceScope]
        assert_empty metadata[:lineageCitation]
        assert_empty metadata[:dataSources]
        assert_empty metadata[:processSteps]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_lineage_missing_statement

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('statement')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:statement]
        refute_empty metadata[:resourceScope]
        refute_empty metadata[:lineageCitation]
        refute_empty metadata[:dataSources]
        refute_empty metadata[:processSteps]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_lineage_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
