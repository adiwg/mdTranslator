# MdTranslator - minitest of
# writers / iso19115_1 / class_responsibility

# History:
#  Stan Smith 2019-05-10 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_1_test_parent'

class TestWriter191151Responsibility < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   @@mdHash = mdHash

   def test_responsibility_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      aExtent = hIn[:metadata][:metadataInfo][:metadataContact][0][:roleExtent] = []
      aExtent << TDClass.build_extent

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_responsibility',
                                                '//mdb:contact[1]',
                                                '//mdb:contact', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_responsibility_elements

      # missing elements
      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_responsibility',
                                                '//mdb:contact[2]',
                                                '//mdb:contact', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      # empty elements
      hIn[:metadata][:metadataInfo][:metadataContact][0][:roleExtent] = []

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_responsibility',
                                                '//mdb:contact[2]',
                                                '//mdb:contact', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_responsibility_multiple

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      aExtent = hIn[:metadata][:metadataInfo][:metadataContact][0][:roleExtent] = []
      aExtent << TDClass.build_extent('extent one')
      aExtent << TDClass.build_extent('extent two')

      hIn[:metadata][:metadataInfo][:metadataContact][0][:party] << { contactId: 'CID002' }


      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_responsibility',
                                                '//mdb:contact[3]',
                                                '//mdb:contact', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
