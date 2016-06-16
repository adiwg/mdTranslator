require 'minitest/autorun'
require 'json'
# require 'adiwg-mdtranslator'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/sbJson/sbJson_reader'

class TestTranslation_sbJson_v0 < MiniTest::Test
  @@reader = 'sbJson'
  @@writer = 'iso19115_2'

  def test_full_success
    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), './', 'test.json')
    file = File.open(file, 'r')
    jsonObj = file.read
    file.close

    # call opening module in mdTranslator
    metadata = ADIWG::Mdtranslator.translate(
      file: jsonObj, reader: @@reader, validate: 'normal',
      writer: @@writer, showAllTags: 'true')

    # sbJson doesn't support versioning
    version = %w(0 0 0)

    assert_equal('json', metadata[:readerFormat], 'Check reader name')
    assert metadata[:readerStructurePass], metadata[:readerStructureMessages].join(',')
    assert_equal(@@reader, metadata[:readerRequested])

    # major version
    assert_equal(version[0], metadata[:readerVersionUsed].split('.')[0])

    assert metadata[:readerValidationPass], "reader validation failed: \n" + metadata[:readerValidationMessages].join(',')
    assert_equal(@@writer, metadata[:writerName])
    assert metadata[:writerPass], "writer validation failed: \n" + metadata[:writerMessages].join(',')
    refute_nil metadata[:writerOutput]
  end

  def test_minimum_success
    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), './', 'test.json')
    file = File.open(file, 'r')
    jsonObj = file.read
    file.close

    # call opening module in mdTranslator
    metadata = ADIWG::Mdtranslator.translate(
      file: jsonObj, reader: @@reader, validate: 'normal',
      writer: @@writer, showAllTags: 'true')

    assert_equal('json', metadata[:readerFormat], 'Check reader name')
    assert metadata[:readerStructurePass], metadata[:readerStructureMessages].join(',')
    assert_equal(@@reader, metadata[:readerRequested])
    assert metadata[:readerValidationPass], "reader validation failed: \n" + metadata[:readerValidationMessages].join(',')
    assert_equal(@@writer, metadata[:writerName])
    assert metadata[:writerPass], "writer validation failed: \n" + metadata[:writerMessages].join(',')
    refute_nil metadata[:writerOutput]
  end

  def test_writers
    dir = File.join(File.dirname(__FILE__), '../../../..', 'lib/adiwg/mdtranslator/writers')
    writers = (Dir.glob "#{dir}/*/").map { |a| File.basename(a) }.reject!{ |a| a == 'iso19110' }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), './', 'test.json')
    file = File.open(file, 'r')
    jsonObj = file.read
    file.close

    writers.each do |writer|
      # call opening module in mdTranslator
      metadata = ADIWG::Mdtranslator.translate(
        file: jsonObj, reader: @@reader, validate: 'normal',
        writer: writer, showAllTags: 'true')

      refute_nil metadata[:writerOutput], "Failed to translate #{@@reader} to #{writer}!"
    end
  end
end
