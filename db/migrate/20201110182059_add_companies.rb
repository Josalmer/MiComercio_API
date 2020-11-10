class AddCompanies < ActiveRecord::Migration[6.0]
  def change
    # Categorias
    ["Ocio y Restauración", "Deportes", "Salud", "Belleza", "Moda"].each do |name|
      CompanyCategory.create(category: name)
    end
    # Tipos
    category = CompanyCategory.where(category: "Ocio y Restauración").first
    ["Bar", "Restaurante"].each do |name|
      CompanyType.create(company_category_id: category.id, company_type: name)
    end
    category = CompanyCategory.where(category: "Deportes").first
    ["Ropa y complementos deportivos", "Aventura y experiencias"].each do |name|
      CompanyType.create(company_category_id: category.id, company_type: name)
    end
    category = CompanyCategory.where(category: "Salud").first
    ["Clínica médica", "Clínica dental", "Clínica fisioterapia", "Cliníca podológica", "Balneario y spa"].each do |name|
      CompanyType.create(company_category_id: category.id, company_type: name)
    end
    category = CompanyCategory.where(category: "Belleza").first
    ["Clínica estética", "Peluquería y estética", "Tienda de cosméticos", "Perfumería"].each do |name|
      CompanyType.create(company_category_id: category.id, company_type: name)
    end
    category = CompanyCategory.where(category: "Moda").first
    ["Ropa y complementos", "Zapatería", "Joyería"].each do |name|
      CompanyType.create(company_category_id: category.id, company_type: name)
    end
  end
end
