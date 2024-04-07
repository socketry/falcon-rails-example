class MyJob < ApplicationJob
  queue_as "default"

  def perform(*arguments)
    JobExecution.create!(name: self.class.name, data: {
      arguments: arguments,
    })
  end
end
