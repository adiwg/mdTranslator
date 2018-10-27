# MdTranslator - minitest of
# reader / mdJson / module_taxonomy

# History:
#  Stan Smith 2018-10-19 refactored for mdJson 2.6.0 schema
#  Stan Smith 2018-06-26 refactored to use mdJson construction helpers
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-10-22 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_taxonomy'

class TestReaderMdJsonTaxonomy < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Taxonomy

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.build_taxonomy_full

   @@mdHash = mdHash

   def test_taxonomy_schema

      errors = TestReaderMdJsonParent.testSchema(@@mdHash, 'taxonomy.json')
      assert_empty errors

   end

   def test_complete_taxonomy_object

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 2, metadata[:taxonSystem].length
      assert_equal 'general scope', metadata[:generalScope]
      assert_equal 2, metadata[:idReferences].length
      assert_equal 2, metadata[:observers].length
      assert_equal 'procedures', metadata[:idProcedure]
      assert_equal 'completeness', metadata[:idCompleteness]
      assert_equal 2, metadata[:vouchers].length
      assert_equal 2, metadata[:taxonClasses].length
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_taxonomy_empty_classSystem

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['taxonomicSystem'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: taxonomic classification system object is missing'

   end

   def test_taxonomy_missing_classSystem

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('taxonomicSystem')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: taxonomic classification system object is missing'

   end

   def test_taxonomy_empty_taxClass

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['taxonomicClassification'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: taxonomic classification is missing'

   end

   def test_taxonomy_missing_taxClass

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('taxonomicClassification')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: taxonomic classification is missing'

   end

   def test_taxonomy_deprecated_taxClass_object

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['taxonomicClassification'] = hIn['taxonomicClassification'][0]
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'NOTICE: mdJson reader: taxonomic classification is an array, use of taxonomic classification object is deprecated'

   end

   def test_taxonomy_empty_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['generalScope'] = ''
      hIn['identificationReference'] = []
      hIn['observer'] = []
      hIn['identificationProcedure'] = ''
      hIn['identificationCompleteness'] = ''
      hIn['voucher'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_empty metadata[:taxonSystem]
      assert_nil metadata[:generalScope]
      assert_empty metadata[:idReferences]
      assert_empty metadata[:observers]
      assert_nil metadata[:idProcedure]
      assert_nil metadata[:idCompleteness]
      assert_empty metadata[:vouchers]
      refute_empty metadata[:taxonClasses]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_taxonomy_missing_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('generalScope')
      hIn.delete('identificationReference')
      hIn.delete('observer')
      hIn.delete('identificationProcedure')
      hIn.delete('identificationCompleteness')
      hIn.delete('voucher')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_empty metadata[:taxonSystem]
      assert_nil metadata[:generalScope]
      assert_empty metadata[:idReferences]
      assert_empty metadata[:observers]
      assert_nil metadata[:idProcedure]
      assert_nil metadata[:idCompleteness]
      assert_empty metadata[:vouchers]
      refute_empty metadata[:taxonClasses]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_taxonomy_deprecated_idReference_identifier

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:identificationReference][1] = TDClass.identifier
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 2, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'NOTICE: mdJson reader: taxonomic identification reference as an identifier is deprecated, use citation'
      assert_includes hResponse[:readerExecutionMessages], 'NOTICE: mdJson reader: taxonomic identification reference authority was substituted for citation'

   end

   def test_taxonomy_deprecated_idReference_identifier_no_authority

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:identificationReference][1] = TDClass.identifier
      hIn[:identificationReference][1].delete(:authority)
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 2, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'NOTICE: mdJson reader: taxonomic identification reference as an identifier is deprecated, use citation'
      assert_includes hResponse[:readerExecutionMessages], 'NOTICE: mdJson reader: taxonomic identification reference authority is empty or missing'

   end

   def test_empty_taxonomy_object

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson reader: taxonomy object is empty'

   end

end