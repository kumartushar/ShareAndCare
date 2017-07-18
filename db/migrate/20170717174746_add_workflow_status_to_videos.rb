class AddWorkflowStatusToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :workflow_state, :string
  end
end
