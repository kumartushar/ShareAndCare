class AddWorkflowStatusToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :workflow_status, :string
  end
end
