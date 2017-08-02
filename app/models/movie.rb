class Movie < ApplicationRecord
	has_many :showtimes
	has_many :viewers, through: :showtimes, source: :purchases
	has_many :auditoria, through: :showtimes



end
