# MdTranslator - minitest of
# readers / fgdc / module_taxonClass

# History:
#   Stan Smith 2017-09-20 original script

require 'nokogiri'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcTaxonClass < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('taxonomy.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::TaxonClass

   def test_taxonClass_complete

      xIn = @@xDoc.xpath('./metadata/idinfo/taxonomy/taxoncl')
      hTaxonClass = @@NameSpace.unpack(xIn, @@hResponseObj)

      refute_empty hTaxonClass

      assert_nil hTaxonClass[:taxonId]
      assert_equal 'kingdom', hTaxonClass[:taxonRank]
      assert_equal 'animalia', hTaxonClass[:taxonValue]
      assert_equal 1, hTaxonClass[:commonNames].length
      assert_equal 'animals', hTaxonClass[:commonNames][0]
      assert_equal 1, hTaxonClass[:subClasses].length

      hSubclass = hTaxonClass[:subClasses][0]
      assert_equal 'subkingdom', hSubclass[:taxonRank]
      assert_equal 'bilateria', hSubclass[:taxonValue]
      assert_empty hSubclass[:commonNames]
      assert_equal 1, hSubclass[:subClasses].length


      assert @@hResponseObj[:readerExecutionPass]
      assert_empty @@hResponseObj[:readerExecutionMessages]

   end

end
