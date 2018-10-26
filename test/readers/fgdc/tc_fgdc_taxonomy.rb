# MdTranslator - minitest of
# readers / fgdc / module_taxonomy

# History:
#   Stan Smith 2017-09-20 original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcTaxonomy < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('taxonomy.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::Taxonomy

   def test_taxonomy_complete

      intMetadataClass = InternalMetadata.new
      hResourceInfo = intMetadataClass.newResourceInfo

      TestReaderFGDCParent.set_xDoc(@@xDoc)
      TestReaderFGDCParent.set_intObj
      xIn = @@xDoc.xpath('./metadata/idinfo/taxonomy')
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hTaxonomy = @@NameSpace.unpack(xIn, hResourceInfo, hResponse)

      # keywords
      aKeywords = hResourceInfo[:keywords]
      assert_equal 2, aKeywords.length
      hKeyword = aKeywords[0]
      assert_equal 'taxon', hKeyword[:keywordType]
      assert_equal 3, hKeyword[:keywords].length
      assert_equal 'taxonomy one', hKeyword[:thesaurus][:title]
      assert_equal 'animal', hKeyword[:keywords][0][:keyword]
      assert_nil hKeyword[:keywords][0][:keywordId]
      assert_equal 'bird', hKeyword[:keywords][2][:keyword]

      # taxonomy
      refute_empty hTaxonomy

      assert_equal 2, hTaxonomy[:taxonSystem].length
      assert_equal 'general taxonomic coverage', hTaxonomy[:generalScope]
      assert_equal 2, hTaxonomy[:idReferences].length
      assert_equal 2, hTaxonomy[:observers].length
      assert_equal 'identification procedure', hTaxonomy[:idProcedure]
      assert_equal 'taxonomy completeness', hTaxonomy[:idCompleteness]
      assert_equal 2, hTaxonomy[:vouchers].length
      assert_equal 1, hTaxonomy[:taxonClasses].length

      hTaxonSystem = hTaxonomy[:taxonSystem][0]
      refute_empty hTaxonSystem[:citation]
      assert_equal 'Integrated Taxonomic Information System', hTaxonSystem[:citation][:title]
      assert_equal 'none', hTaxonSystem[:modifications]

      hReference = hTaxonomy[:idReferences][0]
      assert_equal 'none', hReference[:identifier]
      assert_equal 'National Audubon Society The Sibley Guide to Birds', hReference[:citation][:title]
      assert_equal 1, hReference[:citation][:dates].length
      assert_equal '1st', hReference[:citation][:edition]
      assert_equal 1, hReference[:citation][:responsibleParties].length
      assert_equal 1, hReference[:citation][:presentationForms].length

      hObserver = hTaxonomy[:observers][0]
      assert_equal 'observer', hObserver[:roleName]
      assert_empty hObserver[:roleExtents]
      assert_equal 1, hObserver[:parties].length

      hVoucher = hTaxonomy[:vouchers][0]
      assert_equal 'specimen 1', hVoucher[:specimen]
      refute_empty hVoucher[:repository]

      hRepository = hVoucher[:repository]
      assert_equal 'custodian', hRepository[:roleName]
      assert_empty hRepository[:roleExtents]
      assert_equal 1, hRepository[:parties].length

      assert hResponse[:readerExecutionPass]
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: FGDC reader: citation publication date is missing'
      assert_equal 3, hResponse[:readerExecutionMessages].length

   end

end
