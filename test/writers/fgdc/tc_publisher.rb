# MdTranslator - minitest of
# writers / fgdc / class_publisher

# History:
#   Stan Smith 2017-11-22 original script

require_relative 'fgdc_test_parent'

class TestWriterFgdcPublisher < TestReaderFgdcParent

   # read the mdJson 2.0
   @@mdJson = TestReaderFgdcParent.get_json('publisher')

   def test_publisher_complete

      aReturn = TestReaderFgdcParent.get_complete('publisher', './metadata/idinfo/citation/citeinfo/pubinfo')
      assert_equal aReturn[0], aReturn[1]

   end

   def test_publisher_pubplace

      # no address
      hIn = Marshal::load(Marshal.dump(@@mdJson))
      hIn['contact'][0]['address'] = []
      hIn = hIn.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])

      refute_empty xMetadata.to_s
      refute hResponseObj[:writerPass]
      refute_empty hResponseObj[:writerMessages]

      # no country
      hIn = Marshal::load(Marshal.dump(@@mdJson))
      hIn['contact'][0]['address'][0]['country'] = ''
      hIn = hIn.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath('./metadata/idinfo/citation/citeinfo/pubinfo/pubplace').text

      assert_equal 'city, admin area', xGot

      # no admin area
      hIn = Marshal::load(Marshal.dump(@@mdJson))
      hIn['contact'][0]['address'][0]['administrativeArea'] = ''
      hIn['contact'][0]['address'][0]['country'] = ''
      hIn = hIn.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath('./metadata/idinfo/citation/citeinfo/pubinfo/pubplace').text

      assert_equal 'city', xGot

      # no city
      hIn = Marshal::load(Marshal.dump(@@mdJson))
      hIn['contact'][0]['address'][0]['city'] = ''
      hIn['contact'][0]['address'][0]['administrativeArea'] = ''
      hIn['contact'][0]['address'][0]['country'] = ''
      hIn = hIn.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath('./metadata/idinfo/citation/citeinfo/pubinfo/pubplace').text

      assert_equal 'address description', xGot

      # no description
      hIn = Marshal::load(Marshal.dump(@@mdJson))
      hIn['contact'][0]['address'][0]['description'] = ''
      hIn['contact'][0]['address'][0]['city'] = ''
      hIn['contact'][0]['address'][0]['administrativeArea'] = ''
      hIn['contact'][0]['address'][0]['country'] = ''
      hIn = hIn.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])

      refute_empty xMetadata.to_s
      refute hResponseObj[:writerPass]
      refute_empty hResponseObj[:writerMessages]

   end

end
