class Reports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.date :report_date,null: false
      t.string :com_name,null: false
      t.string :exam_method,null: false
      t.date :exam_date,null: false
      t.string :exam_place,null: false
      t.string :exam_grade,null: false
      t.string :exam_content
      t.string :exam_method
      t.string :exam_detail
      t.string :free_comment
      t.string :result
      t.date :due_date
      t.string :teached_comment
      t.string :student_id
      t.string :teacher_id
      t.boolean :auth_flag,default: 0   # =>flase
      t.timestamps
    end
  end
end
