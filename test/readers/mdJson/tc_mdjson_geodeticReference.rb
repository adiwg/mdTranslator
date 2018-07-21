# MdTranslator - minitest of
# reader / mdJson / module_ellipsoid

# History:
#  Stan Smith 2018-06-19 refactored to use mdJson construction helpers
#  Stan Smith 2017-10-23 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_geodetic'

class TestReaderMdJsonGeodetic < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Geodetic

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.geodetic
   mdHash[:datumIdentifier] = TDClass.build_identifier('datum identifier')
   mdHash[:ellipsoidIdentifier] = TDClass.build_identifier('ellipsoid identifier')

   @@mdHash = mdHash

   # TODO complete after schema update
   # def test_spatialReference_schema
   #
   #     errors = TestReaderMdJsonParent.testSchema(@@hIn, 'spatialReference.json')
   #     assert_empty errors
   #
   # end

   def test_complete_geodetic_object

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_empty metadata[:datumIdentifier]
      assert_equal 'datum name', metadata[:datumName]
      refute_empty metadata[:ellipsoidIdentifier]
      assert_equal 'ellipsoid name', metadata[:ellipsoidName]
      assert_equal 9999.9, metadata[:semiMajorAxis]
      assert_equal 'axis units', metadata[:axisUnits]
      assert_equal 999.9, metadata[:denominatorOfFlatteningRatio]
      assert_equal 'datum identifier', metadata[:datumIdentifier][:identifier]
      assert_equal 'ellipsoid identifier', metadata[:ellipsoidIdentifier][:identifier]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_ellipsoid_empty_ellipsoidName

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['ellipsoidName'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'ERROR: mdJson reader: geodetic ellipsoid name is missing: CONTEXT is testing'

   end

   def test_ellipsoid_missing_ellipsoidName

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('ellipsoidName')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'ERROR: mdJson reader: geodetic ellipsoid name is missing: CONTEXT is testing'

   end

   def test_empty_ellipsoid_object

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse, 'testing')

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 
         'WARNING: mdJson reader: geodetic object is empty: CONTEXT is testing'

   end

end
