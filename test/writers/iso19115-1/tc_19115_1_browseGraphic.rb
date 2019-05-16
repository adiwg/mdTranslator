# MdTranslator - minitest of
# writers / iso19115_1 / class_browseGraphic

# History:
#  Stan Smith 2019-04-18 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_1_test_parent'

class TestWriter191151BrowseGraphic < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   graph1 = TDClass.build_graphic('browse graphic one')
   graph1[:fileConstraint] << TDClass.useConstraint
   graph1[:fileUri] << TDClass.build_onlineResource('https://www.adiwg.org/1')
   mdHash[:metadata][:resourceInfo][:graphicOverview] = []
   mdHash[:metadata][:resourceInfo][:graphicOverview] << graph1

   @@mdHash = mdHash

   def test_graphic_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_browseGraphic',
                                                '//mri:graphicOverview[1]',
                                                '//mri:graphicOverview', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_graphic_complete_multiple

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hIn[:metadata][:resourceInfo][:graphicOverview][0][:fileConstraint] << TDClass.securityConstraint
      hIn[:metadata][:resourceInfo][:graphicOverview][0][:fileUri] <<
         TDClass.build_onlineResource('https://www.adiwg.org/2')
      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_browseGraphic',
                                                '//mri:graphicOverview[2]',
                                                '//mri:graphicOverview', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_graphic_missing_elements

      # empty elements
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:graphicOverview][0][:fileDescription] = ''
      hIn[:metadata][:resourceInfo][:graphicOverview][0][:fileType] = ''
      hIn[:metadata][:resourceInfo][:graphicOverview][0][:fileConstraint] = []
      hIn[:metadata][:resourceInfo][:graphicOverview][0][:fileUri] = []

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_browseGraphic',
                                                '//mri:graphicOverview[3]',
                                                '//mri:graphicOverview', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      # missing elements
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:graphicOverview][0].delete(:fileDescription)
      hIn[:metadata][:resourceInfo][:graphicOverview][0].delete(:fileType)
      hIn[:metadata][:resourceInfo][:graphicOverview][0].delete(:fileConstraint)
      hIn[:metadata][:resourceInfo][:graphicOverview][0].delete(:fileUri)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_browseGraphic',
                                                '//mri:graphicOverview[3]',
                                                '//mri:graphicOverview', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
