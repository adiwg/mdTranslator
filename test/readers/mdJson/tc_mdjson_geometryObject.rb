# MdTranslator - minitest of
# reader / mdJson / module_geometryObject

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-10-24 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_geometryObject'

class TestReaderMdJsonGeometryObject < TestReaderMdJsonParent

   # set variables for test
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::GeometryObject
   aIn = TestReaderMdJsonParent.getJson('geometryObject.json')
   @@aIn = aIn['geometryObject']

   def test_geometryObject_schema

      ADIWG::MdjsonSchemas::Utils.load_schemas(false)

      @@aIn.each do |hGeo|
         errors = JSON::Validator.fully_validate('geojson.json', hGeo)
         assert_empty errors
      end

   end

   def test_complete_geometryObject_Point

      hIn = Marshal::load(Marshal.dump(@@aIn[0]))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'Point', metadata[:type]
      refute_empty metadata[:coordinates]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_complete_geometryObject_LineString

      hIn = Marshal::load(Marshal.dump(@@aIn[1]))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'LineString', metadata[:type]
      refute_empty metadata[:coordinates]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_complete_geometryObject_Polygon

      hIn = Marshal::load(Marshal.dump(@@aIn[2]))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'Polygon', metadata[:type]
      refute_empty metadata[:coordinates]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_complete_geometryObject_MultiPoint

      hIn = Marshal::load(Marshal.dump(@@aIn[4]))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'MultiPoint', metadata[:type]
      refute_empty metadata[:coordinates]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_complete_geometryObject_MultiLineString

      hIn = Marshal::load(Marshal.dump(@@aIn[5]))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'MultiLineString', metadata[:type]
      refute_empty metadata[:coordinates]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_complete_geometryObject_MultiPolygon

      hIn = Marshal::load(Marshal.dump(@@aIn[6]))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'MultiPolygon', metadata[:type]
      refute_empty metadata[:coordinates]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_complete_geometryObject_invalid

      hIn = Marshal::load(Marshal.dump(@@aIn[0]))
      hIn['type'] = 'invalid'
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson GeoJSON geometry object type must be Point, LineString, Polygon, MultiPoint, MultiLineString, or MultiPolygon'

   end

   def test_geometryObject_empty_type

      hIn = Marshal::load(Marshal.dump(@@aIn[0]))
      hIn['type'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson GeoJSON geometry object type is missing'

   end

   def test_geometryObject_missing_type

      hIn = Marshal::load(Marshal.dump(@@aIn[0]))
      hIn.delete('type')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson GeoJSON geometry object type is missing'

   end

   def test_geometryObject_empty_coordinates

      hIn = Marshal::load(Marshal.dump(@@aIn[0]))
      hIn['coordinates'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson GeoJSON geometry object coordinates are missing'

   end

   def test_geometryObject_missing_coordinates

      hIn = Marshal::load(Marshal.dump(@@aIn[0]))
      hIn.delete('coordinates')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson GeoJSON geometry object coordinates are missing'

   end

   def test_empty_geometryObject

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: mdJson GeoJSON geometry object is empty'

   end

end
