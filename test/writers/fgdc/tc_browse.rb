# MdTranslator - minitest of
# writers / fgdc / class_identifier

# History:
#  Stan Smith 2017-12-14 original script

require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriterFgdcBrowse < TestWriterFGDCParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hGraphic1 = TDClass.build_graphic('graphic name one', 'description', 'type')
   hGraphic2 = TDClass.build_graphic('graphic name two', 'description', 'type')
   mdHash[:metadata][:resourceInfo][:graphicOverview] = []
   mdHash[:metadata][:resourceInfo][:graphicOverview] << hGraphic1
   mdHash[:metadata][:resourceInfo][:graphicOverview] << hGraphic2

   @@mdHash = mdHash

   def test_browse_complete

      hReturn = TestWriterFGDCParent.get_complete(@@mdHash, 'browse', './metadata/idinfo/browse')
      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]

   end

   def test_missing_browse_description

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:graphicOverview][0].delete(:fileDescription)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      assert hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: browse graphic description is missing'

   end

   def test_missing_browse_type

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:graphicOverview][0].delete(:fileType)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      assert hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: browse graphic file type is missing'

   end

end
