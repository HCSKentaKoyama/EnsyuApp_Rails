class AddColumnReports < ActiveRecord::Migration[5.2]
  def change
    add_column :reports,:notice_method,:string
  end
end
