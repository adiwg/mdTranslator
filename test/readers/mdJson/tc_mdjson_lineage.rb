# MdTranslator - minitest of
# reader / mdJson / module_lineage

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2015-09-22 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_lineage'

class TestReaderMdJsonResourceLineage < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::ResourceLineage
   aIn = TestReaderMdJsonParent.getJson('lineage.json')
   @@hIn = aIn['resourceLineage'][0]

   def test_lineage_schema

      errors = TestReaderMdJsonParent.testSchema(@@hIn, 'lineage.json')
      assert_empty errors

   end

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

   def test_empty_lineage_required

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['statement'] = ''
      hIn['source'] = []
      hIn['processStep'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson resource lineage must have at least one statement, process step, or source'

   end

   def test_missing_lineage_required

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('statement')
      hIn.delete('source')
      hIn.delete('processStep')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson resource lineage must have at least one statement, process step, or source'

   end

   def test_lineage_statement_only

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['scope'] = {}
      hIn['citation'] = {}
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
      hIn['scope'] = {}
      hIn['citation'] = {}
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
      hIn['scope'] = {}
      hIn['citation'] = {}
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
      hIn.delete('scope')
      hIn.delete('citation')
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
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: mdJson resource lineage object is empty'

   end

end
