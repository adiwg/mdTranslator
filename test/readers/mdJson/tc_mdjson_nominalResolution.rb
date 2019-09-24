# MdTranslator - minitest of
# reader / mdJson / module_nominalResolution

# History:
#  Stan Smith 2019-09-23 original script

require_relative 'mdjson_test_parent'

class TestReaderMdJsonNominalResolution < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::NominalResolution

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.nominalResolution

   @@mdHash = mdHash

   # TODO refactor after schema update
   # def test_nominalResolution_schema
   #
   #    hIn = Marshal::load(Marshal.dump(@@mdHash))
   #    TDClass.removeEmptyObjects(hIn)
   #    errors = TestReaderMdJsonParent.testSchema(hIn, 'lineage.json', :fragment => 'source')
   #    assert_empty errors
   #
   # end

   def test_complete_nominalResolution_object

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_empty metadata[:scanningResolution]
      assert_empty metadata[:groundResolution]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   # test ground resolution
   def test_ground_nominalResolution_object

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:groundResolution] = hIn[:scanningResolution]
      hIn[:scanningResolution] = {}
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_empty metadata[:scanningResolution]
      refute_empty metadata[:groundResolution]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   # test both scanning and ground resolution
   def test_both_nominalResolution_object

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:groundResolution] = hIn[:scanningResolution]
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_empty metadata[:scanningResolution]
      refute_empty metadata[:groundResolution]
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
        'ERROR: mdJson reader: nominal resolution cannot be both scanning and ground resolutions: CONTEXT is testing'

   end

   def test_empty_nominalResolution_object

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse, 'testing')

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson reader: nominal resolution object is empty: CONTEXT is testing'

   end

end
