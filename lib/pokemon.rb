class Pokemon
    attr_accessor :id, :name, :type, :db
    def initialize(id:, name:, type:, db:)
        @id = id
        @name = name
        @type = type
        @db = db
    end

    def self.save(name, type, db)
            sql = <<-SQL
                INSERT INTO pokemon (name, type) 
                VALUES (?, ?)
            SQL
            db.execute(sql, name, type)
    end

    def self.find(id, db)
        sql = <<-SQL
            SELECT * 
            FROM pokemon
            WHERE id = ?
        SQL
        new_poke = db.execute(sql, id)
        Pokemon.new(id: new_poke[0][0], name: new_poke[0][1], type: new_poke[0][2], db: db)
    end
    
end