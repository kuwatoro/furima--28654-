class CreateResidences < ActiveRecord::Migration[6.0]
  def change
    create_table :residences do |t|
      t.string     :zip_code,         default: "", null: false  
      t.integer    :prefecture_id,                 null: false  
      t.string     :municipality,     default: "", null: false 
      t.string     :street_number,    default: "", null: false 
      t.string     :building_name,    default: ""
      t.string     :telephone_number, default: "", null: false   
      t.references :order,                         null: false, foreign_key: true
      t.timestamps
    end
  end
end
