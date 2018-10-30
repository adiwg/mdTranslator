# MdTranslator - minitest of
# reader / mdJson / module_obliqueLinePoint

# History:
#  Stan Smith 2018-10-08 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_localProjection'

class TestReaderMdJsonLocalProjection < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::LocalProjection

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.local

   @@mdHash = mdHash

   def test_localCoordinate_schema

       errors = TestReaderMdJsonParent.testSchema(@@mdHash, 'projection.json', fragment: 'local')
       assert_empty errors

   end

   def test_complete_obliqueLinePoint_object

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute metadata[:fixedToEarth]
      assert_equal 'local description', metadata[:description]
      assert_equal 'local georeference', metadata[:georeference]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_local_object

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse, 'testing')

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'WARNING: mdJson reader: local projection object is empty: CONTEXT is testing'

   end

end
