# MdTranslator - minitest of
# reader / mdJson / module_geometryObject

# History:
#  Stan Smith 2018-06-20 refactored to use mdJson construction helpers
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-10-24 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_geometryObject'

class TestReaderMdJsonGeometryObject < TestReaderMdJsonParent

   # set variables for test
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::GeometryObject

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.build_geoJson

   @@mdHash = mdHash

   def test_geometryObject_schema

      ADIWG::MdjsonSchemas::Utils.load_schemas(false)

      @@mdHash.each do |hGeo|
         errors = JSON::Validator.fully_validate('geojson.json', hGeo)
         assert_empty errors
      end

   end

   def test_complete_geometryObject_Point

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[0]))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'Point', metadata[:type]
      refute_empty metadata[:coordinates]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_complete_geometryObject_LineString

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[1]))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'LineString', metadata[:type]
      refute_empty metadata[:coordinates]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_complete_geometryObject_Polygon

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[2]))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'Polygon', metadata[:type]
      refute_empty metadata[:coordinates]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_complete_geometryObject_MultiPoint

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[3]))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'MultiPoint', metadata[:type]
      refute_empty metadata[:coordinates]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_complete_geometryObject_MultiLineString

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[4]))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'MultiLineString', metadata[:type]
      refute_empty metadata[:coordinates]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_complete_geometryObject_MultiPolygon

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[5]))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'MultiPolygon', metadata[:type]
      refute_empty metadata[:coordinates]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_complete_geometryObject_invalid

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[0]))
      hIn = JSON.parse(hIn.to_json)
      hIn['type'] = 'invalid'
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 2, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: GeoJSON geometry object type must be Point, LineString, Polygon, MultiPoint, MultiLineString, or MultiPolygon'
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: GeoJSON geometry object type is missing'

   end

   def test_geometryObject_empty_type

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[0]))
      hIn = JSON.parse(hIn.to_json)
      hIn['type'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 
                      'ERROR: mdJson reader: GeoJSON geometry object type is missing'

   end

   def test_geometryObject_missing_type

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[0]))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('type')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 
                      'ERROR: mdJson reader: GeoJSON geometry object type is missing'

   end

   def test_geometryObject_empty_coordinates

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[0]))
      hIn = JSON.parse(hIn.to_json)
      hIn['coordinates'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 
                      'ERROR: mdJson reader: GeoJSON geometry object coordinates are missing'

   end

   def test_geometryObject_missing_coordinates

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[0]))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('coordinates')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 
                      'ERROR: mdJson reader: GeoJSON geometry object coordinates are missing'

   end

   def test_empty_geometryObject

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson reader: GeoJSON geometry object is empty'

   end

end
