# MdTranslator - minitest of
# reader / mdJson / module_geographicExtent

# History:
#  Stan Smith 2018-06-19 refactored to use mdJson construction helpers
#  Stan Smith 2017-09-28 add description for fgdc support
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-11-10 added computedBbox
#  Stan Smith 2016-10-26 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_geographicExtent'

class TestReaderMdJsonGeographicExtent < TestReaderMdJsonParent

   # set variables for test
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::GeographicExtent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.geographicExtent
   mdHash[:geographicElement] << TDClass.point
   mdHash[:geographicElement] << TDClass.lineString

   @@mdHash = mdHash

   # TODO reinstate after schema update
   # def test_geographicExtent_schema
   #
   #     errors = TestReaderMdJsonParent.testSchema(@@mdHash, 'geographicExtent.json')
   #     assert_empty errors
   #
   # end

   def test_complete_geographicExtent

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_equal 'geographic extent description', metadata[:description]
      assert metadata[:containsData]
      refute_empty metadata[:identifier]
      refute_empty metadata[:boundingBox]
      assert_equal 2, metadata[:geographicElements].length
      assert_equal 2, metadata[:nativeGeoJson].length
      refute_empty metadata[:computedBbox]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_geographicExtent_empty_containsData

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['containsData'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_equal 'geographic extent description', metadata[:description]
      assert metadata[:containsData]
      refute_empty metadata[:identifier]
      refute_empty metadata[:boundingBox]
      assert_equal 2, metadata[:geographicElements].length
      assert_equal 2, metadata[:nativeGeoJson].length
      refute_empty metadata[:computedBbox]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_geographicExtent_missing_containsData

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('containsData')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_equal 'geographic extent description', metadata[:description]
      assert metadata[:containsData]
      refute_empty metadata[:identifier]
      refute_empty metadata[:boundingBox]
      assert_equal 2, metadata[:geographicElements].length
      assert_equal 2, metadata[:nativeGeoJson].length
      refute_empty metadata[:computedBbox]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_geographicExtent_empty_required

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['description'] = ''
      hIn['identifier'] = {}
      hIn['boundingBox'] = {}
      hIn['geographicElement'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'ERROR: mdJson reader: geographic extent must have at least one description, identifier, bounding box, or geographic element: CONTEXT is testing'

   end

   def test_geographicExtent_missing_required

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['nonElement'] = ''
      hIn.delete('description')
      hIn.delete('identifier')
      hIn.delete('boundingBox')
      hIn.delete('geographicElement')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'ERROR: mdJson reader: geographic extent must have at least one description, identifier, bounding box, or geographic element: CONTEXT is testing'

   end

   def test_empty_geographicExtent

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse, 'testing')

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson reader: geographic extent object is empty: CONTEXT is testing'

   end

end
