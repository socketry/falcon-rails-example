
require 'async/job'
require 'async/job/backend/redis'
require 'async/job/backend/inline'

Rails.application.configure do
	config.async_job.backend_for "default" do
		queue Async::Job::Backend::Redis
	end
	
	config.async_job.backend_for "local" do
		queue Async::Job::Backend::Inline
	end
end
