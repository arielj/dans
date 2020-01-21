# This is an autogenerated file for dynamic methods in OldMovement
# Please rerun rake rails_rbi:models[OldMovement] to regenerate.

# typed: strong
module OldMovement::ActiveRelation_WhereNot
  sig { params(opts: T.untyped, rest: T.untyped).returns(T.self_type) }
  def not(opts, *rest); end
end

module OldMovement::GeneratedAttributeMethods
  extend T::Sig

  sig { returns(T.nilable(Integer)) }
  def amount; end

  sig { params(value: T.nilable(T.any(Integer, Float, ActiveSupport::Duration))).void }
  def amount=(value); end

  sig { returns(T::Boolean) }
  def amount?; end

  sig { returns(T.nilable(Integer)) }
  def daily_cash_closer; end

  sig { params(value: T.nilable(T.any(Integer, Float, ActiveSupport::Duration))).void }
  def daily_cash_closer=(value); end

  sig { returns(T::Boolean) }
  def daily_cash_closer?; end

  sig { returns(T.nilable(Date)) }
  def date; end

  sig { params(value: T.nilable(Date)).void }
  def date=(value); end

  sig { returns(T::Boolean) }
  def date?; end

  sig { returns(T.nilable(String)) }
  def description; end

  sig { params(value: T.nilable(String)).void }
  def description=(value); end

  sig { returns(T::Boolean) }
  def description?; end

  sig { returns(T.nilable(Integer)) }
  def done; end

  sig { params(value: T.nilable(T.any(Integer, Float, ActiveSupport::Duration))).void }
  def done=(value); end

  sig { returns(T::Boolean) }
  def done?; end

  sig { returns(T.nilable(Integer)) }
  def id; end

  sig { params(value: T.nilable(T.any(Integer, Float, ActiveSupport::Duration))).void }
  def id=(value); end

  sig { returns(T::Boolean) }
  def id?; end
end

module OldMovement::CustomFinderMethods
  sig { params(limit: Integer).returns(T::Array[OldMovement]) }
  def first_n(limit); end

  sig { params(limit: Integer).returns(T::Array[OldMovement]) }
  def last_n(limit); end

  sig { params(args: T::Array[T.any(Integer, String)]).returns(T::Array[OldMovement]) }
  def find_n(*args); end

  sig { params(id: Integer).returns(T.nilable(OldMovement)) }
  def find_by_id(id); end

  sig { params(id: Integer).returns(OldMovement) }
  def find_by_id!(id); end
end

class OldMovement < OldRecord
  include OldMovement::GeneratedAttributeMethods
  extend OldMovement::CustomFinderMethods
  extend T::Sig
  extend T::Generic

  sig { returns(OldMovement::ActiveRecord_Relation) }
  def self.all; end

  sig { params(block: T.nilable(T.proc.void)).returns(OldMovement::ActiveRecord_Relation) }
  def self.unscoped(&block); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def self.select(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def self.reselect(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def self.order(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def self.reorder(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def self.group(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def self.limit(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def self.offset(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def self.joins(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def self.left_joins(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def self.left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def self.where(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def self.rewhere(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def self.preload(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def self.extract_associated(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def self.eager_load(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def self.includes(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def self.from(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def self.lock(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def self.readonly(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def self.or(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def self.having(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def self.create_with(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def self.distinct(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def self.references(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def self.none(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def self.unscope(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def self.optimizer_hints(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def self.merge(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def self.except(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def self.only(*args); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(OldMovement::ActiveRecord_Relation) }
  def self.extending(*args, &block); end

  sig { params(args: T.untyped).returns(OldMovement) }
  def self.find(*args); end

  sig { params(args: T.untyped).returns(T.nilable(OldMovement)) }
  def self.find_by(*args); end

  sig { params(args: T.untyped).returns(OldMovement) }
  def self.find_by!(*args); end

  sig { returns(T.nilable(OldMovement)) }
  def self.first; end

  sig { returns(OldMovement) }
  def self.first!; end

  sig { returns(T.nilable(OldMovement)) }
  def self.second; end

  sig { returns(OldMovement) }
  def self.second!; end

  sig { returns(T.nilable(OldMovement)) }
  def self.third; end

  sig { returns(OldMovement) }
  def self.third!; end

  sig { returns(T.nilable(OldMovement)) }
  def self.third_to_last; end

  sig { returns(OldMovement) }
  def self.third_to_last!; end

  sig { returns(T.nilable(OldMovement)) }
  def self.second_to_last; end

  sig { returns(OldMovement) }
  def self.second_to_last!; end

  sig { returns(T.nilable(OldMovement)) }
  def self.last; end

  sig { returns(OldMovement) }
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

  sig { params(attributes: T.untyped, block: T.untyped).returns(OldMovement) }
  def self.create(attributes = nil, &block); end

  sig { params(attributes: T.untyped, block: T.untyped).returns(OldMovement) }
  def self.create!(attributes = nil, &block); end

  sig { params(attributes: T.untyped, block: T.untyped).returns(OldMovement) }
  def self.new(attributes = nil, &block); end
end

class OldMovement::ActiveRecord_Relation < ActiveRecord::Relation
  include OldMovement::ActiveRelation_WhereNot
  include OldMovement::CustomFinderMethods
  include Enumerable
  extend T::Sig
  extend T::Generic
  Elem = type_member(fixed: OldMovement)

  sig { returns(OldMovement::ActiveRecord_Relation) }
  def all; end

  sig { params(block: T.nilable(T.proc.void)).returns(OldMovement::ActiveRecord_Relation) }
  def unscoped(&block); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def select(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def reselect(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def order(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def reorder(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def group(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def limit(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def offset(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def joins(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def left_joins(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def where(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def rewhere(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def preload(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def extract_associated(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def eager_load(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def includes(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def from(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def lock(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def readonly(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def or(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def having(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def create_with(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def distinct(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def references(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def none(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def unscope(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def optimizer_hints(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def merge(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def except(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_Relation) }
  def only(*args); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(OldMovement::ActiveRecord_Relation) }
  def extending(*args, &block); end
end

class OldMovement::ActiveRecord_AssociationRelation < ActiveRecord::AssociationRelation
  include OldMovement::ActiveRelation_WhereNot
  include OldMovement::CustomFinderMethods
  include Enumerable
  extend T::Sig
  extend T::Generic
  Elem = type_member(fixed: OldMovement)

  sig { returns(OldMovement::ActiveRecord_AssociationRelation) }
  def all; end

  sig { params(block: T.nilable(T.proc.void)).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def unscoped(&block); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def select(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def reselect(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def order(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def reorder(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def group(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def limit(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def offset(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def joins(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def left_joins(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def where(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def rewhere(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def preload(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def extract_associated(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def eager_load(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def includes(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def from(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def lock(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def readonly(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def or(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def having(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def create_with(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def distinct(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def references(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def none(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def unscope(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def optimizer_hints(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def merge(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def except(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def only(*args); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def extending(*args, &block); end

  sig { params(args: T.untyped).returns(OldMovement) }
  def find(*args); end

  sig { params(args: T.untyped).returns(T.nilable(OldMovement)) }
  def find_by(*args); end

  sig { params(args: T.untyped).returns(OldMovement) }
  def find_by!(*args); end

  sig { returns(T.nilable(OldMovement)) }
  def first; end

  sig { returns(OldMovement) }
  def first!; end

  sig { returns(T.nilable(OldMovement)) }
  def second; end

  sig { returns(OldMovement) }
  def second!; end

  sig { returns(T.nilable(OldMovement)) }
  def third; end

  sig { returns(OldMovement) }
  def third!; end

  sig { returns(T.nilable(OldMovement)) }
  def third_to_last; end

  sig { returns(OldMovement) }
  def third_to_last!; end

  sig { returns(T.nilable(OldMovement)) }
  def second_to_last; end

  sig { returns(OldMovement) }
  def second_to_last!; end

  sig { returns(T.nilable(OldMovement)) }
  def last; end

  sig { returns(OldMovement) }
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

  sig { override.params(block: T.proc.params(e: OldMovement).void).returns(T::Array[OldMovement]) }
  def each(&block); end

  sig { params(level: T.nilable(Integer)).returns(T::Array[OldMovement]) }
  def flatten(level); end

  sig { returns(T::Array[OldMovement]) }
  def to_a; end

  sig do
    type_parameters(:U).params(
        blk: T.proc.params(arg0: Elem).returns(T.type_parameter(:U)),
    )
    .returns(T::Array[T.type_parameter(:U)])
  end
  def map(&blk); end
end

class OldMovement::ActiveRecord_Associations_CollectionProxy < ActiveRecord::Associations::CollectionProxy
  include OldMovement::CustomFinderMethods
  include Enumerable
  extend T::Sig
  extend T::Generic
  Elem = type_member(fixed: OldMovement)

  sig { returns(OldMovement::ActiveRecord_AssociationRelation) }
  def all; end

  sig { params(block: T.nilable(T.proc.void)).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def unscoped(&block); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def select(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def reselect(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def order(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def reorder(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def group(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def limit(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def offset(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def joins(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def left_joins(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def where(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def rewhere(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def preload(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def extract_associated(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def eager_load(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def includes(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def from(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def lock(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def readonly(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def or(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def having(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def create_with(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def distinct(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def references(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def none(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def unscope(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def optimizer_hints(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def merge(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def except(*args); end

  sig { params(args: T.untyped).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def only(*args); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(OldMovement::ActiveRecord_AssociationRelation) }
  def extending(*args, &block); end

  sig { params(args: T.untyped).returns(OldMovement) }
  def find(*args); end

  sig { params(args: T.untyped).returns(T.nilable(OldMovement)) }
  def find_by(*args); end

  sig { params(args: T.untyped).returns(OldMovement) }
  def find_by!(*args); end

  sig { returns(T.nilable(OldMovement)) }
  def first; end

  sig { returns(OldMovement) }
  def first!; end

  sig { returns(T.nilable(OldMovement)) }
  def second; end

  sig { returns(OldMovement) }
  def second!; end

  sig { returns(T.nilable(OldMovement)) }
  def third; end

  sig { returns(OldMovement) }
  def third!; end

  sig { returns(T.nilable(OldMovement)) }
  def third_to_last; end

  sig { returns(OldMovement) }
  def third_to_last!; end

  sig { returns(T.nilable(OldMovement)) }
  def second_to_last; end

  sig { returns(OldMovement) }
  def second_to_last!; end

  sig { returns(T.nilable(OldMovement)) }
  def last; end

  sig { returns(OldMovement) }
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

  sig { override.params(block: T.proc.params(e: OldMovement).void).returns(T::Array[OldMovement]) }
  def each(&block); end

  sig { params(level: T.nilable(Integer)).returns(T::Array[OldMovement]) }
  def flatten(level); end

  sig { returns(T::Array[OldMovement]) }
  def to_a; end

  sig do
    type_parameters(:U).params(
        blk: T.proc.params(arg0: Elem).returns(T.type_parameter(:U)),
    )
    .returns(T::Array[T.type_parameter(:U)])
  end
  def map(&blk); end

  sig { params(records: T.any(OldMovement, T::Array[OldMovement])).returns(T.self_type) }
  def <<(*records); end

  sig { params(records: T.any(OldMovement, T::Array[OldMovement])).returns(T.self_type) }
  def append(*records); end

  sig { params(records: T.any(OldMovement, T::Array[OldMovement])).returns(T.self_type) }
  def push(*records); end

  sig { params(records: T.any(OldMovement, T::Array[OldMovement])).returns(T.self_type) }
  def concat(*records); end
end
