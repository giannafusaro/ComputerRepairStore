class CreateArchiverForRepairs < ActiveRecord::Migration

  def up
    execute <<-SQL
      CREATE TABLE archive_repairs (
        id INT(11),
        customer_id INT(11),
        employee_id INT(11),
        computer_id INT(11),
        description text,
        labor_cost DECIMAL(8,2),
        total_cost DECIMAL(8,2),
        created_at DATETIME,
        updated_at DATETIME,
        requested_for DATETIME,
        completed_at DATETIME,
        PRIMARY KEY(ID)
      );
    SQL

    execute <<-SQL
      CREATE TABLE archive_parts (
        id INT(11),
        repair_id INT(11),
        model  varchar(255),
        serial varchar(255),
        cost decimal(8,2),
        quantity INT(11),
        created_at DATETIME,
        updated_at DATETIME,
        PRIMARY KEY(ID)
      );
    SQL

    execute <<-SQL
      CREATE PROCEDURE archiveRepairs (IN cutOffDate DATETIME)
      BEGIN
        START TRANSACTION;
          INSERT INTO archive_parts
            (SELECT * FROM parts
             WHERE id IN (SELECT id FROM repairs WHERE updated_at < cutOffDate));

          INSERT INTO archive_repairs
            (SELECT * FROM repairs WHERE updated_at < cutOffDate);

          DELETE FROM parts
          WHERE id IN (SELECT id FROM repairs WHERE updated_at < cutOffDate);

          DELETE FROM repairs WHERE updated_at < cutOffDate;
        COMMIT;
      END
    SQL
  end

  def down
    execute "DROP TABLE IF EXISTS archive_parts;"
    execute "DROP TABLE IF EXISTS archive_repairs;"
    execute "DROP PROCEDURE IF EXISTS archiveRepairs;"
  end

end
