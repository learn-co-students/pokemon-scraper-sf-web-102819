class Pokemon
    attr_accessor :id, :name, :type, :db
    

    # is initialized with keyword arguments of id, name, type and db
    # def initialize(hash)
    #     @id = hash[:id]
    #     @name = hash[:name]
    #     @type = hash[:type]
    #     @db = hash[:db]
    # end

    # OR

    # Ruby 2.0 introduced first-class support for keyword arguments:
    def initialize(id: , name:, type:, db:)
        @id = id
        @name = name
        @type = type
        @db = db
    end




    # saves an instance of a pokemon with the correct id
    def self.save(name, type, db)
        sql = <<-SQL
            INSERT INTO pokemon (name, type) 
            VALUES (?, ?)
        SQL

        db.execute(sql, name, type)

        @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
        
        # OR
        # db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)", name, type)
    end 



    # finds a pokemon from the database by their id number and returns a new Pokemon object
    def self.find(id, db)
        sql = <<-SQL
            SELECT * FROM pokemon
            WHERE id = ?
        SQL

        db.execute(sql, id).map do |row|
            new_pokemon = Pokemon.new({id: row[0], name: row[1], type: row[2], db: db})
        end.first

        # OR
        # data = db.execute(sql, id)[0]
        # Pokemon.new({id: data[0], name: data[1], type: data[2], db: db})
    end

    
    




end
