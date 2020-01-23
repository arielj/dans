# This is an autogenerated file for dynamic methods in HABTM_Schedules
# Please rerun rake rails_rbi:models[HABTM_Schedules] to regenerate.

# typed: strong
module HABTM_Schedules::ActiveRelation_WhereNot
  sig { params(opts: T.untyped, rest: T.untyped).returns(T.self_type) }
  def not(opts, *rest); end
end

module HABTM_Schedules::GeneratedAttributeMethods
  extend T::Sig

  sig { returns(Integer) }
  def id; end

  sig { params(value: T.any(Integer, Float, ActiveSupport::Duration)).void }
  def id=(value); end

  sig { returns(T::Boolean) }
  def id?; end

  sig { returns(T.nilable(Integer)) }
  def package_id; end

  sig { params(value: T.nilable(T.any(Integer, Float, ActiveSupport::Duration))).void }
  def package_id=(value); end

  sig { returns(T::Boolean) }
  def package_id?; end

  sig { returns(T.nilable(Integer)) }
  def schedule_id; end

  sig { params(value: T.nilable(T.any(Integer, Float, ActiveSupport::Duration))).void }
  def schedule_id=(value); end

  sig { returns(T::Boolean) }
  def schedule_id?; end
end

module HABTM_Schedules::GeneratedAssociationMethods
  extend T::Sig

  sig { returns(T.nilable(::Package)) }
  def left_side; end

  sig { params(value: T.nilable(::Package)).void }
  def left_side=(value); end

  sig { returns(T.nilable(::Schedule)) }
  def schedule; end

  sig { params(value: T.nilable(::Schedule)).void }
  def schedule=(value); end
end

module HABTM_Schedules::CustomFinderMethods
  sig { params(limit: Integer).returns(T::Array[HABTM_Schedules]) }
  def first_n(limit); end

  sig { params(limit: Integer).returns(T::Array[HABTM_Schedules]) }
  def last_n(limit); end

  sig { params(args: T::Array[T.any(Integer, String)]).returns(T::Array[HABTM_Schedules]) }
  def find_n(*args); end

  sig { params(id: Integer).returns(T.nilable(HABTM_Schedules)) }
  def find_by_id(id); end

  sig { params(id: Integer).returns(HABTM_Schedules) }
  def find_by_id!(id); end
end

class HABTM_Schedules < ActiveRecord::Base
  include HABTM_Schedules::GeneratedAttributeMethods
  include HABTM_Schedules::GeneratedAssociationMethods
  extend HABTM_Schedules::CustomFinderMethods
  extend T::Sig
  extend T::Generic

  sig { returns(HABTM_Schedules::ActiveRecord_Relation) }
  def self.all; end

  sig { params(block: T.nilable(T.proc.void)).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def self.unscoped(&block); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def self.select(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def self.reselect(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def self.order(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def self.reorder(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def self.group(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def self.limit(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def self.offset(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def self.joins(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def self.left_joins(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def self.left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def self.where(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def self.rewhere(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def self.preload(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def self.extract_associated(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def self.eager_load(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def self.includes(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def self.from(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def self.lock(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def self.readonly(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def self.or(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def self.having(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def self.create_with(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def self.distinct(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def self.references(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def self.none(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def self.unscope(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def self.optimizer_hints(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def self.merge(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def self.except(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def self.only(*args); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def self.extending(*args, &block); end

  sig { params(args: T.untyped).returns(HABTM_Schedules) }
  def self.find(*args); end

  sig { params(args: T.untyped).returns(T.nilable(HABTM_Schedules)) }
  def self.find_by(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules) }
  def self.find_by!(*args); end

  sig { returns(T.nilable(HABTM_Schedules)) }
  def self.first; end

  sig { returns(HABTM_Schedules) }
  def self.first!; end

  sig { returns(T.nilable(HABTM_Schedules)) }
  def self.second; end

  sig { returns(HABTM_Schedules) }
  def self.second!; end

  sig { returns(T.nilable(HABTM_Schedules)) }
  def self.third; end

  sig { returns(HABTM_Schedules) }
  def self.third!; end

  sig { returns(T.nilable(HABTM_Schedules)) }
  def self.third_to_last; end

  sig { returns(HABTM_Schedules) }
  def self.third_to_last!; end

  sig { returns(T.nilable(HABTM_Schedules)) }
  def self.second_to_last; end

  sig { returns(HABTM_Schedules) }
  def self.second_to_last!; end

  sig { returns(T.nilable(HABTM_Schedules)) }
  def self.last; end

  sig { returns(HABTM_Schedules) }
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

  sig { params(attributes: T.untyped, block: T.untyped).returns(HABTM_Schedules) }
  def self.create(attributes = nil, &block); end

  sig { params(attributes: T.untyped, block: T.untyped).returns(HABTM_Schedules) }
  def self.create!(attributes = nil, &block); end

  sig { params(attributes: T.untyped, block: T.untyped).returns(HABTM_Schedules) }
  def self.new(attributes = nil, &block); end
end

class HABTM_Schedules::ActiveRecord_Relation < ActiveRecord::Relation
  include HABTM_Schedules::ActiveRelation_WhereNot
  include HABTM_Schedules::CustomFinderMethods
  include Enumerable
  extend T::Sig
  extend T::Generic
  Elem = type_member(fixed: HABTM_Schedules)

  sig { returns(HABTM_Schedules::ActiveRecord_Relation) }
  def all; end

  sig { params(block: T.nilable(T.proc.void)).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def unscoped(&block); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def select(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def reselect(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def order(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def reorder(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def group(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def limit(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def offset(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def joins(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def left_joins(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def where(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def rewhere(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def preload(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def extract_associated(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def eager_load(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def includes(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def from(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def lock(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def readonly(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def or(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def having(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def create_with(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def distinct(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def references(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def none(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def unscope(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def optimizer_hints(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def merge(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def except(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def only(*args); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(HABTM_Schedules::ActiveRecord_Relation) }
  def extending(*args, &block); end
end

class HABTM_Schedules::ActiveRecord_AssociationRelation < ActiveRecord::AssociationRelation
  include HABTM_Schedules::ActiveRelation_WhereNot
  include HABTM_Schedules::CustomFinderMethods
  include Enumerable
  extend T::Sig
  extend T::Generic
  Elem = type_member(fixed: HABTM_Schedules)

  sig { returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def all; end

  sig { params(block: T.nilable(T.proc.void)).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def unscoped(&block); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def select(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def reselect(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def order(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def reorder(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def group(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def limit(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def offset(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def joins(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def left_joins(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def where(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def rewhere(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def preload(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def extract_associated(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def eager_load(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def includes(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def from(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def lock(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def readonly(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def or(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def having(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def create_with(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def distinct(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def references(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def none(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def unscope(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def optimizer_hints(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def merge(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def except(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def only(*args); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def extending(*args, &block); end

  sig { params(args: T.untyped).returns(HABTM_Schedules) }
  def find(*args); end

  sig { params(args: T.untyped).returns(T.nilable(HABTM_Schedules)) }
  def find_by(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules) }
  def find_by!(*args); end

  sig { returns(T.nilable(HABTM_Schedules)) }
  def first; end

  sig { returns(HABTM_Schedules) }
  def first!; end

  sig { returns(T.nilable(HABTM_Schedules)) }
  def second; end

  sig { returns(HABTM_Schedules) }
  def second!; end

  sig { returns(T.nilable(HABTM_Schedules)) }
  def third; end

  sig { returns(HABTM_Schedules) }
  def third!; end

  sig { returns(T.nilable(HABTM_Schedules)) }
  def third_to_last; end

  sig { returns(HABTM_Schedules) }
  def third_to_last!; end

  sig { returns(T.nilable(HABTM_Schedules)) }
  def second_to_last; end

  sig { returns(HABTM_Schedules) }
  def second_to_last!; end

  sig { returns(T.nilable(HABTM_Schedules)) }
  def last; end

  sig { returns(HABTM_Schedules) }
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

  sig { override.params(block: T.proc.params(e: HABTM_Schedules).void).returns(T::Array[HABTM_Schedules]) }
  def each(&block); end

  sig { params(level: T.nilable(Integer)).returns(T::Array[HABTM_Schedules]) }
  def flatten(level); end

  sig { returns(T::Array[HABTM_Schedules]) }
  def to_a; end

  sig do
    type_parameters(:U).params(
        blk: T.proc.params(arg0: Elem).returns(T.type_parameter(:U)),
    )
    .returns(T::Array[T.type_parameter(:U)])
  end
  def map(&blk); end
end

class HABTM_Schedules::ActiveRecord_Associations_CollectionProxy < ActiveRecord::Associations::CollectionProxy
  include HABTM_Schedules::CustomFinderMethods
  include Enumerable
  extend T::Sig
  extend T::Generic
  Elem = type_member(fixed: HABTM_Schedules)

  sig { returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def all; end

  sig { params(block: T.nilable(T.proc.void)).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def unscoped(&block); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def select(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def reselect(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def order(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def reorder(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def group(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def limit(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def offset(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def joins(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def left_joins(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def where(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def rewhere(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def preload(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def extract_associated(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def eager_load(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def includes(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def from(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def lock(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def readonly(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def or(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def having(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def create_with(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def distinct(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def references(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def none(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def unscope(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def optimizer_hints(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def merge(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def except(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def only(*args); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(HABTM_Schedules::ActiveRecord_AssociationRelation) }
  def extending(*args, &block); end

  sig { params(args: T.untyped).returns(HABTM_Schedules) }
  def find(*args); end

  sig { params(args: T.untyped).returns(T.nilable(HABTM_Schedules)) }
  def find_by(*args); end

  sig { params(args: T.untyped).returns(HABTM_Schedules) }
  def find_by!(*args); end

  sig { returns(T.nilable(HABTM_Schedules)) }
  def first; end

  sig { returns(HABTM_Schedules) }
  def first!; end

  sig { returns(T.nilable(HABTM_Schedules)) }
  def second; end

  sig { returns(HABTM_Schedules) }
  def second!; end

  sig { returns(T.nilable(HABTM_Schedules)) }
  def third; end

  sig { returns(HABTM_Schedules) }
  def third!; end

  sig { returns(T.nilable(HABTM_Schedules)) }
  def third_to_last; end

  sig { returns(HABTM_Schedules) }
  def third_to_last!; end

  sig { returns(T.nilable(HABTM_Schedules)) }
  def second_to_last; end

  sig { returns(HABTM_Schedules) }
  def second_to_last!; end

  sig { returns(T.nilable(HABTM_Schedules)) }
  def last; end

  sig { returns(HABTM_Schedules) }
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

  sig { override.params(block: T.proc.params(e: HABTM_Schedules).void).returns(T::Array[HABTM_Schedules]) }
  def each(&block); end

  sig { params(level: T.nilable(Integer)).returns(T::Array[HABTM_Schedules]) }
  def flatten(level); end

  sig { returns(T::Array[HABTM_Schedules]) }
  def to_a; end

  sig do
    type_parameters(:U).params(
        blk: T.proc.params(arg0: Elem).returns(T.type_parameter(:U)),
    )
    .returns(T::Array[T.type_parameter(:U)])
  end
  def map(&blk); end

  sig { params(records: T.any(HABTM_Schedules, T::Array[HABTM_Schedules])).returns(T.self_type) }
  def <<(*records); end

  sig { params(records: T.any(HABTM_Schedules, T::Array[HABTM_Schedules])).returns(T.self_type) }
  def append(*records); end

  sig { params(records: T.any(HABTM_Schedules, T::Array[HABTM_Schedules])).returns(T.self_type) }
  def push(*records); end

  sig { params(records: T.any(HABTM_Schedules, T::Array[HABTM_Schedules])).returns(T.self_type) }
  def concat(*records); end
end