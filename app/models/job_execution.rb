class JobExecution < ApplicationRecord
	# broadcasts_refreshes
	after_create_commit -> { broadcast_append_to "job_executions" }
end
