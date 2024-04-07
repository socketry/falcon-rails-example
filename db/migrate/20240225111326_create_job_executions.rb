class CreateJobExecutions < ActiveRecord::Migration[7.1]
  def change
    create_table :job_executions do |t|
      t.string :name
      t.json :data

      t.timestamps
    end
  end
end
