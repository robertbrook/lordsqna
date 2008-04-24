
# e.g. assert_model_has_many Answer, :questions
def assert_model_has_many(model, association_name)
  association = model.reflect_on_association(association_name.to_sym)
  assert_not_nil association, "Could not find an association for #{association_name}"

  assert_equal :has_many, association.macro

  assert association.klass.column_names.include?(association.primary_key_name)
end

