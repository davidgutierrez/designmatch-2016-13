desc 'update In Process'
    task updateInProcess: :environment do 
        while true
            DesignsHelper.convert_pending_designs()
        end
    end
