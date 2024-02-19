#
# Copyright 2024- TODO: Write your name
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "fluent/plugin/parser"

module Fluent
  module Plugin
    class PipeParser < Fluent::Plugin::Parser
      Fluent::Plugin.register_parser("pipe", self)

      def parse(text)
        text.split("\n").each do |line|
          values = line.split("|")

          ret_record = {}
          values.each_with_index do |value, index|
            # valueが空白やnilの場合はスキップ
            next if value.nil? || value.empty?
            ret_record[index.to_s] = value
          end
        
          yield ret_record
        end
      end
    end
  end
end
