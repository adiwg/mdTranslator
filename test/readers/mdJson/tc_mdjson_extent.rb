# MdTranslator - minitest of
# reader / mdJson / module_extent

# History:
#  Stan Smith 2018-06-18 refactored to use mdJson construction helpers
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-10-30 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_extent'

class TestReaderMdJsonExtent < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Extent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.extent
   mdHash[:geographicExtent] << TDClass.geographicExtent
   mdHash[:geographicExtent] << TDClass.geographicExtent
   mdHash[:verticalExtent] << TDClass.verticalExtent
   mdHash[:verticalExtent] << TDClass.verticalExtent
   TDClass.add_temporalExtent(mdHash, 'TI001', 'instant', '2018-06-19T10:51')
   TDClass.add_temporalExtent(mdHash, 'TP001', 'period', '2018-06-19T10:52')

   @@mdHash = mdHash

   def test_extent_schema

      errors = TestReaderMdJsonParent.testSchema(@@mdHash, 'extent.json')
      assert_empty errors

   end

   def test_complete_extent_object

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'description', metadata[:description]
      assert_equal 2, metadata[:geographicExtents].length
      assert_equal 2, metadata[:temporalExtents].length
      assert_equal 2, metadata[:verticalExtents].length
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_extent_required

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['description'] = ''
      hIn['geographicExtent'] = []
      hIn['temporalExtent'] = []
      hIn['verticalExtent'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'ERROR: mdJson reader: extent must have description or at least one geographic, temporal, or vertical extent'

   end

   def test_missing_extent_required

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['nonElement'] = ''
      hIn.delete('description')
      hIn.delete('geographicExtent')
      hIn.delete('temporalExtent')
      hIn.delete('verticalExtent')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'ERROR: mdJson reader: extent must have description or at least one geographic, temporal, or vertical extent'

   end

   def test_empty_extent_object

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: mdJson reader: extent object is empty'

   end

end
