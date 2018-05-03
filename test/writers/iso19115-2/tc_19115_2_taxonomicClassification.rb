# MdTranslator - minitest of
# writers / iso19115_2 / class_taxonomicClassification

# History:
#  Stan Smith 2018-05-01 refactored for error messaging
#  Stan Smith 2017-11-20 replace REXML with Nokogiri
#  Stan Smith 2017-01-13 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152TaxonomicClassification < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hTaxonomy = TDClass.taxonomy
   hTaxonomy.delete(:generalScope)
   hTaxonomy.delete(:identificationReference)
   hTaxonomy.delete(:observer)
   hTaxonomy.delete(:identificationCompleteness)
   hTaxonomy.delete(:voucher)

   hLevel0 = hTaxonomy[:taxonomicClassification]
   hLevel0[:taxonomicSystemId] = 'ITIS-1234-1234-abcd'
   hLevel0[:taxonomicLevel] = 'kingdom'
   hLevel0[:taxonomicName] = 'animalia'
   hLevel0[:commonName] = ['animals']
   TDClass.add_taxonClass(hLevel0, 'subkingdom', 'bilateria')

   hLevel1 = hLevel0[:subClassification][0]
   TDClass.add_taxonClass(hLevel1, 'subfamily', 'anserinae')

   hLevel2 = hLevel1[:subClassification][0]
   TDClass.add_taxonClass(hLevel2, 'genus', 'branta')
   TDClass.add_taxonClass(hLevel2, 'genus', 'anser', ['brent geese'])

   hLevel20 = hLevel2[:subClassification][0]
   hLevel21 = hLevel2[:subClassification][1]
   TDClass.add_taxonClass(hLevel20, 'species', 'branta bernicla', ['brant goose','ganso de collar'])
   TDClass.add_taxonClass(hLevel21, 'species', 'albifrons')

   mdHash[:metadata][:resourceInfo][:taxonomy] = []
   mdHash[:metadata][:resourceInfo][:taxonomy] << hTaxonomy

   @@mdHash = mdHash

   def test_taxonomicClassification_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_taxonomicClassification',
                                                '//gmd:taxonomy[1]',
                                                '//gmd:taxonomy', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_equal 1, hReturn[3].length
      assert_equal hReturn[3][0], 'WARNING: ISO-19115-2 writer: taxonomic identification reference is missing'

   end

end
