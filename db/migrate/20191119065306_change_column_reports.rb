class ChangeColumnReports < ActiveRecord::Migration[5.2]
  def change
    change_column :reports, :auth_flag, :string
  end
end
