# MdTranslator - minitest of
# reader / mdJson / module_obliqueLinePoint

# History:
#   Stan Smith 2017-10-23 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_projectionParameters'

class TestReaderMdJsonObliqueLinePoint < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::ObliqueLinePoint
   aIn = TestReaderMdJsonParent.getJson('spatialReference.json')
   @@hIn = aIn['spatialReferenceSystem'][0]['referenceSystemParameterSet']['projection']['obliqueLinePoint'][0]

   # TODO complete after schema update
   # def test_spatialReference_schema
   #
   #     errors = TestReaderMdJsonParent.testSchema(@@hIn, 'spatialReference.json')
   #     assert_empty errors
   #
   # end

   def test_complete_obliqueLinePoint_object

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 9.9, metadata[:azimuthLineLatitude]
      assert_equal -99.9, metadata[:azimuthLineLongitude]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_obliqueLinePoint_empty_azimuthLineLatitude

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['azimuthLineLatitude'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson spatial reference oblique line-point latitude is missing'

   end

   def test_obliqueLinePoint_missing_azimuthLineLatitude

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('azimuthLineLatitude')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson spatial reference oblique line-point latitude is missing'

   end

   def test_obliqueLinePoint_empty_azimuthLineLongitude

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['azimuthLineLongitude'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson spatial reference oblique line-point longitude is missing'

   end

   def test_obliqueLinePoint_missing_azimuthLineLongitude

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('azimuthLineLongitude')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson spatial reference oblique line-point longitude is missing'

   end

   def test_empty_obliqueLinePoint_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson spatial reference oblique line-point object is empty'

   end

end
