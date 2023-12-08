# MdTranslator - minitest of
# adiwg / mdtranslator / mdReaders

# History:
#   Stan Smith 2016-11-14 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator'

class TestMdReaders < Minitest::Test

    # read in an mdJson 2.x file
    file = File.join(File.dirname(__FILE__), 'testData', 'mdJson_minimal.json')
    file = File.open(file, 'r')
    @@jsonObj = file.read
    file.close

    def test_mdReaders_invalid_reader

        metadata = ADIWG::Mdtranslator.translate(
            file: @@jsonObj, reader: 'xxx', writer: 'html',
            validate: 'none', showAllTags: true, cssLink: 'http://example.com/my.css'
        )

        refute_empty metadata
        assert_equal 'xxx', metadata[:readerRequested]
        refute metadata[:readerValidationPass]
        refute_empty metadata[:readerValidationMessages]

    end

end

