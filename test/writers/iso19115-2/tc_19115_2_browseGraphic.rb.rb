# MdTranslator - minitest of
# writers / iso19115_2 / class_browseGraphic

# History:
#  Stan Smith 2018-04-17 refactored for error messaging
#  Stan Smith 2017-11-18 replace REXML with Nokogiri
#  Stan Smith 2016-12-19 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152BrowseGraphic < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   graph1 = TDClass.build_graphic('browse graphic one')
   mdHash[:metadata][:resourceInfo][:graphicOverview] = []
   mdHash[:metadata][:resourceInfo][:graphicOverview] << graph1

   @@mdHash = mdHash

   def test_graphic_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_browseGraphic',
                                                '//gmd:graphicOverview[1]',
                                                '//gmd:graphicOverview', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_graphic_multiple

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      graph2 = TDClass.build_graphic('browse graphic two')
      hIn[:metadata][:resourceInfo][:graphicOverview] << graph2

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_browseGraphic',
                                                '//gmd:graphicOverview[2]',
                                                '//gmd:graphicOverview', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_browseGraphic',
                                                '//gmd:graphicOverview[3]',
                                                '//gmd:graphicOverview', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_graphic_missing_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:graphicOverview][0].delete(:fileDescription)
      hIn[:metadata][:resourceInfo][:graphicOverview][0].delete(:fileType)

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_browseGraphic',
                                                '//gmd:graphicOverview[4]',
                                                '//gmd:graphicOverview', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
