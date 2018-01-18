# MdTranslator - minitest of
# reader / mdJson / module_referenceSystemParameters

# History:
#  Stan Smith 2017-10-23 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_referenceSystemParameters'

class TestReaderMdJsonReferenceSystemParameters < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::ReferenceSystemParameters
   aIn = TestReaderMdJsonParent.getJson('spatialReference.json')
   @@hIn = aIn['spatialReferenceSystem'][0]['referenceSystemParameterSet']

   # TODO complete after schema update
   # def test_spatialReference_schema
   #
   #     errors = TestReaderMdJsonParent.testSchema(@@hIn, 'spatialReference.json')
   #     assert_empty errors
   #
   # end

   def test_complete_referenceSystemParameter_object

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_empty metadata[:projection]
      refute_empty metadata[:geodetic]
      refute_empty metadata[:verticalDatum]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_referenceSystemParameter_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

end
