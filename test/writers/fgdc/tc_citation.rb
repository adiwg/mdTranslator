# MdTranslator - minitest of
# writers / fgdc / class_citation

# History:
#  Stan Smith 2017-11-17 original script

require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriterFgdcCitation < TestReaderFgdcParent

   # instance classes needed in script
   TDClass = FgdcWriterTD.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   mdHash[:contact] << TDClass.build_person('CID002', 'person name two')
   mdHash[:contact] << TDClass.build_person('CID003', 'person name three')
   mdHash[:contact] << TDClass.build_person('CID004', 'person name four')

   hCitation = TDClass.citation_full
   hCitation[:date] << TDClass.build_date('2017-12-01T16:32:36', 'revision')
   hCitation[:date] << TDClass.build_date('2017-12-01T16:32:36', 'publication')
   hCitation[:responsibleParty] << TDClass.build_responsibleParty('originator', ['CID003', 'CID002'])
   hCitation[:responsibleParty] << TDClass.build_responsibleParty('publisher', ['CID001', 'CID002'])
   hCitation[:responsibleParty] << TDClass.build_responsibleParty('originator', ['CID004', 'CID002'])
   mdHash[:metadata][:resourceInfo][:citation] = hCitation

   mdHash[:metadata][:associatedResource] = []
   mdHash[:metadata][:associatedResource] << TDClass.build_associatedResource('decoy')
   mdHash[:metadata][:associatedResource] << TDClass.build_associatedResource('largerWorkCitation')

   @@mdHash = mdHash

   def test_citation_complete

      hReturn = TestReaderFgdcParent.get_complete(@@mdHash, 'citation', './metadata/idinfo/citation')
      assert_equal hReturn[0], hReturn[1]

   end

   def test_citation_originator

      # empty
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:citation][:responsibleParty] = []

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute hResponseObj[:writerPass]
      assert_includes hResponseObj[:writerMessages], 'Citation is missing originator'

      # missing
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:citation].delete(:responsibleParty)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute hResponseObj[:writerPass]
      assert_includes hResponseObj[:writerMessages], 'Citation is missing originator'

   end

   def test_citation_publication_date_format

      # year only
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:citation][:date][0][:date] = '2014'

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      pubDate = xMetadata.xpath('./metadata/idinfo/citation/citeinfo/pubdate').text
      pubTime = xMetadata.xpath('./metadata/idinfo/citation/citeinfo/pubtime').text

      assert_equal '2014', pubDate
      assert_empty pubTime

      # year-month only
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:citation][:date][0][:date] = '2015-11'

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      pubDate = xMetadata.xpath('./metadata/idinfo/citation/citeinfo/pubdate').text
      pubTime = xMetadata.xpath('./metadata/idinfo/citation/citeinfo/pubtime').text

      assert_equal '201511', pubDate
      assert_empty pubTime

      # year-month-day only
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:citation][:date][0][:date] = '2016-12-25'

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      pubDate = xMetadata.xpath('./metadata/idinfo/citation/citeinfo/pubdate').text
      pubTime = xMetadata.xpath('./metadata/idinfo/citation/citeinfo/pubtime').text

      assert_equal '20161225', pubDate
      assert_empty pubTime

   end

   def test_citation_publication_date

      # empty
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:citation][:date] = []

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute hResponseObj[:writerPass]
      assert_includes hResponseObj[:writerMessages], 'Citation is missing publication date'

      # missing
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:citation].delete(:date)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute hResponseObj[:writerPass]
      assert_includes hResponseObj[:writerMessages], 'Citation is missing publication date'

   end

end
