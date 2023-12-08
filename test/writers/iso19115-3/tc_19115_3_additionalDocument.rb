# MdTranslator - minitest of
# writers / iso19115_3 / class_associatedResource

# History:
#  Stan Smith 2019-04-23 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_3_test_parent'

class TestWriter191151AdditionalDocument < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   mdHash[:metadata][:additionalDocumentation] = []
   mdHash[:metadata][:additionalDocumentation] << TDClass.build_additionalDocumentation

   @@mdHash = mdHash

   def test_additionalDocument_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_additionalDocument',
                                                '//mri:additionalDocumentation[1]',
                                                '//mri:additionalDocumentation', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_additionalDocument_multiple

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:additionalDocumentation] << TDClass.build_additionalDocumentation

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_additionalDocument',
                                                '//mri:additionalDocumentation[1]',
                                                '//mri:additionalDocumentation', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end


   def test_additionalDocument_multiple_citations

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:additionalDocumentation][0][:citation] << TDClass.citation_title

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_additionalDocument',
                                                '//mri:additionalDocumentation[2]',
                                                '//mri:additionalDocumentation', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_additionalDocument_multiple_objects_citations

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:additionalDocumentation] << TDClass.build_additionalDocumentation
      hIn[:metadata][:additionalDocumentation][0][:citation] << TDClass.citation_title
      hIn[:metadata][:additionalDocumentation][1][:citation] << TDClass.citation_title

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_additionalDocument',
                                                '//mri:additionalDocumentation[2]',
                                                '//mri:additionalDocumentation', 3)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
