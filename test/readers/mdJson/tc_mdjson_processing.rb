# MdTranslator - minitest of
# reader / mdJson / module_processing

# History:
#  Stan Smith 2019-09-23 original script

require_relative 'mdjson_test_parent'

class TestReaderMdJsonProcessing < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Processing

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.build_processing_full

   @@mdHash = mdHash

   # TODO refactor after schema update
   # def test_processing_schema
   #
   #    hIn = Marshal::load(Marshal.dump(@@mdHash))
   #    TDClass.removeEmptyObjects(hIn)
   #    errors = TestReaderMdJsonParent.testSchema(hIn, 'lineage.json', :fragment => 'source')
   #    assert_empty errors
   #
   # end

   def test_complete_processing_object

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_empty metadata[:identifier]
      assert_equal 2, metadata[:softwareReferences].length
      assert_equal 'procedure description', metadata[:procedureDescription]
      assert_equal 2, metadata[:documentation].length
      assert_equal 'runtime parameters', metadata[:runtimeParameters]
      assert_equal 2, metadata[:algorithms].length
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_processing_identifier_element

      # empty identifier
      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['identifier'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_empty metadata[:identifier]
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson reader: processing identifier is missing: CONTEXT is testing'

      # missing identifier
      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('identifier')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_empty metadata[:identifier]
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson reader: processing identifier is missing: CONTEXT is testing'

   end

   def test_description_optional_elements

      # empty elements
      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['softwareReference'] = []
      hIn['procedureDescription'] = ''
      hIn['documentation'] = []
      hIn['runtimeParameters'] = ''
      hIn['algorithm'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_empty metadata[:softwareReferences]
      assert_nil metadata[:procedureDescription]
      assert_empty metadata[:documentation]
      assert_nil metadata[:runtimeParameters]
      assert_empty metadata[:algorithms]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

      # missing elements
      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('softwareReference')
      hIn.delete('procedureDescription')
      hIn.delete('documentation')
      hIn.delete('runtimeParameters')
      hIn.delete('algorithm')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_empty metadata[:softwareReferences]
      assert_nil metadata[:procedureDescription]
      assert_empty metadata[:documentation]
      assert_nil metadata[:runtimeParameters]
      assert_empty metadata[:algorithms]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_processing_object

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse, 'testing')

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson reader: processing object is empty: CONTEXT is testing'

   end

end
