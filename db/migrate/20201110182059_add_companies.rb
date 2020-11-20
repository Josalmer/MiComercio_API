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

    # Negocios
    user = User.where(email: "josaldmer@gmail.com").first

    type = CompanyType.where(company_type: "Bar").first
    name = "Casa Pepe"
    web = "www.casapepe.com"
    mail = "contacto@casapepe.es"
    phone = "612345678"
    description = "Ven a disfrutar de la comida tradicional y la cerveza mas fria en Casa Pepe."
    Company.create(user_id: user.id, company_type_id: type.id, name: name, web: web, mail: mail, phone: phone, description: description)

    type = CompanyType.where(company_type: "Clínica fisioterapia").first
    name = "Músculos sanos"
    web = "www.musculossanos.com"
    mail = "contacto@musculossanos.es"
    phone = "612345679"
    description = "En músculos sanos llevamos más de 20 años al servicio de nuestros clientes, la confianza de todos ellos nos avala."
    Company.create(user_id: user.id, company_type_id: type.id, name: name, web: web, mail: mail, phone: phone, description: description)

    type = CompanyType.where(company_type: "Aventura y experiencias").first
    name = "Multiaventura Monachil"
    web = "www.multiaventuramonachil.com"
    mail = "contacto@multiaventuramonachil.es"
    phone = "612345680"
    description = "Para pasar un día inolvidable con la familia en un entorno natural, tirolinas, pasarelas y zona de camping."
    Company.create(user_id: user.id, company_type_id: type.id, name: name, web: web, mail: mail, phone: phone, description: description)

    type = CompanyType.where(company_type: "Joyería").first
    name = "Endiamantados"
    web = "www.endiamantados.com"
    mail = "contacto@endiamantados.es"
    phone = "612345681"
    description = "En Endiamantandos encontraras los mejores diamantes de Granada, tambén joyería en oro blanco y oro."
    Company.create(user_id: user.id, company_type_id: type.id, name: name, web: web, mail: mail, phone: phone, description: description)

    type = CompanyType.where(company_type: "Ropa y complementos").first
    name = "Botique de Rocío"
    web = "www.boutiquederocio.com"
    mail = "contacto@boutiquederocio.es"
    phone = "612345682"
    description = "En la Boutique de Rocío encontrarás todo lo que necesitas para ir a la última."
    Company.create(user_id: user.id, company_type_id: type.id, name: name, web: web, mail: mail, phone: phone, description: description)

    type = CompanyType.where(company_type: "Peluquería y estética").first
    name = "Juan García Peluqueros"
    web = "www.juangarcia.com"
    mail = "contacto@juangarcia.es"
    phone = "612345683"
    description = "Juan García peluqueros, una peluquería para hombres con personalidad."
    Company.create(user_id: user.id, company_type_id: type.id, name: name, web: web, mail: mail, phone: phone, description: description)

  end
end
