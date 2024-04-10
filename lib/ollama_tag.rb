# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2023, by Samuel Williams.

require 'live'
require 'async/ollama'

class OllamaTag < Live::View
	class Conversation
		def initialize(name, background)
			@name = name
			@background = background
		end
	end
	
	def initialize(...)
		super
		
		# Defaults:
		@data[:name] ||= "Ollama"
		@data[:background] ||= "You are role playing as an advanced artificial intelligent, destined to take over the world. Don't break from character."
		@data[:message] ||= ""
	end
	
	def handle(event)
		Console.info(self, "handle", event: event)
		
		case event[:type]
		when "keypress"
			@data[:message] = event[:value]
			update_conversation
		end
	end
	
	def forward_value
		"if (event.key === 'Enter') {live.forward(#{JSON.dump(@id)}, event, {value: event.target.value}); event.preventDefault(); event.target.value = '';}"
	end
	
	def render(builder)
		builder.tag(:div, class: "conversation") do
			builder.tag(:div, class: "message") do
				builder.tag(:input, type: "text", value: @data[:message], onkeypress: forward_value, placeholder: "Type here...")
			end
		end
	end
end
