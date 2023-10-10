# MdTranslator - minitest of
# parent class for all tc_sbjson tests

# History:
# Stan Smith 2017-05-12 original script

require 'minitest/autorun'
require 'json'
require 'json-schema'

class TestWriterSbJsonParent < Minitest::Test

   # get json file for tests from examples folder
   def self.getJson(fileName)

      file = File.join(File.dirname(__FILE__), 'testData', fileName)
      file = File.open(file, 'r')
      jsonFile = file.read
      file.close
      return jsonFile

   end

end

class Hash
   def deep_diff(other)
      (self.keys + other.keys).uniq.inject({}) do |memo, key|
         left = self[key]
         right = other[key]

         next memo if left == right

         if left.respond_to?(:deep_diff) && right.respond_to?(:deep_diff)
            memo[key] = left.deep_diff(right)
         else
            memo[key] = [left, right]
         end

         memo
      end
   end
end

class Array
   def deep_diff(array)
      largest = [self.count, array.count].max
      memo = {}

      0.upto(largest - 1) do |index|
         left = self[index]
         right = array[index]

         next if left == right

         if left.respond_to?(:deep_diff) && right.respond_to?(:deep_diff)
            memo[index] = left.deep_diff(right)
         else
            memo[index] = [left, right]
         end
      end
   end
end
