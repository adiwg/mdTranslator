# MdTranslator - minitest of
# reader / mdJson / module_verticalDatum

# History:
#   Stan Smith 2017-10-23 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_verticalDatum'

class TestReaderMdJsonVerticalDatum < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::VerticalDatum
   aIn = TestReaderMdJsonParent.getJson('spatialReference.json')
   @@hIn = aIn['spatialReferenceSystem'][0]['referenceSystemParameterSet']['verticalDatum']

   # TODO complete after schema update
   # def test_spatialReference_schema
   #
   #     errors = TestReaderMdJsonParent.testSchema(@@hIn, 'spatialReference.json')
   #     assert_empty errors
   #
   # end

   def test_complete_verticalDatum_object

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_empty metadata[:datumIdentifier]
      assert_equal 'attribute values', metadata[:encodingMethod]
      refute metadata[:isDepthSystem]
      assert_equal 9.9, metadata[:verticalResolution]
      assert_equal 'meters', metadata[:unitOfMeasure]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_verticalDatum_missing_datumIdentifier

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('datumIdentifier')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_verticalDatum_empty_encodingMethod

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['datumIdentifier'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_verticalDatum_missing_encodingMethod

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('encodingMethod')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_verticalDatum_empty_verticalResolution

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['verticalResolution'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_verticalDatum_missing_verticalResolution

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('verticalResolution')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_verticalDatum_empty_unitOfMeasure

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['unitOfMeasure'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_verticalDatum_missing_unitOfMeasure

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('unitOfMeasure')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_verticalDatum_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

end
