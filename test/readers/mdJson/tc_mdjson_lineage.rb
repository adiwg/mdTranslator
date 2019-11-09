# MdTranslator - minitest of
# reader / mdJson / module_lineage

# History:
#  Stan Smith 2018-06-20 refactored to use mdJson construction helpers
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2015-09-22 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_lineage'

class TestReaderMdJsonResourceLineage < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::ResourceLineage

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.build_lineage
   mdHash[:citation] << TDClass.build_citation('lineage citation two', 'CID003')
   mdHash[:processStep] << TDClass.build_leProcessStep('PST001', 'process step one')
   mdHash[:processStep] << TDClass.build_leProcessStep('PST002', 'process step two')
   mdHash[:source] << TDClass.build_leSource('SRC001', 'source one')
   mdHash[:source] << TDClass.build_leSource('SRC002', 'source two')

   TDClass.removeEmptyObjects(mdHash)

   @@mdHash = mdHash

   def test_lineage_schema

      errors = TestReaderMdJsonParent.testSchema(@@mdHash, 'lineage.json')
      assert_empty errors

   end

   def test_complete_lineage_object

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
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

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['statement'] = ''
      hIn['source'] = []
      hIn['processStep'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: resource lineage must have at least one statement, process step, or source'

   end

   def test_missing_lineage_required

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('statement')
      hIn.delete('source')
      hIn.delete('processStep')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: resource lineage must have at least one statement, process step, or source'

   end

   def test_lineage_statement_only

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
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

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
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

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
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

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
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

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
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

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson reader: resource lineage object is empty'

   end

end
