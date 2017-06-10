class ApplicationPolicy
  module Shortcuts
    protected

    def admin?
      context.user && context.user.admin?
    end
  end

  class Scope
    include Shortcuts

    attr_reader :context, :scope, :page

    def initialize(context, scope, page = nil)
      @context = context
      @scope = scope
      @page = page || 0
    end

    def resolve
      scope
    end
  end

  include Shortcuts

  attr_reader :context, :record

  def initialize(context, record)
    @context = context
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(context, record.class)
  end
end
