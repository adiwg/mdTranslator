# MdTranslator - minitest of
# reader / mdJson / module_ellipsoid

# History:
#   Stan Smith 2017-10-23 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_geodetic'

class TestReaderMdJsonGeodetic < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Geodetic
   aIn = TestReaderMdJsonParent.getJson('spatialReference.json')
   @@hIn = aIn['spatialReferenceSystem'][0]['referenceSystemParameterSet']['geodetic']

   # TODO complete after schema update
   # def test_spatialReference_schema
   #
   #     errors = TestReaderMdJsonParent.testSchema(@@hIn, 'spatialReference.json')
   #     assert_empty errors
   #
   # end

   def test_complete_geodetic_object

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_empty metadata[:datumIdentifier]
      assert_equal 'datum name', metadata[:datumName]
      refute_empty metadata[:ellipsoidIdentifier]
      assert_equal 'WGS84', metadata[:ellipsoidName]
      assert_equal 9999999.0, metadata[:semiMajorAxis]
      assert_equal 'feet', metadata[:axisUnits]
      assert_equal 999.9, metadata[:denominatorOfFlatteningRatio]
      assert_equal 'datum identifier', metadata[:datumIdentifier][:identifier]
      assert_equal 'ellipsoid identifier', metadata[:ellipsoidIdentifier][:identifier]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_ellipsoid_empty_ellipsoidName

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['ellipsoidName'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 
                      'ERROR: mdJson reader: spatial reference geodetic ellipsoid name is missing'

   end

   def test_ellipsoid_missing_ellipsoidName

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('ellipsoidName')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 
                      'ERROR: mdJson reader: spatial reference geodetic ellipsoid name is missing'

   end

   def test_empty_ellipsoid_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 
                      'WARNING: mdJson reader: spatial reference geodetic object is empty'

   end

end
