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
		@data[:prompt] ||= ""
		@data[:response] ||= ""
		@data[:context] ||= nil
	end
	
	def update_conversation(prompt)
		Console.info(self, "update_conversation", prompt: prompt)
		
		Async::Ollama::Client.open do |client|
			generate = client.generate(prompt)
			
			@data[:response] = generate.response
			@data[:context] = generate.context
			
			replace!
		end
	end
	
	def handle(event)
		Console.info(self, "handle", event: event)
		
		case event[:type]
		when "keypress"
			details = event[:details]
			@data[:prompt] = details[:value]
			
			if details[:key] == "Enter"
				prompt = @data[:prompt]
				@data[:prompt] = ""
				update_conversation(prompt)
				
				replace!
			end
		end
	end
	
	def forward_keypress
		"live.forward(#{JSON.dump(@id)}, event, {value: event.target.value, key: event.key})"
	end
	
	def render(builder)
		builder.tag(:div, class: "conversation") do
			builder.tag(:p, class: "response") do
				builder.text(@data[:response])
			end
			
			builder.tag(:input, type: "text", value: @data[:prompt], style: "width: 100%", onkeypress: forward_keypress, placeholder: "Type here...")
		end
	end
end
