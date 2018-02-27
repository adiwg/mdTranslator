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
      assert_equal 'datum name', metadata[:datumName]
      assert_equal 'attribute values', metadata[:encodingMethod]
      refute metadata[:isDepthSystem]
      assert_equal 9.9, metadata[:verticalResolution]
      assert_equal 'meters', metadata[:unitOfMeasure]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_verticalDatum_name

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['datumIdentifier'] = {}
      hIn['datumName'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson vertical datum must have an identifier or all other elements'

   end

   def test_missing_verticalDatum_name

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['datumIdentifier'] = {}
      hIn.delete('datumName')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson vertical datum must have an identifier or all other elements'

   end

   def test_empty_verticalDatum_encoding

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['datumIdentifier'] = {}
      hIn['encodingMethod'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson vertical datum must have an identifier or all other elements'

   end

   def test_missing_verticalDatum_encoding

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['datumIdentifier'] = {}
      hIn.delete('encodingMethod')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson vertical datum must have an identifier or all other elements'

   end

   def test_empty_verticalDatum_resolution

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['datumIdentifier'] = {}
      hIn['verticalResolution'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson vertical datum must have an identifier or all other elements'

   end

   def test_missing_verticalDatum_resolution

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['datumIdentifier'] = {}
      hIn.delete('verticalResolution')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson vertical datum must have an identifier or all other elements'

   end

   def test_empty_verticalDatum_units

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['datumIdentifier'] = {}
      hIn['unitOfMeasure'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson vertical datum must have an identifier or all other elements'

   end

   def test_missing_verticalDatum_units

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['datumIdentifier'] = {}
      hIn.delete('unitOfMeasure')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson vertical datum must have an identifier or all other elements'

   end

   def test_empty_verticalDatum_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: mdJson reader: vertical datum object is empty'

   end

end
