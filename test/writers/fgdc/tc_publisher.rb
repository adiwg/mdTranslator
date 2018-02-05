# MdTranslator - minitest of
# writers / fgdc / class_publisher

# History:
#  Stan Smith 2017-11-22 original script

require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriterFgdcPublisher < TestWriterFGDCParent

   # instance classes needed in script
   TDClass = FgdcWriterTD.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hRepParty = TDClass.build_responsibleParty('publisher', ['CID001'])
   mdHash[:metadata][:resourceInfo][:citation][:responsibleParty] << hRepParty

   @@mdHash = mdHash

   def test_publisher_complete

      hReturn = TestWriterFGDCParent.get_complete(@@mdHash, 'publisher', './metadata/idinfo/citation/citeinfo/pubinfo')
      assert_equal hReturn[0], hReturn[1]

   end

   def test_publisher_place

      # no address
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:contact][0][:address] = []

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])

      refute_empty xMetadata.to_s
      refute hResponseObj[:writerPass]
      assert_includes hResponseObj[:writerMessages], 'Publisher is missing place of publication'

      # no country
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:contact][0][:address][0][:country] = ''

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      got = xMetadata.xpath('./metadata/idinfo/citation/citeinfo/pubinfo/pubplace').text

      assert_equal 'city, administrative area', got

      # no admin area
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:contact][0][:address][0][:administrativeArea] = ''
      hIn[:contact][0][:address][0][:country] = ''

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      got = xMetadata.xpath('./metadata/idinfo/citation/citeinfo/pubinfo/pubplace').text

      assert_equal 'city', got

      # no city
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:contact][0][:address][0][:city] = ''
      hIn[:contact][0][:address][0][:administrativeArea] = ''
      hIn[:contact][0][:address][0][:country] = ''

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      got = xMetadata.xpath('./metadata/idinfo/citation/citeinfo/pubinfo/pubplace').text

      assert_equal 'address description', got

      # no description
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:contact][0][:address][0]['description'] = ''
      hIn[:contact][0][:address][0][:city] = ''
      hIn[:contact][0][:address][0][:administrativeArea] = ''
      hIn[:contact][0][:address][0][:country] = ''

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])

      refute_empty xMetadata.to_s
      refute hResponseObj[:writerPass]
      assert_includes hResponseObj[:writerMessages], 'Publisher is missing place of publication'

   end

end
