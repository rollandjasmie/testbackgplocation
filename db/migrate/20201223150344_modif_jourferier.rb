class ModifJourferier < ActiveRecord::Migration[6.0]
    def self.up
      change_table :jourferiers do |t|
        t.change :surplus, :float
      end
    end
    def self.down
      change_table :jourferiers do |t|
        t.change :surplus, :integer
      end
    end
end
