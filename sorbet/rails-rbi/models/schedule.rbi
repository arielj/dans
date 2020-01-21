# This is an autogenerated file for dynamic methods in Schedule
# Please rerun rake rails_rbi:models[Schedule] to regenerate.

# typed: strong
module Schedule::EnumInstanceMethods
  extend T::Sig

  sig { returns(T::Boolean) }
  def sunday?; end

  sig { void }
  def sunday!; end

  sig { returns(T::Boolean) }
  def monday?; end

  sig { void }
  def monday!; end

  sig { returns(T::Boolean) }
  def tuesday?; end

  sig { void }
  def tuesday!; end

  sig { returns(T::Boolean) }
  def wednesday?; end

  sig { void }
  def wednesday!; end

  sig { returns(T::Boolean) }
  def thursday?; end

  sig { void }
  def thursday!; end

  sig { returns(T::Boolean) }
  def friday?; end

  sig { void }
  def friday!; end

  sig { returns(T::Boolean) }
  def saturday?; end

  sig { void }
  def saturday!; end
end

module Schedule::ActiveRelation_WhereNot
  sig { params(opts: T.untyped, rest: T.untyped).returns(T.self_type) }
  def not(opts, *rest); end
end

module Schedule::GeneratedAttributeMethods
  extend T::Sig

  sig { returns(ActiveSupport::TimeWithZone) }
  def created_at; end

  sig { params(value: T.any(DateTime, Date, Time, ActiveSupport::TimeWithZone)).void }
  def created_at=(value); end

  sig { returns(T::Boolean) }
  def created_at?; end

  sig { returns(T.nilable(String)) }
  def day; end

  sig { params(value: T.nilable(T.any(Integer, String, Symbol))).void }
  def day=(value); end

  sig { returns(T::Boolean) }
  def day?; end

  sig { returns(T.nilable(Integer)) }
  def from_time; end

  sig { params(value: T.nilable(T.any(Integer, Float, ActiveSupport::Duration))).void }
  def from_time=(value); end

  sig { returns(T::Boolean) }
  def from_time?; end

  sig { returns(Integer) }
  def id; end

  sig { params(value: T.any(Integer, Float, ActiveSupport::Duration)).void }
  def id=(value); end

  sig { returns(T::Boolean) }
  def id?; end

  sig { returns(T.nilable(Integer)) }
  def klass_id; end

  sig { params(value: T.nilable(T.any(Integer, Float, ActiveSupport::Duration))).void }
  def klass_id=(value); end

  sig { returns(T::Boolean) }
  def klass_id?; end

  sig { returns(T.nilable(Integer)) }
  def room_id; end

  sig { params(value: T.nilable(T.any(Integer, Float, ActiveSupport::Duration))).void }
  def room_id=(value); end

  sig { returns(T::Boolean) }
  def room_id?; end

  sig { returns(T.nilable(Integer)) }
  def to_time; end

  sig { params(value: T.nilable(T.any(Integer, Float, ActiveSupport::Duration))).void }
  def to_time=(value); end

  sig { returns(T::Boolean) }
  def to_time?; end

  sig { returns(ActiveSupport::TimeWithZone) }
  def updated_at; end

  sig { params(value: T.any(DateTime, Date, Time, ActiveSupport::TimeWithZone)).void }
  def updated_at=(value); end

  sig { returns(T::Boolean) }
  def updated_at?; end
end

module Schedule::GeneratedAssociationMethods
  extend T::Sig

  sig { returns(::Klass) }
  def klass; end

  sig { params(value: ::Klass).void }
  def klass=(value); end

  sig { returns(::Membership::ActiveRecord_Associations_CollectionProxy) }
  def memberships; end

  sig { params(value: T::Enumerable[::Membership]).void }
  def memberships=(value); end

  sig { returns(::Room) }
  def room; end

  sig { params(value: ::Room).void }
  def room=(value); end
end

module Schedule::CustomFinderMethods
  sig { params(limit: Integer).returns(T::Array[Schedule]) }
  def first_n(limit); end

  sig { params(limit: Integer).returns(T::Array[Schedule]) }
  def last_n(limit); end

  sig { params(args: T::Array[T.any(Integer, String)]).returns(T::Array[Schedule]) }
  def find_n(*args); end

  sig { params(id: Integer).returns(T.nilable(Schedule)) }
  def find_by_id(id); end

  sig { params(id: Integer).returns(Schedule) }
  def find_by_id!(id); end
end

class Schedule < ApplicationRecord
  include Schedule::EnumInstanceMethods
  include Schedule::GeneratedAttributeMethods
  include Schedule::GeneratedAssociationMethods
  extend Schedule::CustomFinderMethods
  extend T::Sig
  extend T::Generic

  sig { returns(T::Hash[T.any(String, Symbol), Integer]) }
  def self.days; end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def self.friday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def self.monday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def self.not_friday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def self.not_monday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def self.not_saturday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def self.not_sunday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def self.not_thursday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def self.not_tuesday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def self.not_wednesday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def self.saturday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def self.sunday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def self.thursday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def self.tuesday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def self.wednesday(*args); end

  sig { returns(Schedule::ActiveRecord_Relation) }
  def self.all; end

  sig { params(block: T.nilable(T.proc.void)).returns(Schedule::ActiveRecord_Relation) }
  def self.unscoped(&block); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def self.select(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def self.reselect(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def self.order(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def self.reorder(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def self.group(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def self.limit(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def self.offset(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def self.joins(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def self.left_joins(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def self.left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def self.where(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def self.rewhere(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def self.preload(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def self.extract_associated(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def self.eager_load(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def self.includes(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def self.from(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def self.lock(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def self.readonly(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def self.or(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def self.having(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def self.create_with(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def self.distinct(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def self.references(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def self.none(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def self.unscope(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def self.optimizer_hints(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def self.merge(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def self.except(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def self.only(*args); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(Schedule::ActiveRecord_Relation) }
  def self.extending(*args, &block); end

  sig { params(args: T.untyped).returns(Schedule) }
  def self.find(*args); end

  sig { params(args: T.untyped).returns(T.nilable(Schedule)) }
  def self.find_by(*args); end

  sig { params(args: T.untyped).returns(Schedule) }
  def self.find_by!(*args); end

  sig { returns(T.nilable(Schedule)) }
  def self.first; end

  sig { returns(Schedule) }
  def self.first!; end

  sig { returns(T.nilable(Schedule)) }
  def self.second; end

  sig { returns(Schedule) }
  def self.second!; end

  sig { returns(T.nilable(Schedule)) }
  def self.third; end

  sig { returns(Schedule) }
  def self.third!; end

  sig { returns(T.nilable(Schedule)) }
  def self.third_to_last; end

  sig { returns(Schedule) }
  def self.third_to_last!; end

  sig { returns(T.nilable(Schedule)) }
  def self.second_to_last; end

  sig { returns(Schedule) }
  def self.second_to_last!; end

  sig { returns(T.nilable(Schedule)) }
  def self.last; end

  sig { returns(Schedule) }
  def self.last!; end

  sig { params(conditions: T.untyped).returns(T::Boolean) }
  def self.exists?(conditions = nil); end

  sig { params(args: T.untyped).returns(T::Boolean) }
  def self.any?(*args); end

  sig { params(args: T.untyped).returns(T::Boolean) }
  def self.many?(*args); end

  sig { params(args: T.untyped).returns(T::Boolean) }
  def self.none?(*args); end

  sig { params(args: T.untyped).returns(T::Boolean) }
  def self.one?(*args); end

  sig { params(attributes: T.untyped, block: T.untyped).returns(Schedule) }
  def self.create(attributes = nil, &block); end

  sig { params(attributes: T.untyped, block: T.untyped).returns(Schedule) }
  def self.create!(attributes = nil, &block); end

  sig { params(attributes: T.untyped, block: T.untyped).returns(Schedule) }
  def self.new(attributes = nil, &block); end
end

class Schedule::ActiveRecord_Relation < ActiveRecord::Relation
  include Schedule::ActiveRelation_WhereNot
  include Schedule::CustomFinderMethods
  include Enumerable
  extend T::Sig
  extend T::Generic
  Elem = type_member(fixed: Schedule)

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def friday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def monday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def not_friday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def not_monday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def not_saturday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def not_sunday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def not_thursday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def not_tuesday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def not_wednesday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def saturday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def sunday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def thursday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def tuesday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def wednesday(*args); end

  sig { returns(Schedule::ActiveRecord_Relation) }
  def all; end

  sig { params(block: T.nilable(T.proc.void)).returns(Schedule::ActiveRecord_Relation) }
  def unscoped(&block); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def select(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def reselect(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def order(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def reorder(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def group(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def limit(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def offset(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def joins(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def left_joins(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def where(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def rewhere(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def preload(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def extract_associated(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def eager_load(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def includes(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def from(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def lock(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def readonly(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def or(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def having(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def create_with(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def distinct(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def references(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def none(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def unscope(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def optimizer_hints(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def merge(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def except(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_Relation) }
  def only(*args); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(Schedule::ActiveRecord_Relation) }
  def extending(*args, &block); end
end

class Schedule::ActiveRecord_AssociationRelation < ActiveRecord::AssociationRelation
  include Schedule::ActiveRelation_WhereNot
  include Schedule::CustomFinderMethods
  include Enumerable
  extend T::Sig
  extend T::Generic
  Elem = type_member(fixed: Schedule)

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def friday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def monday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def not_friday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def not_monday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def not_saturday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def not_sunday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def not_thursday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def not_tuesday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def not_wednesday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def saturday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def sunday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def thursday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def tuesday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def wednesday(*args); end

  sig { returns(Schedule::ActiveRecord_AssociationRelation) }
  def all; end

  sig { params(block: T.nilable(T.proc.void)).returns(Schedule::ActiveRecord_AssociationRelation) }
  def unscoped(&block); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def select(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def reselect(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def order(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def reorder(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def group(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def limit(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def offset(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def joins(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def left_joins(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def where(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def rewhere(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def preload(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def extract_associated(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def eager_load(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def includes(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def from(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def lock(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def readonly(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def or(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def having(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def create_with(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def distinct(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def references(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def none(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def unscope(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def optimizer_hints(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def merge(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def except(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def only(*args); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(Schedule::ActiveRecord_AssociationRelation) }
  def extending(*args, &block); end

  sig { params(args: T.untyped).returns(Schedule) }
  def find(*args); end

  sig { params(args: T.untyped).returns(T.nilable(Schedule)) }
  def find_by(*args); end

  sig { params(args: T.untyped).returns(Schedule) }
  def find_by!(*args); end

  sig { returns(T.nilable(Schedule)) }
  def first; end

  sig { returns(Schedule) }
  def first!; end

  sig { returns(T.nilable(Schedule)) }
  def second; end

  sig { returns(Schedule) }
  def second!; end

  sig { returns(T.nilable(Schedule)) }
  def third; end

  sig { returns(Schedule) }
  def third!; end

  sig { returns(T.nilable(Schedule)) }
  def third_to_last; end

  sig { returns(Schedule) }
  def third_to_last!; end

  sig { returns(T.nilable(Schedule)) }
  def second_to_last; end

  sig { returns(Schedule) }
  def second_to_last!; end

  sig { returns(T.nilable(Schedule)) }
  def last; end

  sig { returns(Schedule) }
  def last!; end

  sig { params(conditions: T.untyped).returns(T::Boolean) }
  def exists?(conditions = nil); end

  sig { params(args: T.untyped).returns(T::Boolean) }
  def any?(*args); end

  sig { params(args: T.untyped).returns(T::Boolean) }
  def many?(*args); end

  sig { params(args: T.untyped).returns(T::Boolean) }
  def none?(*args); end

  sig { params(args: T.untyped).returns(T::Boolean) }
  def one?(*args); end

  sig { override.params(block: T.proc.params(e: Schedule).void).returns(T::Array[Schedule]) }
  def each(&block); end

  sig { params(level: T.nilable(Integer)).returns(T::Array[Schedule]) }
  def flatten(level); end

  sig { returns(T::Array[Schedule]) }
  def to_a; end

  sig do
    type_parameters(:U).params(
        blk: T.proc.params(arg0: Elem).returns(T.type_parameter(:U)),
    )
    .returns(T::Array[T.type_parameter(:U)])
  end
  def map(&blk); end
end

class Schedule::ActiveRecord_Associations_CollectionProxy < ActiveRecord::Associations::CollectionProxy
  include Schedule::CustomFinderMethods
  include Enumerable
  extend T::Sig
  extend T::Generic
  Elem = type_member(fixed: Schedule)

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def friday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def monday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def not_friday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def not_monday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def not_saturday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def not_sunday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def not_thursday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def not_tuesday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def not_wednesday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def saturday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def sunday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def thursday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def tuesday(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def wednesday(*args); end

  sig { returns(Schedule::ActiveRecord_AssociationRelation) }
  def all; end

  sig { params(block: T.nilable(T.proc.void)).returns(Schedule::ActiveRecord_AssociationRelation) }
  def unscoped(&block); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def select(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def reselect(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def order(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def reorder(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def group(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def limit(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def offset(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def joins(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def left_joins(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def where(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def rewhere(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def preload(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def extract_associated(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def eager_load(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def includes(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def from(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def lock(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def readonly(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def or(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def having(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def create_with(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def distinct(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def references(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def none(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def unscope(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def optimizer_hints(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def merge(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def except(*args); end

  sig { params(args: T.untyped).returns(Schedule::ActiveRecord_AssociationRelation) }
  def only(*args); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(Schedule::ActiveRecord_AssociationRelation) }
  def extending(*args, &block); end

  sig { params(args: T.untyped).returns(Schedule) }
  def find(*args); end

  sig { params(args: T.untyped).returns(T.nilable(Schedule)) }
  def find_by(*args); end

  sig { params(args: T.untyped).returns(Schedule) }
  def find_by!(*args); end

  sig { returns(T.nilable(Schedule)) }
  def first; end

  sig { returns(Schedule) }
  def first!; end

  sig { returns(T.nilable(Schedule)) }
  def second; end

  sig { returns(Schedule) }
  def second!; end

  sig { returns(T.nilable(Schedule)) }
  def third; end

  sig { returns(Schedule) }
  def third!; end

  sig { returns(T.nilable(Schedule)) }
  def third_to_last; end

  sig { returns(Schedule) }
  def third_to_last!; end

  sig { returns(T.nilable(Schedule)) }
  def second_to_last; end

  sig { returns(Schedule) }
  def second_to_last!; end

  sig { returns(T.nilable(Schedule)) }
  def last; end

  sig { returns(Schedule) }
  def last!; end

  sig { params(conditions: T.untyped).returns(T::Boolean) }
  def exists?(conditions = nil); end

  sig { params(args: T.untyped).returns(T::Boolean) }
  def any?(*args); end

  sig { params(args: T.untyped).returns(T::Boolean) }
  def many?(*args); end

  sig { params(args: T.untyped).returns(T::Boolean) }
  def none?(*args); end

  sig { params(args: T.untyped).returns(T::Boolean) }
  def one?(*args); end

  sig { override.params(block: T.proc.params(e: Schedule).void).returns(T::Array[Schedule]) }
  def each(&block); end

  sig { params(level: T.nilable(Integer)).returns(T::Array[Schedule]) }
  def flatten(level); end

  sig { returns(T::Array[Schedule]) }
  def to_a; end

  sig do
    type_parameters(:U).params(
        blk: T.proc.params(arg0: Elem).returns(T.type_parameter(:U)),
    )
    .returns(T::Array[T.type_parameter(:U)])
  end
  def map(&blk); end

  sig { params(records: T.any(Schedule, T::Array[Schedule])).returns(T.self_type) }
  def <<(*records); end

  sig { params(records: T.any(Schedule, T::Array[Schedule])).returns(T.self_type) }
  def append(*records); end

  sig { params(records: T.any(Schedule, T::Array[Schedule])).returns(T.self_type) }
  def push(*records); end

  sig { params(records: T.any(Schedule, T::Array[Schedule])).returns(T.self_type) }
  def concat(*records); end
end
