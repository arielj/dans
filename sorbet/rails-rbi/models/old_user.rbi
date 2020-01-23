# This is an autogenerated file for dynamic methods in OldUser
# Please rerun rake rails_rbi:models[OldUser] to regenerate.

# typed: strong
module OldUser::ActiveRelation_WhereNot
  sig { params(opts: T.untyped, rest: T.untyped).returns(T.self_type) }
  def not(opts, *rest); end
end

module OldUser::GeneratedAttributeMethods
  extend T::Sig

  sig { returns(T.nilable(String)) }
  def address; end

  sig { params(value: T.nilable(String)).void }
  def address=(value); end

  sig { returns(T::Boolean) }
  def address?; end

  sig { returns(T.nilable(Integer)) }
  def age; end

  sig { params(value: T.nilable(T.any(Integer, Float, ActiveSupport::Duration))).void }
  def age=(value); end

  sig { returns(T::Boolean) }
  def age?; end

  sig { returns(T.nilable(String)) }
  def alt_phone; end

  sig { params(value: T.nilable(String)).void }
  def alt_phone=(value); end

  sig { returns(T::Boolean) }
  def alt_phone?; end

  sig { returns(T.nilable(Date)) }
  def birthday; end

  sig { params(value: T.nilable(Date)).void }
  def birthday=(value); end

  sig { returns(T::Boolean) }
  def birthday?; end

  sig { returns(T.nilable(String)) }
  def cellphone; end

  sig { params(value: T.nilable(String)).void }
  def cellphone=(value); end

  sig { returns(T::Boolean) }
  def cellphone?; end

  sig { returns(T.nilable(String)) }
  def comments; end

  sig { params(value: T.nilable(String)).void }
  def comments=(value); end

  sig { returns(T::Boolean) }
  def comments?; end

  sig { returns(T.nilable(T.untyped)) }
  def dni; end

  sig { params(value: T.nilable(T.untyped)).void }
  def dni=(value); end

  sig { returns(T::Boolean) }
  def dni?; end

  sig { returns(T.nilable(String)) }
  def email; end

  sig { params(value: T.nilable(String)).void }
  def email=(value); end

  sig { returns(T::Boolean) }
  def email?; end

  sig { returns(T.nilable(String)) }
  def facebook_uid; end

  sig { params(value: T.nilable(String)).void }
  def facebook_uid=(value); end

  sig { returns(T::Boolean) }
  def facebook_uid?; end

  sig { returns(T.nilable(Integer)) }
  def family; end

  sig { params(value: T.nilable(T.any(Integer, Float, ActiveSupport::Duration))).void }
  def family=(value); end

  sig { returns(T::Boolean) }
  def family?; end

  sig { returns(T.nilable(String)) }
  def group; end

  sig { params(value: T.nilable(String)).void }
  def group=(value); end

  sig { returns(T::Boolean) }
  def group?; end

  sig { returns(T.nilable(Integer)) }
  def id; end

  sig { params(value: T.nilable(T.any(Integer, Float, ActiveSupport::Duration))).void }
  def id=(value); end

  sig { returns(T::Boolean) }
  def id?; end

  sig { returns(T.nilable(Integer)) }
  def inactive; end

  sig { params(value: T.nilable(T.any(Integer, Float, ActiveSupport::Duration))).void }
  def inactive=(value); end

  sig { returns(T::Boolean) }
  def inactive?; end

  sig { returns(T.nilable(Integer)) }
  def is_teacher; end

  sig { params(value: T.nilable(T.any(Integer, Float, ActiveSupport::Duration))).void }
  def is_teacher=(value); end

  sig { returns(T::Boolean) }
  def is_teacher?; end

  sig { returns(T.nilable(String)) }
  def lastname; end

  sig { params(value: T.nilable(String)).void }
  def lastname=(value); end

  sig { returns(T::Boolean) }
  def lastname?; end

  sig { returns(T.nilable(Integer)) }
  def male; end

  sig { params(value: T.nilable(T.any(Integer, Float, ActiveSupport::Duration))).void }
  def male=(value); end

  sig { returns(T::Boolean) }
  def male?; end

  sig { returns(T.nilable(String)) }
  def name; end

  sig { params(value: T.nilable(String)).void }
  def name=(value); end

  sig { returns(T::Boolean) }
  def name?; end
end

module OldUser::GeneratedAssociationMethods
  extend T::Sig

  sig { returns(::OldMembership::ActiveRecord_Associations_CollectionProxy) }
  def memberships; end

  sig { params(value: T::Enumerable[::OldMembership]).void }
  def memberships=(value); end
end

module OldUser::CustomFinderMethods
  sig { params(limit: Integer).returns(T::Array[OldUser]) }
  def first_n(limit); end

  sig { params(limit: Integer).returns(T::Array[OldUser]) }
  def last_n(limit); end

  sig { params(args: T::Array[T.any(Integer, String)]).returns(T::Array[OldUser]) }
  def find_n(*args); end

  sig { params(id: Integer).returns(T.nilable(OldUser)) }
  def find_by_id(id); end

  sig { params(id: Integer).returns(OldUser) }
  def find_by_id!(id); end
end

class OldUser < OldRecord
  include OldUser::GeneratedAttributeMethods
  include OldUser::GeneratedAssociationMethods
  extend OldUser::CustomFinderMethods
  extend T::Sig
  extend T::Generic

  sig { returns(OldUser::ActiveRecord_Relation) }
  def self.all; end

  sig { params(block: T.nilable(T.proc.void)).returns(OldUser::ActiveRecord_Relation) }
  def self.unscoped(&block); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def self.select(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def self.reselect(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def self.order(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def self.reorder(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def self.group(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def self.limit(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def self.offset(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def self.joins(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def self.left_joins(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def self.left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def self.where(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def self.rewhere(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def self.preload(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def self.extract_associated(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def self.eager_load(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def self.includes(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def self.from(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def self.lock(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def self.readonly(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def self.or(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def self.having(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def self.create_with(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def self.distinct(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def self.references(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def self.none(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def self.unscope(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def self.optimizer_hints(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def self.merge(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def self.except(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def self.only(*args); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(OldUser::ActiveRecord_Relation) }
  def self.extending(*args, &block); end

  sig { params(args: T.untyped).returns(OldUser) }
  def self.find(*args); end

  sig { params(args: T.untyped).returns(T.nilable(OldUser)) }
  def self.find_by(*args); end

  sig { params(args: T.untyped).returns(OldUser) }
  def self.find_by!(*args); end

  sig { returns(T.nilable(OldUser)) }
  def self.first; end

  sig { returns(OldUser) }
  def self.first!; end

  sig { returns(T.nilable(OldUser)) }
  def self.second; end

  sig { returns(OldUser) }
  def self.second!; end

  sig { returns(T.nilable(OldUser)) }
  def self.third; end

  sig { returns(OldUser) }
  def self.third!; end

  sig { returns(T.nilable(OldUser)) }
  def self.third_to_last; end

  sig { returns(OldUser) }
  def self.third_to_last!; end

  sig { returns(T.nilable(OldUser)) }
  def self.second_to_last; end

  sig { returns(OldUser) }
  def self.second_to_last!; end

  sig { returns(T.nilable(OldUser)) }
  def self.last; end

  sig { returns(OldUser) }
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

  sig { params(attributes: T.untyped, block: T.untyped).returns(OldUser) }
  def self.create(attributes = nil, &block); end

  sig { params(attributes: T.untyped, block: T.untyped).returns(OldUser) }
  def self.create!(attributes = nil, &block); end

  sig { params(attributes: T.untyped, block: T.untyped).returns(OldUser) }
  def self.new(attributes = nil, &block); end
end

class OldUser::ActiveRecord_Relation < ActiveRecord::Relation
  include OldUser::ActiveRelation_WhereNot
  include OldUser::CustomFinderMethods
  include Enumerable
  extend T::Sig
  extend T::Generic
  Elem = type_member(fixed: OldUser)

  sig { returns(OldUser::ActiveRecord_Relation) }
  def all; end

  sig { params(block: T.nilable(T.proc.void)).returns(OldUser::ActiveRecord_Relation) }
  def unscoped(&block); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def select(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def reselect(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def order(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def reorder(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def group(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def limit(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def offset(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def joins(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def left_joins(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def where(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def rewhere(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def preload(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def extract_associated(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def eager_load(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def includes(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def from(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def lock(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def readonly(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def or(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def having(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def create_with(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def distinct(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def references(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def none(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def unscope(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def optimizer_hints(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def merge(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def except(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_Relation) }
  def only(*args); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(OldUser::ActiveRecord_Relation) }
  def extending(*args, &block); end
end

class OldUser::ActiveRecord_AssociationRelation < ActiveRecord::AssociationRelation
  include OldUser::ActiveRelation_WhereNot
  include OldUser::CustomFinderMethods
  include Enumerable
  extend T::Sig
  extend T::Generic
  Elem = type_member(fixed: OldUser)

  sig { returns(OldUser::ActiveRecord_AssociationRelation) }
  def all; end

  sig { params(block: T.nilable(T.proc.void)).returns(OldUser::ActiveRecord_AssociationRelation) }
  def unscoped(&block); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def select(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def reselect(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def order(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def reorder(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def group(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def limit(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def offset(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def joins(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def left_joins(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def where(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def rewhere(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def preload(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def extract_associated(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def eager_load(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def includes(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def from(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def lock(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def readonly(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def or(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def having(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def create_with(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def distinct(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def references(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def none(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def unscope(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def optimizer_hints(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def merge(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def except(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def only(*args); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(OldUser::ActiveRecord_AssociationRelation) }
  def extending(*args, &block); end

  sig { params(args: T.untyped).returns(OldUser) }
  def find(*args); end

  sig { params(args: T.untyped).returns(T.nilable(OldUser)) }
  def find_by(*args); end

  sig { params(args: T.untyped).returns(OldUser) }
  def find_by!(*args); end

  sig { returns(T.nilable(OldUser)) }
  def first; end

  sig { returns(OldUser) }
  def first!; end

  sig { returns(T.nilable(OldUser)) }
  def second; end

  sig { returns(OldUser) }
  def second!; end

  sig { returns(T.nilable(OldUser)) }
  def third; end

  sig { returns(OldUser) }
  def third!; end

  sig { returns(T.nilable(OldUser)) }
  def third_to_last; end

  sig { returns(OldUser) }
  def third_to_last!; end

  sig { returns(T.nilable(OldUser)) }
  def second_to_last; end

  sig { returns(OldUser) }
  def second_to_last!; end

  sig { returns(T.nilable(OldUser)) }
  def last; end

  sig { returns(OldUser) }
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

  sig { override.params(block: T.proc.params(e: OldUser).void).returns(T::Array[OldUser]) }
  def each(&block); end

  sig { params(level: T.nilable(Integer)).returns(T::Array[OldUser]) }
  def flatten(level); end

  sig { returns(T::Array[OldUser]) }
  def to_a; end

  sig do
    type_parameters(:U).params(
        blk: T.proc.params(arg0: Elem).returns(T.type_parameter(:U)),
    )
    .returns(T::Array[T.type_parameter(:U)])
  end
  def map(&blk); end
end

class OldUser::ActiveRecord_Associations_CollectionProxy < ActiveRecord::Associations::CollectionProxy
  include OldUser::CustomFinderMethods
  include Enumerable
  extend T::Sig
  extend T::Generic
  Elem = type_member(fixed: OldUser)

  sig { returns(OldUser::ActiveRecord_AssociationRelation) }
  def all; end

  sig { params(block: T.nilable(T.proc.void)).returns(OldUser::ActiveRecord_AssociationRelation) }
  def unscoped(&block); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def select(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def reselect(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def order(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def reorder(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def group(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def limit(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def offset(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def joins(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def left_joins(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def where(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def rewhere(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def preload(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def extract_associated(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def eager_load(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def includes(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def from(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def lock(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def readonly(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def or(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def having(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def create_with(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def distinct(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def references(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def none(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def unscope(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def optimizer_hints(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def merge(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def except(*args); end

  sig { params(args: T.untyped).returns(OldUser::ActiveRecord_AssociationRelation) }
  def only(*args); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(OldUser::ActiveRecord_AssociationRelation) }
  def extending(*args, &block); end

  sig { params(args: T.untyped).returns(OldUser) }
  def find(*args); end

  sig { params(args: T.untyped).returns(T.nilable(OldUser)) }
  def find_by(*args); end

  sig { params(args: T.untyped).returns(OldUser) }
  def find_by!(*args); end

  sig { returns(T.nilable(OldUser)) }
  def first; end

  sig { returns(OldUser) }
  def first!; end

  sig { returns(T.nilable(OldUser)) }
  def second; end

  sig { returns(OldUser) }
  def second!; end

  sig { returns(T.nilable(OldUser)) }
  def third; end

  sig { returns(OldUser) }
  def third!; end

  sig { returns(T.nilable(OldUser)) }
  def third_to_last; end

  sig { returns(OldUser) }
  def third_to_last!; end

  sig { returns(T.nilable(OldUser)) }
  def second_to_last; end

  sig { returns(OldUser) }
  def second_to_last!; end

  sig { returns(T.nilable(OldUser)) }
  def last; end

  sig { returns(OldUser) }
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

  sig { override.params(block: T.proc.params(e: OldUser).void).returns(T::Array[OldUser]) }
  def each(&block); end

  sig { params(level: T.nilable(Integer)).returns(T::Array[OldUser]) }
  def flatten(level); end

  sig { returns(T::Array[OldUser]) }
  def to_a; end

  sig do
    type_parameters(:U).params(
        blk: T.proc.params(arg0: Elem).returns(T.type_parameter(:U)),
    )
    .returns(T::Array[T.type_parameter(:U)])
  end
  def map(&blk); end

  sig { params(records: T.any(OldUser, T::Array[OldUser])).returns(T.self_type) }
  def <<(*records); end

  sig { params(records: T.any(OldUser, T::Array[OldUser])).returns(T.self_type) }
  def append(*records); end

  sig { params(records: T.any(OldUser, T::Array[OldUser])).returns(T.self_type) }
  def push(*records); end

  sig { params(records: T.any(OldUser, T::Array[OldUser])).returns(T.self_type) }
  def concat(*records); end
end