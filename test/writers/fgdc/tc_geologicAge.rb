# MdTranslator - minitest of
# writers / fgdc / class_geologicAge

# History:
#   Stan Smith 2017-11-24 original script

require_relative 'fgdc_test_parent'

class TestWriterFgdcGeologicAge < TestReaderFgdcParent

   # read the mdJson 2.0
   @@mdJson = TestReaderFgdcParent.get_hash('geologicAge')

   # read the xml expected results
   xDoc = TestReaderFgdcParent.get_xml('geologicAgeResults')
   @@axExpect = xDoc.xpath('//timeperd')


   # TODO add schema validation test after schema update

   def test_geologicAge_complete

      aReturn = TestReaderFgdcParent.get_complete('geologicAge', './metadata/idinfo/timeperd')
      assert_equal aReturn[0], aReturn[1]

   end

   def test_geologicAge_missing_elements

      xExpect = @@axExpect[1]

      hIn = Marshal::load(Marshal.dump(@@mdJson))
      hIn['metadata']['resourceInfo']['timePeriod']['startGeologicAge'].delete('ageUncertainty')
      hIn['metadata']['resourceInfo']['timePeriod']['startGeologicAge'].delete('ageExplanation')
      hIn['metadata']['resourceInfo']['timePeriod']['startGeologicAge'].delete('ageReference')
      hIn['metadata']['resourceInfo']['timePeriod']['endGeologicAge'].delete('ageUncertainty')
      hIn['metadata']['resourceInfo']['timePeriod']['endGeologicAge'].delete('ageExplanation')
      hIn['metadata']['resourceInfo']['timePeriod']['endGeologicAge'].delete('ageReference')
      hIn = hIn.to_json

      # TODO validate 'normal' after schema update
      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      xGot = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xGot.xpath('./metadata/idinfo/timeperd')

      assert_equal xExpect.to_s.squeeze(' '), xGot.to_s.squeeze(' ')

   end

   def test_geologicAge_single_age

      # start age only
      xExpect = @@axExpect[2]

      hIn = Marshal::load(Marshal.dump(@@mdJson))
      hIn['metadata']['resourceInfo']['timePeriod']['startGeologicAge'].delete('ageUncertainty')
      hIn['metadata']['resourceInfo']['timePeriod']['startGeologicAge'].delete('ageExplanation')
      hIn['metadata']['resourceInfo']['timePeriod']['startGeologicAge'].delete('ageReference')
      hIn['metadata']['resourceInfo']['timePeriod']['endGeologicAge'].delete('ageUncertainty')
      hIn['metadata']['resourceInfo']['timePeriod']['endGeologicAge'].delete('ageExplanation')
      hIn['metadata']['resourceInfo']['timePeriod']['endGeologicAge'].delete('ageReference')
      hIn['metadata']['resourceInfo']['timePeriod'].delete('endGeologicAge')
      hIn = hIn.to_json

      # TODO validate 'normal' after schema update
      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      xGot = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xGot.xpath('./metadata/idinfo/timeperd')

      assert_equal xExpect.to_s.squeeze(' '), xGot.to_s.squeeze(' ')

      # end age only
      xExpect = @@axExpect[3]

      hIn = Marshal::load(Marshal.dump(@@mdJson))
      hIn['metadata']['resourceInfo']['timePeriod']['startGeologicAge'].delete('ageUncertainty')
      hIn['metadata']['resourceInfo']['timePeriod']['startGeologicAge'].delete('ageExplanation')
      hIn['metadata']['resourceInfo']['timePeriod']['startGeologicAge'].delete('ageReference')
      hIn['metadata']['resourceInfo']['timePeriod']['endGeologicAge'].delete('ageUncertainty')
      hIn['metadata']['resourceInfo']['timePeriod']['endGeologicAge'].delete('ageExplanation')
      hIn['metadata']['resourceInfo']['timePeriod']['endGeologicAge'].delete('ageReference')
      hIn['metadata']['resourceInfo']['timePeriod'].delete('startGeologicAge')
      hIn = hIn.to_json

      # TODO validate 'normal' after schema udpdate
      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      xGot = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xGot.xpath('./metadata/idinfo/timeperd')

      assert_equal xExpect.to_s.squeeze(' '), xGot.to_s.squeeze(' ')

   end

end
