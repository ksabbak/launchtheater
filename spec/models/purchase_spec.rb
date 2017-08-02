require 'rails_helper'

RSpec.describe Purchase, type: :model do
	let(:movie) { Movie.new(name: "Hackers") }
	let(:auditorium) { Auditorium.new(capacity: 50) }
	let(:showtime) { Showtime.new(start_time: DateTime.current, end_time: DateTime.current, movie: movie, auditorium: auditorium) }

	let (:purchase) { Purchase.new(purchaser_name: "Dade", purchaser_email: "crash_override@email.com", credit_card_number: 1234567890123456, credit_card_expiration_date: "11/2019", showtime: showtime) }
		
	describe "validations" do
		
		it "saves valid purchases" do
			expect(purchase.save).to be true
		end

		it "doesn't save a blank purchase" do
			new_purchase = Purchase.new
			expect(new_purchase.save).to be false
		end

		it "doesn't accept invalid emails" do
			purchase.purchaser_email = "0cool"
			expect(purchase.valid?).to be false
			expect(purchase.errors.full_messages).to include("Email is invalid")
		end

		describe "#credit_card_number_valid" do
			it "won't accept a card with the wrong number of digits" do
				purchase.credit_card_number = 1
				expect(purchase.valid?).to be false
				expect(purchase.errors.full_messages).to include("Credit card number is invalid length")
				purchase.credit_card_number = 1234567890123456789
				expect(purchase.valid?).to be false
				expect(purchase.errors.full_messages).to include("Credit card number is invalid length")
			end

			it "will not accept a credit card number with weird characters" do
				purchase.credit_card_number = "123456789ABCDEF0"
				expect(purchase.valid?).to be false
				expect(purchase.errors.full_messages).to include("Credit card number can only be numbers")
			end

			it "will not accept a blank credit card" do 
				purchase.credit_card_number = nil
				expect(purchase.valid?).to be false
				expect(purchase.errors.full_messages).to include("Credit card number must be entered")
			end
		end

		describe "#credit_card_expiration_date_valid" do
			it "won't accept a card with a weird month" do
				purchase.credit_card_expiration_date = "14/2019"
				expect(purchase.valid?).to be false
				expect(purchase.errors.full_messages).to include("Credit card expiration date has an invalid month")
				purchase.credit_card_expiration_date = "0/2019"
				expect(purchase.valid?).to be false
				expect(purchase.errors.full_messages).to include("Credit card expiration date has an invalid month")
			end

			it "will not accept a date of the wrong format" do
				purchase.credit_card_expiration_date = "123456789ABCDEF0"
				expect(purchase.valid?).to be false
				expect(purchase.errors.full_messages).to include("Credit card expiration date format is invalid")
			end

			it "will not accept a blank expiration date" do 
				purchase.credit_card_expiration_date = nil
				expect(purchase.valid?).to be false
				expect(purchase.errors.full_messages).to include("Credit card expiration date must be entered")
			end

			it "won't accept an expired card" do
				purchase.credit_card_expiration_date = "6/2017"
				expect(purchase.valid?).to be false
				expect(purchase.errors.full_messages).to include("Credit card expiration date has passed")
				purchase.credit_card_expiration_date = "11/2016"
				expect(purchase.valid?).to be false
				expect(purchase.errors.full_messages).to include("Credit card expiration date has passed")
			end
		end


	end
end
