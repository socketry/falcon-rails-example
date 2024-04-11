# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2023, by Samuel Williams.

require 'live'
require 'async/ollama'

class OllamaTag < Live::View
	def initialize(...)
		super
		
		# Defaults:
		@data[:name] ||= "Ollama"
		@data[:background] ||= "You are role playing as an advanced artificial intelligent, destined to take over the world. Don't break from character."
		@data[:prompt] ||= ""
		@data[:context] ||= nil
	end
	
	def conversation
		@conversation ||= Conversation.find_by(id: @data[:conversation_id])
	end
	
	def update_conversation(prompt)
		Console.info(self, "update_conversation", prompt: prompt)
		
		Async::Ollama::Client.open do |client|
			conversation_message = conversation.conversation_messages.build(prompt: prompt, response: String.new)
			
			generate = client.generate(prompt) do |response|
				response.body.each do |token|
					conversation_message.response += token
					replace!
				end
			end
			
			conversation_message.response = generate.response
			conversation_message.context = generate.context
			conversation_message.save!
			
			@data[:context] = generate.context
			
			replace!
		end
	end
	
	def handle(event)
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
	
	def render_message(builder, message)
		builder.tag(:p, class: "message") do
			builder.text(message.prompt)
		end
		
		builder.tag(:p, class: "response") do
			builder.text(message.response)
		end
	end
	
	def render(builder)
		builder.tag(:div, class: "conversation") do
			conversation.conversation_messages.each do |message|
				render_message(builder, message)
			end
			
			builder.tag(:input, type: "text", value: @data[:prompt], style: "width: 100%", onkeypress: forward_keypress, placeholder: "Type here...")
		end
	end
end
