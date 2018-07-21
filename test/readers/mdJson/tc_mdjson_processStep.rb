# MdTranslator - minitest of
# reader / mdJson / module_processStep

# History:
#  Stan Smith 2018-06-22 refactored to use mdJson construction helpers
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2015-08-24 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_processStep'

class TestReaderMdJsonProcessStep < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::ProcessStep

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.build_processStep_full

   TDClass.removeEmptyObjects(mdHash)

   @@mdHash = mdHash

   def test_processStep_schema

       errors = TestReaderMdJsonParent.testSchema(@@mdHash, 'lineage.json', :fragment=>'processStep')
       assert_empty errors

   end

   def test_complete_processStep_object

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_equal 'PS001', metadata[:stepId]
      assert_equal 'description', metadata[:description]
      assert_equal 'rationale', metadata[:rationale]
      refute_empty metadata[:timePeriod]
      assert_equal 2, metadata[:processors].length
      assert_equal 2, metadata[:references].length
      assert_equal 2, metadata[:stepSources].length
      assert_equal 2, metadata[:stepProducts].length
      refute_empty metadata[:scope]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_processStep_description

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['description'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: process step description is missing: CONTEXT is testing'

   end

   def test_missing_processStep_description

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('description')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: process step description is missing: CONTEXT is testing'

   end

   def test_empty_processStep_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['stepId'] = ''
      hIn['rationale'] = ''
      hIn['timePeriod'] = {}
      hIn['processor'] = []
      hIn['reference'] = []
      hIn['stepSource'] = []
      hIn['stepProduct'] = []
      hIn['scope'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_nil metadata[:stepId]
      assert_nil metadata[:rationale]
      assert_empty metadata[:timePeriod]
      assert_empty metadata[:processors]
      assert_empty metadata[:references]
      assert_empty metadata[:stepSources]
      assert_empty metadata[:stepProducts]
      assert_empty metadata[:scope]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_missing_processStep_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('stepId')
      hIn.delete('rationale')
      hIn.delete('timePeriod')
      hIn.delete('processor')
      hIn.delete('reference')
      hIn.delete('stepSource')
      hIn.delete('stepProduct')
      hIn.delete('scope')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_nil metadata[:stepId]
      assert_nil metadata[:rationale]
      assert_empty metadata[:timePeriod]
      assert_empty metadata[:processors]
      assert_empty metadata[:references]
      assert_empty metadata[:stepSources]
      assert_empty metadata[:stepProducts]
      assert_empty metadata[:scope]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_processStep_object

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse, 'testing')

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson reader: process step object is empty: CONTEXT is testing'

   end

end
