class Vote<ActiveRecord::Base

  validates :value, :votable_id, :votable_type, presence: true

  belongs_to :votable, polymorphic: true

  validates_uniqueness_of :voter_id, scope: [:votable_id, :votable_type]
end
