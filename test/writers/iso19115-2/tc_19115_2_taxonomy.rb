# MdTranslator - minitest of
# writers / iso19115_2 / class_taxonomy

# History:
#  Stan Smith 2018-05-01 refactored for error messaging
#  Stan Smith 2017-11-20 replace REXML with Nokogiri
#  Stan Smith 2017-01-13 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152Taxonomy < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hTaxonomy = TDClass.build_taxonomy
   hTaxonomy[:taxonomicSystem] << TDClass.build_taxonSystem('taxonomic system two',
                                                            'CID003', 'modifications two')
   hTaxonomy[:identificationReference] << TDClass.build_identifier('TID001')
   hTaxonomy[:observer] << TDClass.build_responsibleParty('observer one', %w(CID003 CID004))
   hTaxonomy[:observer] << TDClass.build_responsibleParty('observer two', %w(CID003))
   hTaxonomy[:voucher] << TDClass.build_taxonVoucher('specimen one', %w(CID003))
   hTaxonomy[:voucher] << TDClass.build_taxonVoucher('specimen two', %w(CID004))

   hLevel0 = hTaxonomy[:taxonomicClassification]
   hLevel0[:taxonomicSystemId] = 'ITIS-1234-1234-abcd'
   hLevel0[:taxonomicLevel] = 'kingdom'
   hLevel0[:taxonomicName] = 'animalia'
   hLevel0[:commonName] = ['animals']

   mdHash[:metadata][:resourceInfo][:taxonomy] = []
   mdHash[:metadata][:resourceInfo][:taxonomy] << hTaxonomy

   @@mdHash = mdHash

   def test_taxonomicSystem_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_taxonomy',
                                                '//gmd:taxonomy[1]',
                                                '//gmd:taxonomy', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_equal 2, hReturn[3].length
      assert_includes hReturn[3],
                      'WARNING: ISO-19115-2 writer: citation dates are missing: CONTEXT is taxon identification reference authority citation'

   end

   def test_taxonomicSystem_missing_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hTaxonomy = hIn[:metadata][:resourceInfo][:taxonomy][0]
      hTaxonomy[:taxonomicSystem].delete_at(1)
      hTaxonomy.delete(:generalScope)
      hTaxonomy.delete(:identificationReference)
      hTaxonomy.delete(:observer)
      hTaxonomy.delete(:identificationCompleteness)
      hTaxonomy.delete(:voucher)


      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_taxonomy',
                                                '//gmd:taxonomy[2]',
                                                '//gmd:taxonomy', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_equal 1, hReturn[3].length
      assert_includes hReturn[3],
                      'WARNING: ISO-19115-2 writer: taxonomic identification reference is missing'

   end

end
