# MdTranslator - minitest of
# writers / fgdc / class_timePeriod

# History:
#   Stan Smith 2017-11-23 original script

require_relative 'fgdc_test_parent'

class TestWriterFgdcTimePeriod < TestReaderFgdcParent

   # read the mdJson 2.0
   @@mdJson = TestReaderFgdcParent.get_hash('timePeriod')

   # read the xml expected results
   xDoc = TestReaderFgdcParent.get_xml('timePeriodResults')
   @@axExpect = xDoc.xpath('//timeperd')

   # TODO add schema validation test after schema update

   def test_timePeriod_complete

      aReturn = TestReaderFgdcParent.get_complete('timePeriod', './metadata/idinfo/timeperd')
      assert_equal aReturn[0], aReturn[1]

   end

   def test_timePeriod_missing_time

      # start/end date only
      xExpect = @@axExpect[1]

      hIn = Marshal::load(Marshal.dump(@@mdJson))
      hIn['metadata']['resourceInfo']['timePeriod']['startDateTime'] = '2016-11-23'
      hIn['metadata']['resourceInfo']['timePeriod']['endDateTime'] = '2017-11-23'
      hIn = hIn.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      xGot = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xGot.xpath('./metadata/idinfo/timeperd')

      assert_equal xExpect.to_s.squeeze(' '), xGot.to_s.squeeze(' ')

      # start dateTime only
      xExpect = @@axExpect[2]

      hIn = Marshal::load(Marshal.dump(@@mdJson))
      hIn['metadata']['resourceInfo']['timePeriod']['startDateTime'] = '2017-11-24T10:45:14.666'
      hIn['metadata']['resourceInfo']['timePeriod'].delete('endDateTime')
      hIn = hIn.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      xGot = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xGot.xpath('./metadata/idinfo/timeperd')

      assert_equal xExpect.to_s.squeeze(' '), xGot.to_s.squeeze(' ')

      # start date only
      xExpect = @@axExpect[3]

      hIn = Marshal::load(Marshal.dump(@@mdJson))
      hIn['metadata']['resourceInfo']['timePeriod']['startDateTime'] = '2017-11-24'
      hIn['metadata']['resourceInfo']['timePeriod'].delete('endDateTime')
      hIn = hIn.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      xGot = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xGot.xpath('./metadata/idinfo/timeperd')

      assert_equal xExpect.to_s.squeeze(' '), xGot.to_s.squeeze(' ')

      # end dateTime only
      xExpect = @@axExpect[4]

      hIn = Marshal::load(Marshal.dump(@@mdJson))
      hIn['metadata']['resourceInfo']['timePeriod'].delete('startDateTime')
      hIn['metadata']['resourceInfo']['timePeriod']['endDateTime'] = '2017-11-24T10:48:17'
      hIn = hIn.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      xGot = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xGot.xpath('./metadata/idinfo/timeperd')

      assert_equal xExpect.to_s.squeeze(' '), xGot.to_s.squeeze(' ')

      # end date only
      xExpect = @@axExpect[5]

      hIn = Marshal::load(Marshal.dump(@@mdJson))
      hIn['metadata']['resourceInfo']['timePeriod'].delete('startDateTime')
      hIn['metadata']['resourceInfo']['timePeriod']['endDateTime'] = '2017-11-24'
      hIn = hIn.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      xGot = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xGot.xpath('./metadata/idinfo/timeperd')

      assert_equal xExpect.to_s.squeeze(' '), xGot.to_s.squeeze(' ')

   end

end
