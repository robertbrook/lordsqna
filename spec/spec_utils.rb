
# e.g. assert_model_has_many Answer, :questions
def assert_model_has_many(model, association_name)
  assert_association_exists model, :has_many, association_name
end

# e.g. assert_model_belongs_to Question, :answer
def assert_model_belongs_to(model, association_name)
  assert_association_exists model, :belongs_to, association_name, model_with_foreign_key=model
end

def assert_association_exists model, association_macro, association_name, model_with_foreign_key=nil
  association = model.reflect_on_association(association_name.to_sym)
  assert_not_nil association, "Could not find an association for #{association_name}"
  assert_equal association_macro, association.macro
  model_with_foreign_key = model_with_foreign_key || association.klass
  begin
    association.klass
  rescue Exception => e
    class_name = association.options[:class_name]
    unless class_name
      klass = e.to_s[/uninitialized constant .*::(.+)/, 1]
      raise "Could not find class #{klass} for association #{association_name}, try defining :class_name in the #{association_macro} association declaration."
    else
      unless class_name.is_a? String
        raise "Could not define association #{association_name} because the defined :class_name #{class_name} is not a String"
      end
    end
  end

  assert model_with_foreign_key.column_names.include?(association.primary_key_name), "Could not find foreign key '#{association.primary_key_name}' for the association '#{association_name}' in the table for model '#{model_with_foreign_key}'."
end
