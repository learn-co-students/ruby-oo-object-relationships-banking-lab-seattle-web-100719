class Transfer

    attr_accessor :sender, :receiver, :amount, :status
    
    def initialize(sender, receiver, amount)
        @sender = sender
        @receiver = receiver
        @amount = amount
        @status = "pending"
    end

    def valid?
        if self.sender.valid? && self.receiver.valid?
            true
        else
            false
        end
    end

    def execute_transaction
        if self.status == "pending" && self.valid? && self.sender.balance > self.amount
            self.sender.balance -= self.amount
            self.receiver.deposit(self.amount)
            self.status = "complete"
        else
            self.status = "rejected"
            "Transaction rejected. Please check your account balance."
        end
    end

    def reverse_transfer
        if self.status == "complete" #&& self.valid? && self.sender.balance > self.amount
            self.receiver.balance -= self.amount
            self.sender.deposit(self.amount)
            self.status = "reversed"
        else
            self.status = "rejected"
            "Transaction rejected. Please check your account balance."
        end
    end

end
