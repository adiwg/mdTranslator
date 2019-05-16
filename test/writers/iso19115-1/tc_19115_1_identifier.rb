# MdTranslator - minitest of
# writers / iso19115_1 / class_mdIdentifier

# History:
#  Stan Smith 2019-04-29 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_1_test_parent'

class TestWriter191151MDIdentifier < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   mdHash[:metadata][:metadataInfo][:metadataIdentifier] = TDClass.build_identifier('metadata identifier')

   @@mdHash = mdHash

   def test_identifier_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_identifier',
                                                '//mdb:metadataIdentifier[1]',
                                                '//mdb:metadataIdentifier', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_identifier_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIdentifier = hIn[:metadata][:metadataInfo][:metadataIdentifier]

      # empty elements
      hIdentifier[:namespace] = ''
      hIdentifier[:version] = ''
      hIdentifier[:description] = ''
      hIdentifier[:authority] = {}

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_identifier',
                                                '//mdb:metadataIdentifier[2]',
                                                '//mdb:metadataIdentifier', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      # missing elements
      hIdentifier.delete(:namespace)
      hIdentifier.delete(:version)
      hIdentifier.delete(:description)
      hIdentifier.delete(:authority)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_identifier',
                                                '//mdb:metadataIdentifier[2]',
                                                '//mdb:metadataIdentifier', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
