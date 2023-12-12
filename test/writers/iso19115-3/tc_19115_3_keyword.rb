# MdTranslator - minitest of
# writers / iso19115_3 / class_keyword

# History:
#  Stan Smith 2019-05-07 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_3_test_parent'

class TestWriter191151Keyword < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hKeywords1 = TDClass.build_keywords
   TDClass.add_keyword(hKeywords1,'keyword one')
   TDClass.add_keyword(hKeywords1,'keyword two', 'KWID001')
   mdHash[:metadata][:resourceInfo][:keyword] << hKeywords1

   @@mdHash = mdHash

   def test_image_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_keyword',
                                                '//mri:descriptiveKeywords[1]',
                                                '//mri:descriptiveKeywords', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_keyword',
                                                '//mri:descriptiveKeywords[2]',
                                                '//mri:descriptiveKeywords', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_keyword',
                                                '//mri:topicCategory[1]',
                                                '//mri:topicCategory', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_keyword',
                                                '//mri:topicCategory[2]',
                                                '//mri:topicCategory', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
