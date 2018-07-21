# MdTranslator - minitest of
# reader / mdJson / module_georeferencableRepresentation

# History:
#  Stan Smith 2018-06-20 refactored to use mdJson construction helpers
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-10-19 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_georeferenceableRepresentation'

class TestReaderMdJsonGeoreferenceableRepresentation < TestReaderMdJsonParent

   # set variables for test
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::GeoreferenceableRepresentation

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.georeferenceable
   TDClass.add_dimension(mdHash[:gridRepresentation])

   @@mdHash = mdHash

   def test_geoRefRep_schema

      errors = TestReaderMdJsonParent.testSchema(@@mdHash, 'georeferenceableRepresentation.json')
      assert_empty errors

   end

   def test_complete_geoRefRep_object

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_empty metadata[:gridRepresentation]
      refute metadata[:controlPointAvailable]
      refute metadata[:orientationParameterAvailable]
      assert_equal 'orientation parameter description', metadata[:orientationParameterDescription]
      assert_equal 'georeferenced parameter', metadata[:georeferencedParameter]
      assert_equal 2, metadata[:parameterCitation].length
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_geoRefRep_empty_grid

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['gridRepresentation'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'ERROR: mdJson reader: georeferenceable representation grid representation is missing: CONTEXT is testing'

   end

   def test_geoRefRep_missing_grid

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('gridRepresentation')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'ERROR: mdJson reader: georeferenceable representation grid representation is missing: CONTEXT is testing'

   end

   def test_geoRefRep_empty_geoParam

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['georeferencedParameter'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'ERROR: mdJson reader: georeferenceable representation georeferenced parameters are missing: CONTEXT is testing'

   end

   def test_geoRefRep_missing_geoParam

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('georeferencedParameter')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'ERROR: mdJson reader: georeferenceable representation georeferenced parameters are missing: CONTEXT is testing'

   end

   def test_geoRefRep_empty_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['orientationParameterDescription'] = ''
      hIn['parameterCitation'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_empty metadata[:gridRepresentation]
      refute metadata[:controlPointAvailable]
      refute metadata[:orientationParameterAvailable]
      assert_nil metadata[:orientationParameterDescription]
      assert_equal 'georeferenced parameter', metadata[:georeferencedParameter]
      assert_empty metadata[:parameterCitation]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_geoRefRep_missing_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('controlPointAvailable')
      hIn.delete('orientationParameterAvailable')
      hIn.delete('orientationParameterDescription')
      hIn.delete('parameterCitation')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_empty metadata[:gridRepresentation]
      refute metadata[:controlPointAvailable]
      refute metadata[:orientationParameterAvailable]
      assert_nil metadata[:orientationParameterDescription]
      assert_equal 'georeferenced parameter', metadata[:georeferencedParameter]
      assert_empty metadata[:parameterCitation]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_geoRefRep_object

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse, 'testing')

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'WARNING: mdJson reader: georeferenceable representation object is empty: CONTEXT is testing'

   end

end
