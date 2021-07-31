class RefrigerationTimeController < ApplicationController
  def index
  end

  def updateOutTime
    updateParams = updateOutTimeParams
    item_id, location_id, timestamp = updateParams[:item_id], updateParams[:location_id], updateParams[:timestamp]

    sql = %{
      SELECT * 
      FROM cache_tables 
      WHERE item_id = #{item_id}
      LIMIT 1
    }

    # Queries
    cache_table_record = ActiveRecord::Base.connection.execute sql
    curr_location = Location.find(location_id)

    if cache_table_record
      new_time_outside = cache_table_record[:time_outside] 
      unless cache_table_record[:prev_loc_is_freezer]
        new_time_outside += (timestamp - cache_table_record[:last_time_stamp])
      end

      sql = %{
        UPDATE cache_tables
        SET time_outside        = #{new_time_outside}
        SET prev_loc_is_freezer = #{curr_location[:is_freezer]}
        SET last_time_stamp     = #{timestamp}
        WHERE item_id           = #{item_id}
      }
    else
      # If you don't have a cache_record => you are in a refrigerator
      new_time_outside = 0
      sql = %{
        INSERT INTO cache_tables (#{item_id}, #{new_time_outside}, #{curr_location[:is_freezer]}, #{timestamp})
      }
    end

    ActiveRecord::Base.connection.execute sql
    redirect_to get_out_time_path
  end

  def getOutTime
    @item_id = getOutTimeParams[:item_id]

    sql = %{
      SELECT * 
      FROM cache_tables 
      WHERE item_id = #{@item_id}
      LIMIT 1
    }

    # Queries
    cache_table_record = ActiveRecord::Base.connection.execute sql
    @outTime = cache_table_record ? cache_table_record[:time_outside] : 0
  end

  def reset
    sql = %{
      DELETE FROM cache_tables WHERE TRUE
    }
    ActiveRecord::Base.connection.execute sql

    sql = %{
      DELETE FROM locations WHERE TRUE
    }
    ActiveRecord::Base.connection.execute sql
    
    redirect_to root_path
  end

  private
    def updateOutTimeParams
      params.permit(:item_id, :location_id, :timestamp)
    end
    
    def getOutTimeParams
      params.permit(:item_id)
    end
end
