# MdTranslator - minitest of
# writers / iso19110 / class_fcFeatureCatalogue

# History:
#  Stan Smith 2018-04-05 refactored for error messaging
#  Stan Smith 2017-11-18 replace REXML with Nokogiri
#  Stan Smith 2017-01-23 original script

require_relative 'iso19110_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriter19110FeatureCatalogue < TestWriter19110Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   # dictionary
   hDictionary = TDClass.build_dataDictionary
   mdHash[:dataDictionary] << hDictionary

   @@mdHash = mdHash

   def test_featureCatalogue_complete

      # locale, responsibleParty, domain and entity tested elsewhere
      xFile = TestWriter19110Parent.get_xml('19110_fcFeatureCatalogue0')
      expect = xFile.xpath('gfc:FC_FeatureCatalogue').to_s.squeeze(' ')

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', writer: 'iso19110', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      got = xMetadata.xpath('gfc:FC_FeatureCatalogue').to_s.squeeze(' ')

      translatorVersion = ADIWG::Mdtranslator::VERSION
      writerVersion = ADIWG::Mdtranslator::Writers::Iso19110::VERSION

      assert hResponseObj[:readerStructurePass]
      assert_empty hResponseObj[:readerStructureMessages]
      assert hResponseObj[:readerValidationPass]
      assert_empty hResponseObj[:readerValidationMessages]
      assert hResponseObj[:readerExecutionPass]
      assert_empty hResponseObj[:readerExecutionMessages]
      assert_equal 'iso19110', hResponseObj[:writerRequested]
      assert_equal writerVersion, hResponseObj[:writerVersion]
      assert hResponseObj[:writerPass]
      assert_equal 'xml', hResponseObj[:writerOutputFormat]
      assert_equal translatorVersion, hResponseObj[:translatorVersion]

      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: ISO-19110 writer: feature catalogue feature type is missing'

      assert_equal expect, got

   end

   def test_featureCatalogue_elements

      # elements empty
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:dataDictionary][0][:citation][:date] = []
      hIn[:dataDictionary][0][:citation][:edition] = ''
      hIn[:dataDictionary][0][:description] = ''
      hIn[:dataDictionary][0][:recommendedUse] = []
      hIn[:dataDictionary][0][:dictionaryFunctionalLanguage] = ''

      xFile = TestWriter19110Parent.get_xml('19110_fcFeatureCatalogue1')
      expect = xFile.xpath('gfc:FC_FeatureCatalogue').to_s.squeeze(' ')

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'iso19110', showAllTags: true, validate: 'none'
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      got = xMetadata.xpath('gfc:FC_FeatureCatalogue').to_s.squeeze(' ')

      assert_equal 3, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: ISO-19110 writer: feature catalogue version number is missing'
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: ISO-19110 writer: feature catalogue version date is missing'
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: ISO-19110 writer: feature catalogue feature type is missing'

      assert_equal expect, got

      # elements missing
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:dataDictionary][0][:citation].delete(:date)
      hIn[:dataDictionary][0][:citation].delete(:edition)
      hIn[:dataDictionary][0].delete(:description)
      hIn[:dataDictionary][0].delete(:recommendedUse)
      hIn[:dataDictionary][0].delete(:dictionaryFormat)
      hIn[:dataDictionary][0].delete(:dictionaryFunctionalLanguage)

      xFile = TestWriter19110Parent.get_xml('19110_fcFeatureCatalogue1')
      expect = xFile.xpath('gfc:FC_FeatureCatalogue').to_s.squeeze(' ')

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'iso19110', showAllTags: true, validate: 'none'
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      got = xMetadata.xpath('gfc:FC_FeatureCatalogue').to_s.squeeze(' ')

      assert_equal 3, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: ISO-19110 writer: feature catalogue version number is missing'
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: ISO-19110 writer: feature catalogue version date is missing'
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: ISO-19110 writer: feature catalogue feature type is missing'

      assert_equal expect, got

   end

end
