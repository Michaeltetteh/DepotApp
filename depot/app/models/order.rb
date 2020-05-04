class Order < ApplicationRecord
    enum pay_type: {
        "check" => 0,
        "Credit card" => 1,
        "Purchase order" => 2  
    }
end
