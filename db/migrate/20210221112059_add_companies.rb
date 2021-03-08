class AddCompanies < ActiveRecord::Migration[6.0]
  def change

    # Categorias
    ["Ocio y Restauración", "Deportes", "Salud", "Belleza", "Moda", "Alimentación", "Educación"].each do |name|
      CompanyCategory.create(category: name)
    end

    # Tipos
    category = CompanyCategory.where(category: "Ocio y Restauración").first
    ["Bar", "Restaurante", "Cafetería"].each do |name|
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
    category = CompanyCategory.where(category: "Alimentación").first
    ["Panadería", "Frutería", "Carnicería"].each do |name|
      CompanyType.create(company_category_id: category.id, company_type: name)
    end
    category = CompanyCategory.where(category: "Educación").first
    ["Colegio", "Escuela Superior"].each do |name|
      CompanyType.create(company_category_id: category.id, company_type: name)
    end

    User.create(name: "Admin", admin: true, organization_manager: false, email: "admin@mail.com", password: "123456")
    User.create(name: "Jose", surname: "Saldaña", admin: false, organization_manager: true, email: "manager1@mail.com", password: "123456")
    User.create(name: "Alvaro", surname: "Saldaña", admin: false, organization_manager: true, email: "manager2@mail.com", password: "123456")
    User.create(name: "Andrea", surname: "Saldaña", admin: false, organization_manager: true, email: "manager3@mail.com", password: "123456")
    # Negocios
    user = User.where(email: "manager1@mail.com").first
    user2 = User.where(email: "manager2@mail.com").first
    user3 = User.where(email: "manager3@mail.com").first

    type = CompanyType.where(company_type: "Bar").first
    name = "Casa Pepe"
    web = "www.casapepe.com"
    mail = "contacto@casapepe.es"
    phone = "612345678"
    description = "Ven a disfrutar de la comida tradicional y la cerveza mas fria en Casa Pepe."
    Company.create(user_id: user.id, company_type_id: type.id, name: name, web: web, mail: mail, phone: phone, description: description)

    type = CompanyType.where(company_type: "Bar").first
    name = "Casa Juan"
    web = "www.casajuan.com"
    mail = "contacto@casajuan.es"
    phone = "612345678"
    description = "Restaurante familiar donde puedes desayunar, comer y cenar de manera fantástica por su relación calidad precio."
    Company.create(user_id: user.id, company_type_id: type.id, name: name, web: web, mail: mail, phone: phone, description: description)

    type = CompanyType.where(company_type: "Bar").first
    name = "Casa Paco"
    web = "www.casapaco.com"
    mail = "contacto@casapaco.es"
    phone = "612345678"
    description = "A un par de calles de la Gran Vía, se esconde uno de esos rincones que guarda la esencia de las bodegas con solera en las que importa el contenido y el continente."
    Company.create(user_id: user.id, company_type_id: type.id, name: name, web: web, mail: mail, phone: phone, description: description)

    type = CompanyType.where(company_type: "Restaurante").first
    name = "Los Pablos"
    web = "www.lospablos.com"
    mail = "contacto@lospablos.es"
    phone = "612345678"
    description = "Este bar con más de cien años de vida es un ícono de la gastronomía local no solamente por sus croquetas sino por su tortilla de sacromonte o sus habas con jamón. Platos tradicionales para uno de los rincones que buscan más intensamente los turistas que llegan a Granada. La buena fama es lo que tiene."
    Company.create(user_id: user.id, company_type_id: type.id, name: name, web: web, mail: mail, phone: phone, description: description)

    type = CompanyType.where(company_type: "Restaurante").first
    name = "Mesón Rocío"
    web = "www.mesonrocio.com"
    mail = "contacto@mesonrocio.es"
    phone = "612345678"
    description = "Especialidades como el bocata de habas con jamón, el de morcilla o el de perrito caliente. Aunque también se puede disfrutar de buenas tapas de arroz, migas, ensaladilla o salpicón y de raciones de croquetas, flamenquín o un caldo caliente."
    Company.create(user_id: user.id, company_type_id: type.id, name: name, web: web, mail: mail, phone: phone, description: description)

    type = CompanyType.where(company_type: "Bar").first
    name = "Bar La Luna"
    web = "www.laluna.com"
    mail = "contacto@laluna.es"
    phone = "612345678"
    description = "Desde el 1947 lleva La Luna ofreciendo rapidez, cercanía y buenos momentos a los granadinos con un variado tablón de bocadillos fríos y calientes."
    Company.create(user_id: user3.id, company_type_id: type.id, name: name, web: web, mail: mail, phone: phone, description: description)

    type = CompanyType.where(company_type: "Clínica dental").first
    name = "Ortodoncia Dr. Gallardo"
    web = "www.doctoresgallardo.com"
    mail = "contacto@doctoresgallardo.es"
    phone = "612345678"
    description = "Clínica dental con modernos aparatos y tratamientos de ortodoncia, enfermedades y afecciones periodontales."
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
    Company.create(user_id: user2.id, company_type_id: type.id, name: name, web: web, mail: mail, phone: phone, description: description)

    type = CompanyType.where(company_type: "Peluquería y estética").first
    name = "Juan García Peluqueros"
    web = "www.juangarcia.com"
    mail = "contacto@juangarcia.es"
    phone = "612345683"
    description = "Juan García peluqueros, una peluquería para hombres con personalidad."
    Company.create(user_id: user3.id, company_type_id: type.id, name: name, web: web, mail: mail, phone: phone, description: description)

    type = CompanyType.where(company_type: "Panadería").first
    name = "Panadería Pablo Santiago"
    web = "www.pablo.com"
    mail = "contacto@pablo.es"
    phone = "612345683"
    description = "Panadería artesana, especialidad pan rústico de Alfacar. Bollería. Repostería. Tartas por encargo. Dulces de temporada"
    Company.create(user_id: user.id, company_type_id: type.id, name: name, web: web, mail: mail, phone: phone, description: description)

    type = CompanyType.where(company_type: "Cafetería").first
    name = "Café Sol"
    web = "www.sol.com"
    mail = "contacto@sol.es"
    phone = "612345683"
    description = "Cafetería con atractiva y acogedora decoración."
    Company.create(user_id: user3.id, company_type_id: type.id, name: name, web: web, mail: mail, phone: phone, description: description)

    type = CompanyType.where(company_type: "Cafetería").first
    name = "Cafetería Pastelería Monachil"
    web = "www.pastelesmonachil.com"
    mail = "contacto@pastelesmonachil.es"
    phone = "612345683"
    description = "Cafetería. Obrador propio artesano: Pastelería, Bollería, Tartas, Dulces Tradicionales... . Disfrute en un ambiente agradable de desayunos y meriendas, en interior o en terraza. Encargos y Pedidos, Servicio a Domicilio"
    Company.create(user_id: user2.id, company_type_id: type.id, name: name, web: web, mail: mail, phone: phone, description: description)

    type = CompanyType.where(company_type: "Clínica médica").first
    name = "Clínica Doctor Morales"
    web = "www.doctormorales.com"
    mail = "contacto@doctormorales.es"
    phone = "612345683"
    description = "Somos una clínica médica de Granada especializada en análisis, PCR, vasectomías, hemorroides y circuncisión. Contamos con un equipo joven y una larga experiencia."
    Company.create(user_id: user.id, company_type_id: type.id, name: name, web: web, mail: mail, phone: phone, description: description)

    type = CompanyType.where(company_type: "Frutería").first
    name = "Frutas Bolívar"
    web = "www.bolivar.com"
    mail = "contacto@bolivar.es"
    phone = "612345683"
    description = "Productos alimenticios deshidratados. Un sabor tradicional también puede ser moderno. Fácil, sano y sin complicaciones"
    Company.create(user_id: user.id, company_type_id: type.id, name: name, web: web, mail: mail, phone: phone, description: description)

    type = CompanyType.where(company_type: "Carnicería").first
    name = "La Picanta de Marcelo"
    web = "www.picantamarcelo.com"
    mail = "contacto@picantamarcelo.es"
    phone = "612345683"
    description = "Hacemos una selección de los mejores productos, para ofrecer a nuestros clientes una calidad inmejorable"
    Company.create(user_id: user.id, company_type_id: type.id, name: name, web: web, mail: mail, phone: phone, description: description)

    type = CompanyType.where(company_type: "Carnicería").first
    name = "La Picanta de Manuel"
    web = "www.picantamanuel.com"
    mail = "contacto@picantamanuel.es"
    phone = "612345683"
    description = "Tradición, confianza y calidad en cada uno de nuestros productos."
    Company.create(user_id: user2.id, company_type_id: type.id, name: name, web: web, mail: mail, phone: phone, description: description)

    type = CompanyType.where(company_type: "Peluquería y estética").first
    name = "Magdalena Fernandez Peluqueros"
    web = "www.magdalenafernandez.com"
    mail = "contacto@magdalenafernandez.es"
    phone = "612345683"
    description = "Magdalena Fernandez Peluqueros es una elegante peluquería ubicada en el centro de Granada en el que realizarse el mejor corte de pelo o cambio de look."
    Company.create(user_id: user.id, company_type_id: type.id, name: name, web: web, mail: mail, phone: phone, description: description)

    type = CompanyType.where(company_type: "Peluquería y estética").first
    name = "Salón Belleza"
    web = "www.salonbelleza.com"
    mail = "contacto@salonbelleza.es"
    phone = "612345683"
    description = "Salón Belleza es un centro de peluquería y estética que busca un vínculo con sus clientes para prestar la mejor experiencia que les diferencia del resto de peluquerías."
    Company.create(user_id: user.id, company_type_id: type.id, name: name, web: web, mail: mail, phone: phone, description: description)

    type = CompanyType.where(company_type: "Peluquería y estética").first
    name = "Estefanía Per"
    web = "www.estefaniaper.com"
    mail = "contacto@estefaniaper.es"
    phone = "612345683"
    description = "El compromiso de Estefanía Per con la calidad y el trabajo bien hecho es su mejor carta de presentación."
    Company.create(user_id: user.id, company_type_id: type.id, name: name, web: web, mail: mail, phone: phone, description: description)

    type = CompanyType.where(company_type: "Balneario y spa").first
    name = "Balnearium Granada"
    web = "www.balneariumgranada.com"
    mail = "contacto@balneariumgranada.es"
    phone = "612345683"
    description = "El Balnearium Granada se encuentra a 5 minutos a pie de la estación de tren del AVE y ofrece una piscina y un solárium en la azotea con vistas a la ciudad y servicio de bar."
    Company.create(user_id: user.id, company_type_id: type.id, name: name, web: web, mail: mail, phone: phone, description: description)

    type = CompanyType.where(company_type: "Cliníca podológica").first
    name = "Pies sanos"
    web = "www.piessanos.com"
    mail = "contacto@piessanos.es"
    phone = "612345683"
    description = "En pies sanos cuidamos de lo que más importa, sus pies."
    Company.create(user_id: user3.id, company_type_id: type.id, name: name, web: web, mail: mail, phone: phone, description: description)

    type = CompanyType.where(company_type: "Ropa y complementos deportivos").first
    name = "Bicicletas Rafa"
    web = "www.bicicletasrafa.com"
    mail = "contacto@bicicletasrafa.es"
    phone = "612345683"
    description = "Tu tienda de bicicletas en Granada. Bicicletas de carretera y montaña. Ebikes. Servicio oficial Cannondale, Specialized, Giant y Orbea. Disponemos de taller para tu bici ofreciendo los mejores servicios de mecánica."
    Company.create(user_id: user.id, company_type_id: type.id, name: name, web: web, mail: mail, phone: phone, description: description)

  end
end
