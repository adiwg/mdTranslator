# MdTranslator - minitest of
# writers / fgdc / class_identifier

# History:
#  Stan Smith 2017-12-14 original script

require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriterFgdcBrowse < TestReaderFgdcParent

   # instance classes needed in script
   TDClass = FgdcWriterTD.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hGraphic1 = TDClass.build_graphic('graphic name one', 'description', 'type')
   hGraphic2 = TDClass.build_graphic('graphic name two', 'description', 'type')
   mdHash[:metadata][:resourceInfo][:graphicOverview] = []
   mdHash[:metadata][:resourceInfo][:graphicOverview] << hGraphic1
   mdHash[:metadata][:resourceInfo][:graphicOverview] << hGraphic2

   @@mdHash = mdHash

   def test_browse_complete

      hReturn = TestReaderFgdcParent.get_complete(@@mdHash, 'browse', './metadata/idinfo/browse')
      assert_equal hReturn[0], hReturn[1]

   end

   def test_missing_browse_description

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:graphicOverview][0].delete(:fileDescription)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute hResponseObj[:writerPass]
      assert_includes hResponseObj[:writerMessages], 'Browse Graphic is missing description'

   end

   def test_missing_browse_type

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:graphicOverview][0].delete(:fileType)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute hResponseObj[:writerPass]
      assert_includes hResponseObj[:writerMessages], 'Browse Graphic is missing file type'

   end

end
