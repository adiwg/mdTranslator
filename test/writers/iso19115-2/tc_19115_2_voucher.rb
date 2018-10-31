# MdTranslator - minitest of
# writers / iso19115_2 / class_voucher

# History:
#  Stan Smith 2018-10-25 refactor to support schema 2.6.0 changes to projection
#  Stan Smith 2018-05-03 refactored for error messaging
#  Stan Smith 2017-11-20 replace REXML with Nokogiri
#  Stan Smith 2017-01-13 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152Voucher < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hVoucher = TDClass.build_taxonVoucher('specimen one', ['CID003'])
   hTaxonomy = TDClass.taxonomy
   hTaxonomy[:voucher] << hVoucher
   mdHash[:metadata][:resourceInfo][:taxonomy] = []
   mdHash[:metadata][:resourceInfo][:taxonomy] << hTaxonomy

   @@mdHash = mdHash

   def test_voucher_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_voucher',
                                                '//gmd:voucher[1]',
                                                '//gmd:voucher', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
