require 'pry'
class Pokemon
    attr_accessor :name, :type
    attr_reader :id, :db

    def initialize(hash)
        @name = hash[:name]
        @type = hash[:type]
        @id = hash[:id]
        @db = hash[:db]
    end 

    def self.save(name, type, db)
       

        sql = <<-SQL 
        INSERT INTO pokemon (name, type)
        VALUES (?, ?)
        SQL

        db.execute(sql, name, type)
        #@id=db.execute("SELECT last_insert_rowid() FROM pokemon" )[0][0]
    end 

    def self.new_from_db(row)
        new_pokemon_hash = { }
        
        new_pokemon_hash[:id]= row[0]
        new_pokemon_hash[:name] = row[1]
        new_pokemon_hash[:type] = row[2]
        new_pokemon_hash[:db] = row[3]
        new_pokemon = self.new(new_pokemon_hash)
      
        new_pokemon
      end 

    def self.find(id, db)
    sql = <<-SQL 
    SELECT * FROM pokemon
    WHERE id =?
    LIMIT 1
    SQL

    db.execute(sql, id).map do |row|
        self.new_from_db(row)
        end.first
        #binding.pry
    end 



end


