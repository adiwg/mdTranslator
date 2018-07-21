# MdTranslator - minitest of
# reader / mdJson / module_source

# History:
#  Stan Smith 2018-06-25 refactored to use mdJson construction helpers
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-10-17 refactored for mdJson 2.0
#  Stan Smith 2015-09-22 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_source'

class TestReaderMdJsonSource < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Source

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.build_source_full

   @@mdHash = mdHash

   # TODO reinstate after schema update
   # def test_source_schema
   #
   #    errors = TestReaderMdJsonParent.testSchema(@@mdHash, 'lineage.json', :fragment => 'source')
   #    assert_empty errors
   #
   # end

   def test_complete_source_object

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_equal 'SRC001', metadata[:sourceId]
      assert_equal 'description', metadata[:description]
      refute_empty metadata[:sourceCitation]
      assert_equal 2, metadata[:metadataCitation].length
      refute_empty metadata[:spatialResolution]
      refute_empty metadata[:referenceSystem]
      assert_equal 2, metadata[:sourceSteps].length
      refute_empty metadata[:scope]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_source_descriptionScope_empty

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['description'] = ''
      hIn['scope'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: source requires a description or scope: CONTEXT is testing'

   end

   def test_source_descriptionScope_missing

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('description')
      hIn.delete('scope')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: source requires a description or scope: CONTEXT is testing'

   end

   def test_source_elements_empty

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['sourceId'] = ''
      hIn['sourceCitation'] = {}
      hIn['metadataCitation'] = []
      hIn['spatialResolution'] = {}
      hIn['referenceSystem'] = {}
      hIn['sourceProcessStep'] = []
      hIn['scope'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_nil metadata[:sourceId]
      assert_equal 'description', metadata[:description]
      assert_empty metadata[:sourceCitation]
      assert_empty metadata[:metadataCitation]
      assert_empty metadata[:spatialResolution]
      assert_empty metadata[:referenceSystem]
      assert_empty metadata[:sourceSteps]
      assert_empty metadata[:scope]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_source_elements_missing

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('sourceId')
      hIn.delete('sourceCitation')
      hIn.delete('metadataCitation')
      hIn.delete('spatialResolution')
      hIn.delete('referenceSystem')
      hIn.delete('sourceProcessStep')
      hIn.delete('scope')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_nil metadata[:sourceId]
      assert_equal 'description', metadata[:description]
      assert_empty metadata[:sourceCitation]
      assert_empty metadata[:metadataCitation]
      assert_empty metadata[:spatialResolution]
      assert_empty metadata[:referenceSystem]
      assert_empty metadata[:sourceSteps]
      assert_empty metadata[:scope]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_source_object

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse, 'testing')

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson reader: source object is empty: CONTEXT is testing'

   end

end
